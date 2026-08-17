const { Pool } = require("pg");
require("dotenv").config();

const pool = new Pool({
  host: process.env.DB_HOST || "localhost",
  port: process.env.DB_PORT || 5432,
  user: process.env.DB_USER || "marketplace_user",
  password: process.env.DB_PASSWORD || "marketplace_dev_password",
  database: process.env.DB_NAME || "student_marketplace",
});

pool.on("connect", () => {
  console.log("✅ Auth Service PostgreSQL connected");
});

pool.on("error", (error) => {
  console.error(
    "❌ Auth Service PostgreSQL pool error:",
    error
  );
});

module.exports = pool;
