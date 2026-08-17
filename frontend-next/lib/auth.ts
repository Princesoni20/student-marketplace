const AUTH_API_URL =
  process.env.NEXT_PUBLIC_AUTH_API_URL ||
  "http://localhost:5002/api/auth";

export interface AuthUser {
  id: string;
  firstName: string;
  lastName: string | null;
  email: string;
  phone: string | null;
  avatarUrl: string | null;
  role: string;
}

interface AuthResponse {
  success: boolean;
  message?: string;
  data?: {
    user?: AuthUser;
    token?: string;
  };
}

interface MeResponse {
  success: boolean;
  message?: string;
  data?: AuthUser;
}

/*
 * =====================================================
 * REGISTER
 * =====================================================
 */

export async function registerUser(input: {
  firstName: string;
  lastName?: string;
  email: string;
  password: string;
  phone?: string;
}): Promise<AuthResponse> {
  const response = await fetch(
    `${AUTH_API_URL}/register`,
    {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(input),
    }
  );

  const data =
    (await response.json()) as AuthResponse;

  if (!response.ok) {
    throw new Error(
      data.message ||
        "Unable to create account"
    );
  }

  return data;
}

/*
 * =====================================================
 * LOGIN
 * =====================================================
 */

export async function loginUser(input: {
  email: string;
  password: string;
}): Promise<AuthResponse> {
  const response = await fetch(
    `${AUTH_API_URL}/login`,
    {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(input),
    }
  );

  const data =
    (await response.json()) as AuthResponse;

  if (!response.ok) {
    throw new Error(
      data.message ||
        "Unable to login"
    );
  }

  return data;
}

/*
 * =====================================================
 * CURRENT USER
 * =====================================================
 */

export async function getCurrentUser(
  token: string
): Promise<MeResponse> {
  const response = await fetch(
    `${AUTH_API_URL}/me`,
    {
      method: "GET",
      headers: {
        Authorization: `Bearer ${token}`,
      },
      cache: "no-store",
    }
  );

  const data =
    (await response.json()) as MeResponse;

  if (!response.ok) {
    throw new Error(
      data.message ||
        "Unable to fetch current user"
    );
  }

  return data;
}

/*
 * =====================================================
 * TOKEN HELPERS
 * =====================================================
 */

const AUTH_TOKEN_KEY =
  "student-marketplace-auth-token";

export function saveAuthToken(
  token: string
) {
  if (typeof window === "undefined") {
    return;
  }

  localStorage.setItem(
    AUTH_TOKEN_KEY,
    token
  );
}

export function getAuthToken(): string | null {
  if (typeof window === "undefined") {
    return null;
  }

  return localStorage.getItem(
    AUTH_TOKEN_KEY
  );
}

export function removeAuthToken() {
  if (typeof window === "undefined") {
    return;
  }

  localStorage.removeItem(
    AUTH_TOKEN_KEY
  );
}

/*
 * =====================================================
 * LOGOUT
 * =====================================================
 */

export function logoutUser() {
  removeAuthToken();

  if (typeof window !== "undefined") {
    window.dispatchEvent(
      new Event(
        "student-marketplace-auth-updated"
      )
    );
  }
}