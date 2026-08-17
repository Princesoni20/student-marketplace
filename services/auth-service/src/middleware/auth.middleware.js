const jwt = require("jsonwebtoken");

/*
 * =====================================================
 * JWT AUTHENTICATION MIDDLEWARE
 * =====================================================
 */
const authenticateToken = (
  req,
  res,
  next
) => {
  try {
    const authHeader =
      req.headers.authorization;

    /*
     * Expected format:
     *
     * Authorization: Bearer <token>
     */
    if (!authHeader) {
      return res.status(401).json({
        success: false,
        message:
          "Authentication token is required",
      });
    }

    const parts =
      authHeader.split(" ");

    if (
      parts.length !== 2 ||
      parts[0] !== "Bearer"
    ) {
      return res.status(401).json({
        success: false,
        message:
          "Invalid authorization format",
      });
    }

    const token = parts[1];

    if (!token) {
      return res.status(401).json({
        success: false,
        message:
          "Authentication token is required",
      });
    }

    /*
     * Verify JWT
     */
    const decoded =
      jwt.verify(
        token,
        process.env.JWT_SECRET
      );

    /*
     * Make authenticated user
     * available to following routes.
     */
    req.user = decoded;

    next();
  } catch (error) {
    console.error(
      "JWT AUTH ERROR:",
      error.message
    );

    if (
      error.name ===
      "TokenExpiredError"
    ) {
      return res.status(401).json({
        success: false,
        message:
          "Authentication token has expired",
      });
    }

    return res.status(401).json({
      success: false,
      message:
        "Invalid authentication token",
    });
  }
};

module.exports = {
  authenticateToken,
};
