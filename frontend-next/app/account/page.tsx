"use client";

import Link from "next/link";
import { useEffect, useState } from "react";

const ACCOUNT_KEY = "student-marketplace-account";
const ORDERS_KEY = "student-marketplace-orders";

interface AccountData {
  name: string;
  email: string;
  phone: string;
  college: string;
}

interface ProductImage {
  image_url?: string;
  alt_text?: string;
  is_primary?: boolean;
}

interface OrderItem {
  id: string;
  name: string;
  price?: string | number;
  discount_price?: string | number;
  image?: string;
  images?: ProductImage[];
  quantity: number;
  orderPrice?: number;
  orderQuantity?: number;
}

interface Customer {
  name: string;
  email: string;
  phone: string;
  address: string;
  city: string;
  state: string;
  pincode: string;
}

interface StoredOrder {
  id: string;
  orderId: string;
  items: OrderItem[];
  customer: Customer;
  paymentMethod: string;
  paymentStatus: string;
  subtotal: number;
  delivery: number;
  total: number;
  amount: number;
  status: string;
  createdAt: string;
}

function money(value: string | number | undefined) {
  const amount = Number(value);

  if (!Number.isFinite(amount)) {
    return "₹0";
  }

  return `₹${amount.toLocaleString("en-IN")}`;
}

function getImage(item: OrderItem) {
  if (Array.isArray(item.images) && item.images.length > 0) {
    const primary =
      item.images.find((image) => image?.is_primary) ||
      item.images.find((image) => image?.image_url) ||
      item.images[0];

    if (primary?.image_url) {
      return primary.image_url;
    }
  }

  if (item.image) {
    return item.image;
  }

  return `https://placehold.co/300x300/png?text=${encodeURIComponent(
    item.name || "Product"
  )}`;
}

function formatDate(dateString: string) {
  try {
    return new Date(dateString).toLocaleDateString("en-IN", {
      day: "2-digit",
      month: "short",
      year: "numeric",
    });
  } catch {
    return "Date unavailable";
  }
}

function getStatusStep(status: string) {
  const normalized = status.toLowerCase();

  if (
    normalized.includes("delivered")
  ) {
    return 4;
  }

  if (
    normalized.includes("shipped")
  ) {
    return 3;
  }

  if (
    normalized.includes("processing")
  ) {
    return 2;
  }

  return 1;
}

export default function AccountPage() {
  const [account, setAccount] = useState<AccountData>({
    name: "",
    email: "",
    phone: "",
    college: "",
  });

  const [orders, setOrders] = useState<StoredOrder[]>([]);
  const [saved, setSaved] = useState(false);
  const [trackingOrderId, setTrackingOrderId] =
    useState<string | null>(null);

  useEffect(() => {
    try {
      const storedAccount =
        localStorage.getItem(ACCOUNT_KEY);

      if (storedAccount) {
        setAccount(JSON.parse(storedAccount));
      }
    } catch {
      // Ignore account parsing errors
    }

    try {
      const storedOrders =
        localStorage.getItem(ORDERS_KEY);

      if (storedOrders) {
        const parsed = JSON.parse(storedOrders);

        if (Array.isArray(parsed)) {
          setOrders(parsed);
        }
      }
    } catch {
      setOrders([]);
    }

    const handleOrdersUpdate = () => {
      try {
        const storedOrders =
          localStorage.getItem(ORDERS_KEY);

        if (storedOrders) {
          const parsed = JSON.parse(storedOrders);

          if (Array.isArray(parsed)) {
            setOrders(parsed);
          }
        } else {
          setOrders([]);
        }
      } catch {
        setOrders([]);
      }
    };

    window.addEventListener(
      "student-marketplace-orders-updated",
      handleOrdersUpdate
    );

    return () => {
      window.removeEventListener(
        "student-marketplace-orders-updated",
        handleOrdersUpdate
      );
    };
  }, []);

  const saveAccount = (
    event: React.FormEvent
  ) => {
    event.preventDefault();

    localStorage.setItem(
      ACCOUNT_KEY,
      JSON.stringify(account)
    );

    setSaved(true);

    setTimeout(() => {
      setSaved(false);
    }, 2000);
  };

  return (
    <main className="min-h-screen bg-[#f6f8fc]">
      {/* HEADER */}
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
              href="/wishlist"
              className="rounded-xl bg-red-50 px-4 py-2 text-sm font-black text-red-600"
            >
              ♡ Wishlist
            </Link>

            <Link
              href="/cart"
              className="rounded-xl bg-blue-50 px-4 py-2 text-sm font-black text-blue-700"
            >
              🛒 Cart
            </Link>
          </div>
        </div>
      </header>

      {/* PAGE */}
      <section className="mx-auto max-w-6xl px-5 py-12">
        <div className="mb-8">
          <div className="text-xs font-black uppercase tracking-[0.2em] text-blue-600">
            Student Account
          </div>

          <h1 className="mt-2 text-4xl font-black">
            My Account
          </h1>

          <p className="mt-2 text-slate-500">
            Manage your profile and view your orders.
          </p>
        </div>

        {/* PROFILE + ACCOUNT FORM */}
        <div className="grid gap-6 md:grid-cols-[220px_1fr]">
          <div className="rounded-3xl bg-gradient-to-br from-blue-600 to-violet-700 p-6 text-white shadow-xl">
            <div className="flex h-20 w-20 items-center justify-center rounded-full bg-white text-4xl">
              👤
            </div>

            <h2 className="mt-5 text-xl font-black">
              Student Profile
            </h2>

            <p className="mt-2 text-sm leading-6 text-blue-100">
              Keep your basic details ready for future
              orders and checkout.
            </p>

            {/* MY ORDERS QUICK LINK */}
            <a
              href="#my-orders"
              className="mt-6 block rounded-xl bg-white/15 px-4 py-3 text-center text-sm font-black text-white transition hover:bg-white/25"
            >
              📦 My Orders
            </a>
          </div>

          <form
            onSubmit={saveAccount}
            className="rounded-3xl border border-slate-200 bg-white p-7 shadow-sm"
          >
            <div className="grid gap-5">
              <label>
                <span className="mb-2 block text-sm font-black">
                  Full Name
                </span>

                <input
                  value={account.name}
                  onChange={(event) =>
                    setAccount({
                      ...account,
                      name: event.target.value,
                    })
                  }
                  placeholder="Enter your name"
                  className="w-full rounded-xl border border-slate-200 bg-slate-50 px-4 py-3 outline-none focus:border-blue-500 focus:bg-white"
                />
              </label>

              <label>
                <span className="mb-2 block text-sm font-black">
                  Email
                </span>

                <input
                  type="email"
                  value={account.email}
                  onChange={(event) =>
                    setAccount({
                      ...account,
                      email: event.target.value,
                    })
                  }
                  placeholder="Enter email"
                  className="w-full rounded-xl border border-slate-200 bg-slate-50 px-4 py-3 outline-none focus:border-blue-500 focus:bg-white"
                />
              </label>

              <label>
                <span className="mb-2 block text-sm font-black">
                  Phone
                </span>

                <input
                  value={account.phone}
                  onChange={(event) =>
                    setAccount({
                      ...account,
                      phone: event.target.value,
                    })
                  }
                  placeholder="Enter phone number"
                  className="w-full rounded-xl border border-slate-200 bg-slate-50 px-4 py-3 outline-none focus:border-blue-500 focus:bg-white"
                />
              </label>

              <label>
                <span className="mb-2 block text-sm font-black">
                  College / School
                </span>

                <input
                  value={account.college}
                  onChange={(event) =>
                    setAccount({
                      ...account,
                      college: event.target.value,
                    })
                  }
                  placeholder="Enter college or school"
                  className="w-full rounded-xl border border-slate-200 bg-slate-50 px-4 py-3 outline-none focus:border-blue-500 focus:bg-white"
                />
              </label>

              <button
                type="submit"
                className="rounded-xl bg-blue-600 px-5 py-3.5 font-black text-white shadow-lg shadow-blue-200 hover:bg-blue-700"
              >
                Save Account
              </button>

              {saved && (
                <div className="rounded-xl bg-emerald-50 px-4 py-3 text-center text-sm font-bold text-emerald-700">
                  ✓ Account details saved successfully
                </div>
              )}
            </div>
          </form>
        </div>

        {/* ================================================== */}
        {/* MY ORDERS */}
        {/* ================================================== */}

        <section
          id="my-orders"
          className="mt-10"
        >
          <div className="mb-5 flex items-end justify-between gap-4">
            <div>
              <div className="text-xs font-black uppercase tracking-[0.2em] text-blue-600">
                Order History
              </div>

              <h2 className="mt-1 text-3xl font-black">
                My Orders
              </h2>

              <p className="mt-1 text-sm text-slate-500">
                View your orders, payment status and
                delivery tracking.
              </p>
            </div>

            <div className="rounded-full bg-blue-50 px-4 py-2 text-sm font-black text-blue-700">
              {orders.length}{" "}
              {orders.length === 1
                ? "Order"
                : "Orders"}
            </div>
          </div>

          {orders.length === 0 ? (
            <div className="rounded-3xl border border-slate-200 bg-white p-10 text-center shadow-sm">
              <div className="text-6xl">
                📦
              </div>

              <h3 className="mt-4 text-2xl font-black">
                No Orders Yet
              </h3>

              <p className="mx-auto mt-2 max-w-md text-slate-500">
                Your confirmed orders will appear here
                after you place an order.
              </p>

              <Link
                href="/"
                className="mt-6 inline-block rounded-xl bg-blue-600 px-6 py-3 font-black text-white hover:bg-blue-700"
              >
                Start Shopping
              </Link>
            </div>
          ) : (
            <div className="grid gap-5">
              {orders.map((order) => {
                const statusStep =
                  getStatusStep(order.status);

                const isTracking =
                  trackingOrderId ===
                  order.orderId;

                const orderTotal =
                  Number(order.amount) > 0
                    ? Number(order.amount)
                    : Number(order.total) > 0
                    ? Number(order.total)
                    : Number(order.subtotal) || 0;

                return (
                  <article
                    key={
                      order.orderId ||
                      order.id
                    }
                    className="overflow-hidden rounded-3xl border border-slate-200 bg-white shadow-sm"
                  >
                    {/* ORDER HEADER */}
                    <div className="flex flex-col gap-4 border-b border-slate-100 bg-slate-50 p-5 md:flex-row md:items-center md:justify-between">
                      <div>
                        <div className="text-xs font-bold uppercase tracking-wider text-slate-500">
                          Order ID
                        </div>

                        <div className="mt-1 text-lg font-black text-slate-900">
                          {order.orderId}
                        </div>

                        <div className="mt-1 text-sm text-slate-500">
                          Placed on{" "}
                          {formatDate(
                            order.createdAt
                          )}
                        </div>
                      </div>

                      <div className="flex flex-wrap items-center gap-3">
                        <span className="rounded-full bg-emerald-100 px-4 py-2 text-sm font-black text-emerald-700">
                          ✓ {order.status || "Order Placed"}
                        </span>

                        <span className="text-xl font-black text-blue-700">
                          {money(orderTotal)}
                        </span>
                      </div>
                    </div>

                    {/* ORDER BODY */}
                    <div className="p-5">
                      <div className="grid gap-4">
                        {Array.isArray(order.items) &&
                          order.items.map(
                            (item, index) => {
                              const image =
                                getImage(item);

                              const quantity =
                                Number(
                                  item.orderQuantity
                                ) > 0
                                  ? Number(
                                      item.orderQuantity
                                    )
                                  : Number(
                                      item.quantity
                                    ) > 0
                                  ? Number(
                                      item.quantity
                                    )
                                  : 1;

                              const itemPrice =
                                Number(
                                  item.orderPrice
                                ) > 0
                                  ? Number(
                                      item.orderPrice
                                    )
                                  : Number(
                                      item.discount_price
                                    ) > 0
                                  ? Number(
                                      item.discount_price
                                    )
                                  : Number(
                                      item.price
                                    ) || 0;

                              return (
                                <div
                                  key={`${item.id}-${index}`}
                                  className="flex items-center gap-4 rounded-2xl border border-slate-100 p-3"
                                >
                                  {/* IMAGE */}
                                  <div className="h-20 w-20 shrink-0 overflow-hidden rounded-xl border border-slate-200 bg-slate-100">
                                    <img
                                      src={image}
                                      alt={item.name}
                                      className="h-full w-full object-cover"
                                      loading="lazy"
                                      referrerPolicy="no-referrer"
                                      onError={(
                                        event
                                      ) => {
                                        const target =
                                          event.currentTarget;

                                        if (
                                          target.dataset
                                            .fallbackApplied ===
                                          "true"
                                        ) {
                                          return;
                                        }

                                        target.dataset.fallbackApplied =
                                          "true";

                                        target.src =
                                          `https://placehold.co/300x300/png?text=${encodeURIComponent(
                                            item.name ||
                                              "Product"
                                          )}`;
                                      }}
                                    />
                                  </div>

                                  {/* INFO */}
                                  <div className="min-w-0 flex-1">
                                    <h3 className="truncate font-black text-slate-900">
                                      {item.name}
                                    </h3>

                                    <p className="mt-1 text-sm text-slate-500">
                                      Qty: {quantity}
                                    </p>

                                    <p className="mt-1 text-sm font-bold text-blue-600">
                                      {money(
                                        itemPrice
                                      )}{" "}
                                      each
                                    </p>
                                  </div>

                                  <div className="font-black text-slate-900">
                                    {money(
                                      itemPrice *
                                        quantity
                                    )}
                                  </div>
                                </div>
                              );
                            }
                          )}
                      </div>

                      {/* ORDER DETAILS */}
                      <div className="mt-5 grid gap-3 rounded-2xl bg-slate-50 p-4 sm:grid-cols-3">
                        <div>
                          <div className="text-xs font-bold uppercase tracking-wide text-slate-400">
                            Payment
                          </div>

                          <div className="mt-1 font-black text-slate-800">
                            {order.paymentMethod ===
                            "COD"
                              ? "Cash on Delivery"
                              : order.paymentMethod ||
                                "Online Payment"}
                          </div>
                        </div>

                        <div>
                          <div className="text-xs font-bold uppercase tracking-wide text-slate-400">
                            Payment Status
                          </div>

                          <div className="mt-1 font-black text-orange-600">
                            {order.paymentStatus ||
                              "Payment Pending"}
                          </div>
                        </div>

                        <div>
                          <div className="text-xs font-bold uppercase tracking-wide text-slate-400">
                            Order Total
                          </div>

                          <div className="mt-1 font-black text-blue-700">
                            {money(orderTotal)}
                          </div>
                        </div>
                      </div>

                      {/* TRACK BUTTON */}
                      <button
                        type="button"
                        onClick={() =>
                          setTrackingOrderId(
                            isTracking
                              ? null
                              : order.orderId
                          )
                        }
                        className="mt-5 w-full rounded-xl border-2 border-blue-600 bg-white px-5 py-3 font-black text-blue-700 transition hover:bg-blue-50"
                      >
                        {isTracking
                          ? "▲ Hide Tracking"
                          : "🚚 Track Order"}
                      </button>

                      {/* TRACKING TIMELINE */}
                      {isTracking && (
                        <div className="mt-5 rounded-2xl border border-blue-100 bg-blue-50 p-5">
                          <h3 className="text-lg font-black text-slate-900">
                            Order Tracking
                          </h3>

                          <p className="mt-1 text-sm text-slate-500">
                            Order {order.orderId}
                          </p>

                          <div className="mt-6 grid gap-5">
                            {/* PLACED */}
                            <div className="flex gap-4">
                              <div
                                className={`flex h-10 w-10 shrink-0 items-center justify-center rounded-full font-black ${
                                  statusStep >= 1
                                    ? "bg-blue-600 text-white"
                                    : "bg-slate-200 text-slate-400"
                                }`}
                              >
                                ✓
                              </div>

                              <div>
                                <div className="font-black">
                                  Order Placed
                                </div>

                                <div className="text-sm text-slate-500">
                                  Your order has been
                                  successfully confirmed.
                                </div>
                              </div>
                            </div>

                            {/* PROCESSING */}
                            <div className="flex gap-4">
                              <div
                                className={`flex h-10 w-10 shrink-0 items-center justify-center rounded-full font-black ${
                                  statusStep >= 2
                                    ? "bg-blue-600 text-white"
                                    : "bg-slate-200 text-slate-400"
                                }`}
                              >
                                {statusStep >= 2
                                  ? "✓"
                                  : "2"}
                              </div>

                              <div>
                                <div className="font-black">
                                  Processing
                                </div>

                                <div className="text-sm text-slate-500">
                                  Your order is being
                                  prepared.
                                </div>
                              </div>
                            </div>

                            {/* SHIPPED */}
                            <div className="flex gap-4">
                              <div
                                className={`flex h-10 w-10 shrink-0 items-center justify-center rounded-full font-black ${
                                  statusStep >= 3
                                    ? "bg-blue-600 text-white"
                                    : "bg-slate-200 text-slate-400"
                                }`}
                              >
                                {statusStep >= 3
                                  ? "✓"
                                  : "3"}
                              </div>

                              <div>
                                <div className="font-black">
                                  Shipped
                                </div>

                                <div className="text-sm text-slate-500">
                                  Your package is on
                                  the way.
                                </div>
                              </div>
                            </div>

                            {/* DELIVERED */}
                            <div className="flex gap-4">
                              <div
                                className={`flex h-10 w-10 shrink-0 items-center justify-center rounded-full font-black ${
                                  statusStep >= 4
                                    ? "bg-emerald-600 text-white"
                                    : "bg-slate-200 text-slate-400"
                                }`}
                              >
                                {statusStep >= 4
                                  ? "✓"
                                  : "4"}
                              </div>

                              <div>
                                <div className="font-black">
                                  Delivered
                                </div>

                                <div className="text-sm text-slate-500">
                                  Order delivered
                                  successfully.
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      )}
                    </div>
                  </article>
                );
              })}
            </div>
          )}
        </section>
      </section>
    </main>
  );
}