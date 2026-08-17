const { Pool } = require("pg");
require("dotenv").config();

const pool = new Pool({
  host: process.env.DB_HOST || "localhost",
  port: Number(process.env.DB_PORT || 5433),
  user:
    process.env.DB_USER ||
    "marketplace_user",
  password:
    process.env.DB_PASSWORD ||
    "marketplace_dev_password",
  database:
    process.env.DB_NAME ||
    "student_marketplace",
});

pool.on("connect", () => {
  console.log("✅ PostgreSQL connected");
});

pool.on("error", (err) => {
  console.error(
    "❌ PostgreSQL pool error:",
    err
  );
});

module.exports = pool;