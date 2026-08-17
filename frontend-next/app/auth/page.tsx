"use client";

import Link from "next/link";
import { FormEvent, useState } from "react";
import {
  loginUser,
  registerUser,
  saveAuthToken,
} from "../../lib/auth";

type Mode = "login" | "register";

export default function AuthPage() {
  const [mode, setMode] =
    useState<Mode>("login");

  const [firstName, setFirstName] =
    useState("");

  const [lastName, setLastName] =
    useState("");

  const [email, setEmail] =
    useState("");

  const [password, setPassword] =
    useState("");

  const [phone, setPhone] =
    useState("");

  const [loading, setLoading] =
    useState(false);

  const [error, setError] =
    useState("");

  const [success, setSuccess] =
    useState("");

  const handleSubmit = async (
    event: FormEvent<HTMLFormElement>
  ) => {
    event.preventDefault();

    setError("");
    setSuccess("");
    setLoading(true);

    try {
      if (mode === "register") {
        if (!firstName.trim()) {
          throw new Error(
            "First name is required."
          );
        }

        if (password.length < 6) {
          throw new Error(
            "Password must be at least 6 characters."
          );
        }

        const response =
          await registerUser({
            firstName:
              firstName.trim(),
            lastName:
              lastName.trim(),
            email:
              email.trim(),
            password,
            phone:
              phone.trim(),
          });

        const token =
          response.data?.token;

        if (!token) {
          throw new Error(
            "Account created but authentication token was not received."
          );
        }

        saveAuthToken(token);

        setSuccess(
          "Account created successfully. Redirecting..."
        );

        window.setTimeout(() => {
          window.location.href =
            "/";
        }, 700);

        return;
      }

      const response =
        await loginUser({
          email:
            email.trim(),
          password,
        });

      const token =
        response.data?.token;

      if (!token) {
        throw new Error(
          "Login successful but authentication token was not received."
        );
      }

      saveAuthToken(token);

      setSuccess(
        "Login successful. Redirecting..."
      );

      window.setTimeout(() => {
        window.location.href =
          "/";
      }, 700);
    } catch (err) {
      setError(
        err instanceof Error
          ? err.message
          : "Something went wrong. Please try again."
      );
    } finally {
      setLoading(false);
    }
  };

  const switchMode = (
    nextMode: Mode
  ) => {
    setMode(nextMode);
    setError("");
    setSuccess("");
  };

  return (
    <main className="min-h-screen bg-[#f6f8fc] px-5 py-10">
      <div className="mx-auto flex min-h-[85vh] max-w-5xl items-center justify-center">
        <div className="grid w-full overflow-hidden rounded-3xl border border-slate-200 bg-white shadow-xl md:grid-cols-2">

          {/* LEFT SIDE */}
          <section className="hidden bg-gradient-to-br from-blue-600 to-violet-700 p-10 text-white md:block">
            <div className="flex h-full flex-col justify-between">
              <div>
                <Link
                  href="/"
                  className="text-lg font-black"
                >
                  🎓 Student Marketplace
                </Link>

                <div className="mt-20">
                  <div className="text-sm font-black uppercase tracking-[0.2em] text-blue-100">
                    Student Account
                  </div>

                  <h1 className="mt-4 text-5xl font-black leading-tight">
                    Your marketplace,
                    <br />
                    your account.
                  </h1>

                  <p className="mt-5 max-w-md text-base leading-7 text-blue-100">
                    Login or create your student
                    account to manage your marketplace
                    activity.
                  </p>
                </div>
              </div>

              <div className="rounded-2xl bg-white/10 p-5">
                <p className="text-sm font-bold text-blue-50">
                  🔐 JWT-secured authentication
                </p>

                <p className="mt-1 text-xs leading-5 text-blue-100">
                  Your authenticated session is
                  connected to the Student Marketplace
                  Auth Service.
                </p>
              </div>
            </div>
          </section>

          {/* RIGHT SIDE */}
          <section className="p-7 sm:p-10">
            <div className="mb-8">
              <Link
                href="/"
                className="text-sm font-black text-blue-600 md:hidden"
              >
                ← Student Marketplace
              </Link>

              <h2 className="mt-4 text-3xl font-black text-slate-900">
                {mode === "login"
                  ? "Welcome back"
                  : "Create account"}
              </h2>

              <p className="mt-2 text-sm text-slate-500">
                {mode === "login"
                  ? "Login to continue to your account."
                  : "Create your student marketplace account."}
              </p>
            </div>

            {/* MODE SWITCH */}
            <div className="mb-7 grid grid-cols-2 rounded-xl bg-slate-100 p-1">
              <button
                type="button"
                onClick={() =>
                  switchMode("login")
                }
                className={`rounded-lg px-4 py-2.5 text-sm font-black transition ${
                  mode === "login"
                    ? "bg-white text-blue-600 shadow-sm"
                    : "text-slate-500"
                }`}
              >
                Login
              </button>

              <button
                type="button"
                onClick={() =>
                  switchMode("register")
                }
                className={`rounded-lg px-4 py-2.5 text-sm font-black transition ${
                  mode === "register"
                    ? "bg-white text-blue-600 shadow-sm"
                    : "text-slate-500"
                }`}
              >
                Register
              </button>
            </div>

            <form
              onSubmit={handleSubmit}
              className="space-y-4"
            >
              {mode === "register" && (
                <div className="grid gap-4 sm:grid-cols-2">
                  <label>
                    <span className="mb-2 block text-sm font-black text-slate-700">
                      First Name
                    </span>

                    <input
                      value={firstName}
                      onChange={(event) =>
                        setFirstName(
                          event.target.value
                        )
                      }
                      placeholder="Prince"
                      autoComplete="given-name"
                      className="w-full rounded-xl border border-slate-200 bg-slate-50 px-4 py-3 outline-none transition focus:border-blue-500 focus:bg-white"
                    />
                  </label>

                  <label>
                    <span className="mb-2 block text-sm font-black text-slate-700">
                      Last Name
                    </span>

                    <input
                      value={lastName}
                      onChange={(event) =>
                        setLastName(
                          event.target.value
                        )
                      }
                      placeholder="Kumar"
                      autoComplete="family-name"
                      className="w-full rounded-xl border border-slate-200 bg-slate-50 px-4 py-3 outline-none transition focus:border-blue-500 focus:bg-white"
                    />
                  </label>
                </div>
              )}

              <label>
                <span className="mb-2 block text-sm font-black text-slate-700">
                  Email
                </span>

                <input
                  type="email"
                  value={email}
                  onChange={(event) =>
                    setEmail(
                      event.target.value
                    )
                  }
                  placeholder="you@example.com"
                  autoComplete="email"
                  required
                  className="w-full rounded-xl border border-slate-200 bg-slate-50 px-4 py-3 outline-none transition focus:border-blue-500 focus:bg-white"
                />
              </label>

              {mode === "register" && (
                <label>
                  <span className="mb-2 block text-sm font-black text-slate-700">
                    Phone
                  </span>

                  <input
                    value={phone}
                    onChange={(event) =>
                      setPhone(
                        event.target.value
                      )
                    }
                    placeholder="10-digit mobile number"
                    autoComplete="tel"
                    className="w-full rounded-xl border border-slate-200 bg-slate-50 px-4 py-3 outline-none transition focus:border-blue-500 focus:bg-white"
                  />
                </label>
              )}

              <label>
                <span className="mb-2 block text-sm font-black text-slate-700">
                  Password
                </span>

                <input
                  type="password"
                  value={password}
                  onChange={(event) =>
                    setPassword(
                      event.target.value
                    )
                  }
                  placeholder="Enter password"
                  autoComplete={
                    mode === "login"
                      ? "current-password"
                      : "new-password"
                  }
                  required
                  className="w-full rounded-xl border border-slate-200 bg-slate-50 px-4 py-3 outline-none transition focus:border-blue-500 focus:bg-white"
                />

                {mode === "register" && (
                  <span className="mt-1 block text-xs text-slate-400">
                    Minimum 6 characters
                  </span>
                )}
              </label>

              {error && (
                <div className="rounded-xl border border-red-200 bg-red-50 px-4 py-3 text-sm font-bold text-red-700">
                  {error}
                </div>
              )}

              {success && (
                <div className="rounded-xl border border-emerald-200 bg-emerald-50 px-4 py-3 text-sm font-bold text-emerald-700">
                  ✓ {success}
                </div>
              )}

              <button
                type="submit"
                disabled={loading}
                className="w-full rounded-xl bg-blue-600 px-5 py-3.5 font-black text-white shadow-lg shadow-blue-200 transition hover:bg-blue-700 disabled:cursor-not-allowed disabled:opacity-60"
              >
                {loading
                  ? "Please wait..."
                  : mode === "login"
                  ? "Login"
                  : "Create Account"}
              </button>
            </form>

            <div className="mt-7 text-center">
              <Link
                href="/"
                className="text-sm font-bold text-slate-500 hover:text-blue-600"
              >
                ← Back to Marketplace
              </Link>
            </div>
          </section>
        </div>
      </div>
    </main>
  );
}