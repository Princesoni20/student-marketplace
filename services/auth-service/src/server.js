const express = require("express");
const cors = require("cors");
require("dotenv").config();

const pool = require("./config/db");
const authRoutes = require("./routes/auth.routes");

const app = express();

const PORT = process.env.PORT || 5002;

/*
 * =====================================================
 * MIDDLEWARE
 * =====================================================
 */

app.use(cors());
app.use(express.json());

/*
 * =====================================================
 * HEALTH CHECK
 * =====================================================
 */

app.get("/health", async (req, res) => {
  try {
    await pool.query("SELECT 1");

    res.status(200).json({
      success: true,
      service: "auth-service",
      database: "connected",
    });
  } catch (error) {
    console.error(
      "Auth database health error:",
      error.message
    );

    res.status(503).json({
      success: false,
      service: "auth-service",
      database: "disconnected",
    });
  }
});

/*
 * =====================================================
 * AUTH ROUTES
 * =====================================================
 *
 * POST /api/auth/register
 * POST /api/auth/login
 * GET  /api/auth/me
 *
 */

app.use(
  "/api/auth",
  authRoutes
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
      "Unhandled Auth Service error:",
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
    await pool.query("SELECT 1");

    console.log(
      "✅ Auth Service PostgreSQL connection verified"
    );

    app.listen(PORT, () => {
      console.log(
        `🚀 Auth Service running on http://localhost:${PORT}`
      );
    });
  } catch (error) {
    console.error(
      "❌ Failed to start Auth Service:",
      error.message
    );

    process.exit(1);
  }
};

startServer();
