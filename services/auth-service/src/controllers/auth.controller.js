const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const pool = require("../config/db");

const USER_ROLE_ID =
  "2b73fc4c-c370-49cd-acf9-1389f4cd3a23";

/*
 * Generate JWT
 */
const generateToken = (user) => {
  return jwt.sign(
    {
      id: user.id,
      email: user.email,
      role: user.role_name,
    },
    process.env.JWT_SECRET,
    {
      expiresIn: process.env.JWT_EXPIRES_IN || "7d",
    }
  );
};

/*
 * =====================================================
 * REGISTER
 * =====================================================
 */
const register = async (req, res) => {
  try {
    const {
      firstName,
      lastName,
      email,
      password,
      phone,
    } = req.body;

    if (
      !firstName ||
      !email ||
      !password
    ) {
      return res.status(400).json({
        success: false,
        message:
          "First name, email and password are required",
      });
    }

    if (password.length < 6) {
      return res.status(400).json({
        success: false,
        message:
          "Password must be at least 6 characters",
      });
    }

    const normalizedEmail =
      email.trim().toLowerCase();

    /*
     * Check existing user
     */
    const existingUser =
      await pool.query(
        `SELECT id
         FROM users
         WHERE LOWER(email) = $1
         LIMIT 1`,
        [normalizedEmail]
      );

    if (existingUser.rows.length > 0) {
      return res.status(409).json({
        success: false,
        message:
          "An account with this email already exists",
      });
    }

    /*
     * Hash password
     */
    const passwordHash =
      await bcrypt.hash(password, 12);

    /*
     * Create user with normal USER role.
     *
     * Admin role can NOT be selected
     * through public registration.
     */
    const result =
      await pool.query(
        `INSERT INTO users
          (
            role_id,
            first_name,
            last_name,
            email,
            password_hash,
            phone
          )
         VALUES
          ($1, $2, $3, $4, $5, $6)
         RETURNING
          id,
          role_id,
          first_name,
          last_name,
          email,
          phone,
          avatar_url`,
        [
          USER_ROLE_ID,
          firstName.trim(),
          lastName
            ? lastName.trim()
            : null,
          normalizedEmail,
          passwordHash,
          phone
            ? phone.trim()
            : null,
        ]
      );

    const user = result.rows[0];

    /*
     * Get role name
     */
    const roleResult =
      await pool.query(
        `SELECT name
         FROM roles
         WHERE id = $1`,
        [user.role_id]
      );

    const roleName =
      roleResult.rows[0]?.name || "user";

    user.role_name = roleName;

    const token =
      generateToken(user);

    return res.status(201).json({
      success: true,
      message:
        "Account created successfully",
      data: {
        user: {
          id: user.id,
          firstName: user.first_name,
          lastName: user.last_name,
          email: user.email,
          phone: user.phone,
          avatarUrl: user.avatar_url,
          role: roleName,
        },
        token,
      },
    });
  } catch (error) {
    console.error(
      "REGISTER ERROR:",
      error
    );

    return res.status(500).json({
      success: false,
      message:
        "Unable to create account",
    });
  }
};

/*
 * =====================================================
 * LOGIN
 * =====================================================
 */
const login = async (req, res) => {
  try {
    const {
      email,
      password,
    } = req.body;

    if (!email || !password) {
      return res.status(400).json({
        success: false,
        message:
          "Email and password are required",
      });
    }

    const normalizedEmail =
      email.trim().toLowerCase();

    /*
     * Find user + role
     */
    const result =
      await pool.query(
        `SELECT
          u.id,
          u.role_id,
          u.first_name,
          u.last_name,
          u.email,
          u.password_hash,
          u.phone,
          u.avatar_url,
          r.name AS role_name
         FROM users u
         JOIN roles r
           ON r.id = u.role_id
         WHERE LOWER(u.email) = $1
         LIMIT 1`,
        [normalizedEmail]
      );

    if (result.rows.length === 0) {
      return res.status(401).json({
        success: false,
        message:
          "Invalid email or password",
      });
    }

    const user = result.rows[0];

    /*
     * Compare password
     */
    const passwordMatched =
      await bcrypt.compare(
        password,
        user.password_hash
      );

    if (!passwordMatched) {
      return res.status(401).json({
        success: false,
        message:
          "Invalid email or password",
      });
    }

    const token =
      generateToken(user);

    return res.status(200).json({
      success: true,
      message:
        "Login successful",
      data: {
        user: {
          id: user.id,
          firstName: user.first_name,
          lastName: user.last_name,
          email: user.email,
          phone: user.phone,
          avatarUrl: user.avatar_url,
          role: user.role_name,
        },
        token,
      },
    });
  } catch (error) {
    console.error(
      "LOGIN ERROR:",
      error
    );

    return res.status(500).json({
      success: false,
      message:
        "Unable to login",
    });
  }
};

/*
 * =====================================================
 * CURRENT USER
 * =====================================================
 */
const getMe = async (req, res) => {
  try {
    const result =
      await pool.query(
        `SELECT
          u.id,
          u.first_name,
          u.last_name,
          u.email,
          u.phone,
          u.avatar_url,
          r.name AS role_name
         FROM users u
         JOIN roles r
           ON r.id = u.role_id
         WHERE u.id = $1
         LIMIT 1`,
        [req.user.id]
      );

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: "User not found",
      });
    }

    const user = result.rows[0];

    return res.status(200).json({
      success: true,
      data: {
        id: user.id,
        firstName: user.first_name,
        lastName: user.last_name,
        email: user.email,
        phone: user.phone,
        avatarUrl: user.avatar_url,
        role: user.role_name,
      },
    });
  } catch (error) {
    console.error(
      "GET ME ERROR:",
      error
    );

    return res.status(500).json({
      success: false,
      message:
        "Unable to fetch user",
    });
  }
};

module.exports = {
  register,
  login,
  getMe,
};
