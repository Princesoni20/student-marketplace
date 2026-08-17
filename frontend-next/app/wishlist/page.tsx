"use client";

import Link from "next/link";
import { useEffect, useState } from "react";

interface Product {
  id: string;
  name: string;
  price: string | number;
  discount_price?: string | number | null;
  description?: string;
  category_name?: string;
  images?: {
    image_url: string;
    is_primary?: boolean;
  }[];
}

const WISHLIST_KEY =
  "student-marketplace-wishlist";

const CART_KEY =
  "student-marketplace-cart";

const fallback =
  "https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=900&q=80";

function money(value: string | number | null | undefined) {
  return `₹${Number(value || 0).toLocaleString("en-IN")}`;
}

function imageFor(product: Product) {
  const image =
    product.images?.find((item) => item.is_primary)
      ?.image_url ||
    product.images?.[0]?.image_url;

  if (
    image &&
    !image.includes("placehold.co") &&
    !image.includes("placeholder")
  ) {
    return image;
  }

  return fallback;
}

export default function WishlistPage() {
  const [items, setItems] = useState<Product[]>([]);
  const [toast, setToast] = useState("");

  useEffect(() => {
    try {
      setItems(
        JSON.parse(
          localStorage.getItem(WISHLIST_KEY) || "[]"
        )
      );
    } catch {
      setItems([]);
    }
  }, []);

  const remove = (id: string) => {
    const updated = items.filter(
      (item) => item.id !== id
    );

    setItems(updated);

    localStorage.setItem(
      WISHLIST_KEY,
      JSON.stringify(updated)
    );

    window.dispatchEvent(
      new Event("student-wishlist-updated")
    );
  };

  const addToCart = (product: Product) => {
    const cart = JSON.parse(
      localStorage.getItem(CART_KEY) || "[]"
    );

    const existing = cart.find(
      (item: Product & { quantity: number }) =>
        item.id === product.id
    );

    const updated = existing
      ? cart.map(
          (item: Product & { quantity: number }) =>
            item.id === product.id
              ? {
                  ...item,
                  quantity: item.quantity + 1,
                }
              : item
        )
      : [
          ...cart,
          {
            ...product,
            quantity: 1,
          },
        ];

    localStorage.setItem(
      CART_KEY,
      JSON.stringify(updated)
    );

    window.dispatchEvent(
      new Event("student-cart-updated")
    );

    setToast("Added to cart");

    setTimeout(() => setToast(""), 1800);
  };

  return (
    <main className="min-h-screen bg-[#f6f8fc]">
      <header className="border-b border-slate-200 bg-white">
        <div className="mx-auto flex max-w-7xl items-center justify-between px-5 py-5">
          <Link
            href="/"
            className="font-black"
          >
            🎓 Student Marketplace
          </Link>

          <div className="flex gap-2">
            <Link
              href="/cart"
              className="rounded-xl bg-blue-50 px-4 py-2 text-sm font-black text-blue-700"
            >
              🛒 Cart
            </Link>

            <Link
              href="/"
              className="rounded-xl bg-slate-100 px-4 py-2 text-sm font-black"
            >
              Home
            </Link>
          </div>
        </div>
      </header>

      <section className="mx-auto max-w-7xl px-5 py-12">
        <div className="mb-8">
          <div className="text-xs font-black uppercase tracking-[0.2em] text-red-500">
            Saved Products
          </div>

          <h1 className="mt-2 text-4xl font-black">
            My Wishlist
          </h1>

          <p className="mt-2 text-slate-500">
            {items.length} saved products
          </p>
        </div>

        {!items.length ? (
          <div className="rounded-3xl border border-slate-200 bg-white p-16 text-center shadow-sm">
            <div className="text-6xl">♡</div>

            <h2 className="mt-5 text-2xl font-black">
              Your wishlist is empty
            </h2>

            <p className="mt-2 text-slate-500">
              Tap the heart on any product to save it here.
            </p>

            <Link
              href="/"
              className="mt-7 inline-flex rounded-xl bg-blue-600 px-6 py-3 font-black text-white"
            >
              Explore Products
            </Link>
          </div>
        ) : (
          <div className="grid gap-5 sm:grid-cols-2 lg:grid-cols-4">
            {items.map((product) => {
              const price =
                product.discount_price &&
                Number(product.discount_price) <
                  Number(product.price)
                  ? product.discount_price
                  : product.price;

              return (
                <article
                  key={product.id}
                  className="overflow-hidden rounded-3xl border border-slate-200 bg-white shadow-sm"
                >
                  <img
                    src={imageFor(product)}
                    alt={product.name}
                    className="h-56 w-full object-cover"
                  />

                  <div className="p-5">
                    <div className="text-xs font-black uppercase text-blue-600">
                      {product.category_name}
                    </div>

                    <h2 className="mt-2 min-h-12 font-black">
                      {product.name}
                    </h2>

                    <p className="mt-2 line-clamp-2 text-sm text-slate-500">
                      {product.description}
                    </p>

                    <div className="mt-5 text-xl font-black">
                      {money(price)}
                    </div>

                    <div className="mt-4 grid gap-2">
                      <button
                        type="button"
                        onClick={() =>
                          addToCart(product)
                        }
                        className="rounded-xl bg-blue-600 px-4 py-3 text-sm font-black text-white"
                      >
                        🛒 Add to Cart
                      </button>

                      <button
                        type="button"
                        onClick={() =>
                          remove(product.id)
                        }
                        className="rounded-xl bg-red-50 px-4 py-3 text-sm font-black text-red-600"
                      >
                        Remove Wishlist
                      </button>
                    </div>
                  </div>
                </article>
              );
            })}
          </div>
        )}
      </section>

      {toast && (
        <div className="fixed bottom-6 left-1/2 z-50 -translate-x-1/2 rounded-2xl bg-slate-900 px-5 py-3 text-sm font-bold text-white shadow-2xl">
          ✓ {toast}
        </div>
      )}
    </main>
  );
}