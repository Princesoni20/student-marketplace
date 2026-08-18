const express = require("express");
const cors = require("cors");
require("dotenv").config();

const pool = require("./config/db");

const {
  connectRedis,
  getRedis,
} = require("./config/redis");

const productRoutes = require("./routes/product.routes");

const app = express();

const PORT = process.env.PORT || 5001;

app.use(cors());
app.use(express.json());

/*
 * =====================================================
 * HEALTH CHECK
 * =====================================================
 */

app.get("/health", async (req, res) => {
  let database = "disconnected";
  let redis = "disconnected";

  try {
    await pool.query("SELECT 1");

    database = "connected";
  } catch (error) {
    console.error(
      "Database health check error:",
      error.message
    );
  }

  try {
    await connectRedis();

    const redisClient = getRedis();

    if (redisClient.isReady) {
      redis = "connected";
    }
  } catch (error) {
    console.error(
      "Redis health check error:",
      error.message
    );
  }

  const healthy =
    database === "connected" &&
    redis === "connected";

  res.status(healthy ? 200 : 503).json({
    success: healthy,
    service: "product-service",
    database,
    redis,
  });
});

/*
 * =====================================================
 * PRODUCT ROUTES
 * =====================================================
 */

app.use(
  "/api/products",
  productRoutes
);

/*
 * =====================================================
 * 404 HANDLER
 * =====================================================
 */

app.use((req, res) => {
  res.status(404).json({
    success: false,
    message: "Route not found",
  });
});

/*
 * =====================================================
 * ERROR HANDLER
 * =====================================================
 */

app.use(
  (error, req, res, next) => {
    console.error(
      "Unhandled error:",
      error
    );

    res.status(500).json({
      success: false,
      message: "Internal server error",
    });
  }
);

/*
 * =====================================================
 * START SERVER
 * =====================================================
 */

const startServer = async () => {
  try {
    await connectRedis();

    await pool.query("SELECT 1");

    console.log(
      "✅ PostgreSQL connection verified"
    );

    console.log(
      "✅ Redis connection verified"
    );

    app.listen(PORT, "0.0.0.0", () => {
  console.log(
    `🚀 Product Service running on port ${PORT}`
  );
});
  } catch (error) {
    console.error(
      "❌ Failed to start Product Service:",
      error.message
    );

    process.exit(1);
  }
};

startServer();