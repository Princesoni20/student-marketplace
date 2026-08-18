const { Pool } = require("pg");
require("dotenv").config();

const databaseUrl = process.env.DATABASE_URL;

const pool = new Pool({
  connectionString: databaseUrl,

  ssl:
    process.env.NODE_ENV === "production"
      ? {
          rejectUnauthorized: false,
        }
      : false,

  max: 5,
  connectionTimeoutMillis: 10000,
  idleTimeoutMillis: 30000,
  keepAlive: true,
});

pool.on("connect", () => {
  console.log("✅ Product Service PostgreSQL connected");
});

pool.on("error", (error) => {
  console.error(
    "❌ Product Service PostgreSQL pool error:",
    error.message
  );
});

module.exports = pool;
