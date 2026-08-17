const express = require("express");

const {
  register,
  login,
  getMe,
} = require("../controllers/auth.controller");

const {
  authenticateToken,
} = require("../middleware/auth.middleware");

const router = express.Router();

/*
 * =====================================================
 * REGISTER
 * POST /api/auth/register
 * =====================================================
 */
router.post(
  "/register",
  register
);

/*
 * =====================================================
 * LOGIN
 * POST /api/auth/login
 * =====================================================
 */
router.post(
  "/login",
  login
);

/*
 * =====================================================
 * CURRENT USER
 * GET /api/auth/me
 *
 * Protected by JWT
 * =====================================================
 */
router.get(
  "/me",
  authenticateToken,
  getMe
);

module.exports = router;
