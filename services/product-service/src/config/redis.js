const { createClient } = require("redis");

const redisUrl =
  process.env.REDIS_URL || "redis://localhost:6379";

const redisClient = createClient({
  url: redisUrl,
});

redisClient.on("error", (error) => {
  console.error("Redis Client Error:", error.message);
});

redisClient.on("connect", () => {
  console.log("🔌 Connecting to Redis...");
});

redisClient.on("ready", () => {
  console.log("✅ Redis is ready");
});

redisClient.on("reconnecting", () => {
  console.log("🔄 Redis reconnecting...");
});

let redisConnected = false;

const connectRedis = async () => {
  if (redisConnected && redisClient.isReady) {
    return;
  }

  if (!redisClient.isOpen) {
    await redisClient.connect();
  }

  redisConnected = true;
};

const getRedis = () => {
  return redisClient;
};

module.exports = {
  connectRedis,
  getRedis,
};