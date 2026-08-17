"use client";

import { useEffect, useMemo, useState } from "react";
import type { CSSProperties } from "react";
import { useRouter } from "next/navigation";

type ProductImage = {
  image_url?: string;
  alt_text?: string;
  is_primary?: boolean;
};

type Product = {
  id: string;
  name: string;
  description?: string;
  category_name?: string;
  brand?: string;
  price?: string | number;
  discount_price?: string | number;
  image?: string;
  images?: ProductImage[];
};

type CartItem = {
  id: string;
  name: string;
  description?: string;
  category_name?: string;
  brand?: string;
  price?: string | number;
  discount_price?: string | number;
  image?: string;
  images?: ProductImage[];
  quantity: number;
};

type Customer = {
  name: string;
  email: string;
  phone: string;
  address: string;
  city: string;
  state: string;
  pincode: string;
};

type OrderItem = CartItem & {
  orderPrice: number;
  orderQuantity: number;
};

type StoredOrder = {
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
};

const CART_KEY = "student-marketplace-cart";
const ORDERS_KEY = "student-marketplace-orders";
const LAST_ORDER_KEY = "student-marketplace-last-order";

function money(value: string | number | undefined) {
  const number = Number(value);

  if (!Number.isFinite(number)) {
    return "₹0";
  }

  return `₹${number.toLocaleString("en-IN")}`;
}

/**
 * Gets the best available product image.
 *
 * Supports:
 * 1. product.images[]
 * 2. product.image
 * 3. placeholder
 */
function getImage(product: Product) {
  if (
    Array.isArray(product.images) &&
    product.images.length > 0
  ) {
    const primary =
      product.images.find(
        (image) => image?.is_primary
      ) ||
      product.images.find(
        (image) => image?.image_url
      ) ||
      product.images[0];

    if (primary?.image_url) {
      return primary.image_url;
    }
  }

  if (product.image) {
    return product.image;
  }

  return `https://placehold.co/600x450/png?text=${encodeURIComponent(
    product.name || "Product"
  )}`;
}

/**
 * Cart can exist in two formats in localStorage:
 *
 * Old/flat:
 * {
 *   id,
 *   name,
 *   price,
 *   images,
 *   quantity
 * }
 *
 * Current drawer format:
 * {
 *   product: {
 *     id,
 *     name,
 *     price,
 *     images
 *   },
 *   quantity
 * }
 *
 * This function supports BOTH formats so existing
 * working cart data is not destroyed.
 */
function normalizeCartItem(raw: unknown): CartItem | null {
  if (!raw || typeof raw !== "object") {
    return null;
  }

  const value = raw as Record<string, unknown>;

  let product: Product | null = null;

  if (
    value.product &&
    typeof value.product === "object"
  ) {
    product = value.product as Product;
  } else {
    product = value as unknown as Product;
  }

  if (!product || !product.id || !product.name) {
    return null;
  }

  const quantityNumber = Number(value.quantity);

  const quantity =
    Number.isFinite(quantityNumber) &&
    quantityNumber > 0
      ? Math.floor(quantityNumber)
      : 1;

  return {
    id: String(product.id),
    name: String(product.name),

    description:
      typeof product.description === "string"
        ? product.description
        : undefined,

    category_name:
      typeof product.category_name === "string"
        ? product.category_name
        : undefined,

    brand:
      typeof product.brand === "string"
        ? product.brand
        : undefined,

    price: product.price,

    discount_price:
      product.discount_price,

    image:
      typeof product.image === "string"
        ? product.image
        : undefined,

    images: Array.isArray(product.images)
      ? product.images
      : undefined,

    quantity,
  };
}

function loadCartFromStorage(): CartItem[] {
  try {
    const raw = localStorage.getItem(CART_KEY);

    if (!raw) {
      return [];
    }

    const parsed: unknown = JSON.parse(raw);

    if (!Array.isArray(parsed)) {
      return [];
    }

    const normalized = parsed
      .map(normalizeCartItem)
      .filter(
        (item): item is CartItem =>
          item !== null
      );

    return normalized;
  } catch (error) {
    console.error(
      "CHECKOUT CART LOAD ERROR:",
      error
    );

    return [];
  }
}

export default function CheckoutPage() {
  const router = useRouter();

  const [items, setItems] = useState<CartItem[]>([]);

  const [loading, setLoading] =
    useState(true);

  const [placingOrder, setPlacingOrder] =
    useState(false);

  const [orderPlaced, setOrderPlaced] =
    useState(false);

  const [orderId, setOrderId] =
    useState("");

  const [customer, setCustomer] =
    useState<Customer>({
      name: "",
      email: "",
      phone: "",
      address: "",
      city: "",
      state: "",
      pincode: "",
    });

  const [paymentMethod, setPaymentMethod] =
    useState("COD");

  /*
   * Load cart.
   *
   * Important:
   * We normalize the existing cart instead of
   * deleting/replacing it.
   */
  useEffect(() => {
    const load = () => {
      const cart = loadCartFromStorage();

      setItems(cart);
      setLoading(false);
    };

    load();

    const handleCartUpdate = () => {
      load();
    };

    window.addEventListener(
      "student-marketplace-cart-updated",
      handleCartUpdate
    );

    return () => {
      window.removeEventListener(
        "student-marketplace-cart-updated",
        handleCartUpdate
      );
    };
  }, []);

  /*
   * Calculate subtotal using discounted price
   * when available, otherwise normal price.
   */
  const subtotal = useMemo(() => {
    return items.reduce((total, item) => {
      const discountPrice = Number(
        item.discount_price
      );

      const normalPrice = Number(
        item.price
      );

      const price =
        Number.isFinite(discountPrice) &&
        discountPrice > 0
          ? discountPrice
          : Number.isFinite(normalPrice)
          ? normalPrice
          : 0;

      const quantity =
        Number(item.quantity) > 0
          ? Number(item.quantity)
          : 1;

      return total + price * quantity;
    }, 0);
  }, [items]);

  const delivery = 0;

  const total = subtotal + delivery;

  const totalItems = useMemo(() => {
    return items.reduce(
      (total, item) =>
        total +
        (Number(item.quantity) > 0
          ? Number(item.quantity)
          : 1),
      0
    );
  }, [items]);

  const updateCustomer = (
    key: keyof Customer,
    value: string
  ) => {
    setCustomer((current) => ({
      ...current,
      [key]: value,
    }));
  };

  /*
   * Place order.
   *
   * IMPORTANT:
   * The order is saved with a complete price snapshot.
   *
   * This prevents the COD/order amount from becoming
   * ₹0 after the cart is cleared.
   */
  const placeOrder = async () => {
    if (items.length === 0) {
      alert("Your cart is empty.");
      router.push("/");
      return;
    }

    if (
      !customer.name.trim() ||
      !customer.email.trim() ||
      !customer.phone.trim() ||
      !customer.address.trim() ||
      !customer.city.trim() ||
      !customer.state.trim() ||
      !customer.pincode.trim()
    ) {
      alert(
        "Please complete all delivery details."
      );

      return;
    }

    if (
      !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(
        customer.email.trim()
      )
    ) {
      alert(
        "Please enter a valid email address."
      );

      return;
    }

    if (
      !/^[6-9]\d{9}$/.test(
        customer.phone.trim()
      )
    ) {
      alert(
        "Please enter a valid 10-digit mobile number."
      );

      return;
    }

    if (
      !/^\d{6}$/.test(
        customer.pincode.trim()
      )
    ) {
      alert(
        "Please enter a valid 6-digit PIN code."
      );

      return;
    }

    setPlacingOrder(true);

    try {
      /*
       * Generate unique order ID.
       */
      const generatedOrderId =
        "SM-" +
        Date.now().toString().slice(-8);

      /*
       * IMPORTANT:
       * Create a permanent snapshot of every
       * product and its price BEFORE clearing cart.
       */
      const orderItems: OrderItem[] =
        items.map((item) => {
          const discountPrice = Number(
            item.discount_price
          );

          const normalPrice = Number(
            item.price
          );

          const orderPrice =
            Number.isFinite(discountPrice) &&
            discountPrice > 0
              ? discountPrice
              : Number.isFinite(normalPrice)
              ? normalPrice
              : 0;

          const orderQuantity =
            Number(item.quantity) > 0
              ? Math.floor(
                  Number(item.quantity)
                )
              : 1;

          return {
            ...item,

            /*
             * Save exact price at the time
             * order was placed.
             */
            orderPrice,

            /*
             * Save exact quantity at the time
             * order was placed.
             */
            orderQuantity,

            quantity: orderQuantity,
          };
        });

      /*
       * Calculate order amount from the
       * saved order snapshot.
       *
       * This is intentionally NOT dependent
       * on cart after order creation.
       */
      const calculatedSubtotal =
        orderItems.reduce(
          (sum, item) =>
            sum +
            Number(item.orderPrice || 0) *
              Number(
                item.orderQuantity || 1
              ),
          0
        );

      const calculatedDelivery = 0;

      const calculatedTotal =
        calculatedSubtotal +
        calculatedDelivery;

      /*
       * Create complete order object.
       */
      const order: StoredOrder = {
        id: generatedOrderId,

        orderId: generatedOrderId,

        items: orderItems,

        customer: {
          ...customer,
        },

        paymentMethod,

        /*
         * COD payment is not collected yet.
         * Therefore payment remains pending.
         */
        paymentStatus:
          paymentMethod === "COD"
            ? "Payment Pending"
            : "Payment Pending",

        /*
         * Save exact financial values.
         */
        subtotal: calculatedSubtotal,

        delivery: calculatedDelivery,

        total: calculatedTotal,

        /*
         * Extra amount field for account/order
         * pages so amount never falls back to 0.
         */
        amount: calculatedTotal,

        status: "Order Placed",

        createdAt:
          new Date().toISOString(),
      };

      /*
       * Read existing orders safely.
       */
      let existingOrders: StoredOrder[] =
        [];

      try {
        const storedOrders =
          localStorage.getItem(
            ORDERS_KEY
          );

        if (storedOrders) {
          const parsed =
            JSON.parse(storedOrders);

          if (Array.isArray(parsed)) {
            existingOrders =
              parsed as StoredOrder[];
          }
        }
      } catch (error) {
        console.error(
          "ORDERS LOAD ERROR:",
          error
        );

        existingOrders = [];
      }

      /*
       * Save newest order first.
       */
      const updatedOrders = [
        order,
        ...existingOrders,
      ];

      localStorage.setItem(
        ORDERS_KEY,
        JSON.stringify(updatedOrders)
      );

      /*
       * Save last order separately.
       *
       * Useful for confirmation, tracking,
       * and future order pages.
       */
      localStorage.setItem(
        LAST_ORDER_KEY,
        JSON.stringify(order)
      );

      /*
       * IMPORTANT:
       * Cart is cleared ONLY after the order
       * has successfully been saved.
       */
      localStorage.removeItem(CART_KEY);

      /*
       * Notify cart UI.
       */
      window.dispatchEvent(
        new Event(
          "student-marketplace-cart-updated"
        )
      );

      /*
       * Notify account/order UI.
       */
      window.dispatchEvent(
        new Event(
          "student-marketplace-orders-updated"
        )
      );

      /*
       * Show success page.
       */
      setOrderId(generatedOrderId);
      setOrderPlaced(true);

      console.log(
        "ORDER CREATED SUCCESSFULLY:",
        order
      );
    } catch (error) {
      console.error(
        "ORDER ERROR:",
        error
      );

      alert(
        "Unable to place order. Please try again."
      );
    } finally {
      setPlacingOrder(false);
    }
  };

  /*
   * Loading screen
   */
  if (loading) {
    return (
      <main
        style={{
          minHeight: "100vh",
          display: "grid",
          placeItems: "center",
          background: "#f6f8fc",
          color: "#172033",
        }}
      >
        <div>
          <h2>
            Loading checkout...
          </h2>
        </div>
      </main>
    );
  }

  /*
   * Successful order screen
   */
  if (orderPlaced) {
    return (
      <main
        style={{
          minHeight: "100vh",
          background: "#f6f8fc",
          padding: "50px 18px",
          color: "#172033",
        }}
      >
        <div
          style={{
            maxWidth: 700,
            margin: "0 auto",
            background: "#fff",
            borderRadius: 20,
            padding: 45,
            textAlign: "center",
            boxShadow:
              "0 15px 45px rgba(15,23,42,.10)",
          }}
        >
          <div
            style={{
              width: 75,
              height: 75,
              borderRadius: "50%",
              background: "#dcfce7",
              color: "#16a34a",
              display: "grid",
              placeItems: "center",
              margin: "0 auto 20px",
              fontSize: 40,
            }}
          >
            ✓
          </div>

          <h1
            style={{
              marginBottom: 10,
              fontSize: 34,
            }}
          >
            Order Placed Successfully!
          </h1>

          <p
            style={{
              color: "#64748b",
              fontSize: 17,
              marginBottom: 8,
            }}
          >
            Thank you for shopping with
            Student Marketplace.
          </p>

          <p
            style={{
              fontWeight: 800,
              fontSize: 18,
              marginBottom: 25,
            }}
          >
            Order ID: {orderId}
          </p>

          <div
            style={{
              background: "#f8fafc",
              borderRadius: 14,
              padding: 18,
              marginBottom: 25,
            }}
          >
            <div
              style={{
                display: "flex",
                justifyContent:
                  "space-between",
                marginBottom: 8,
              }}
            >
              <span>Total</span>

              <strong>
                {money(total)}
              </strong>
            </div>

            <div
              style={{
                display: "flex",
                justifyContent:
                  "space-between",
                marginBottom: 8,
              }}
            >
              <span>Payment</span>

              <strong>
                {paymentMethod === "COD"
                  ? "Cash on Delivery"
                  : "Online Payment"}
              </strong>
            </div>

            <div
              style={{
                display: "flex",
                justifyContent:
                  "space-between",
              }}
            >
              <span>Status</span>

              <strong
                style={{
                  color: "#16a34a",
                }}
              >
                Order Placed
              </strong>
            </div>
          </div>

          {/* VIEW ORDERS */}

          <button
            type="button"
            onClick={() =>
              router.push("/account")
            }
            style={{
              width: "100%",
              border: 0,
              borderRadius: 10,
              padding: "13px 22px",
              background:
                "linear-gradient(135deg,#2563eb,#4f46e5)",
              color: "#fff",
              fontWeight: 800,
              cursor: "pointer",
              marginBottom: 10,
            }}
          >
            📦 View My Orders
          </button>

          {/* CONTINUE SHOPPING */}

          <button
            type="button"
            onClick={() =>
              router.push("/")
            }
            style={{
              width: "100%",
              border:
                "1px solid #dbe3f0",
              borderRadius: 10,
              padding: "13px 22px",
              background: "#fff",
              color: "#172033",
              fontWeight: 800,
              cursor: "pointer",
            }}
          >
            🏠 Continue Shopping
          </button>
        </div>
      </main>
    );
  }

  /*
   * Empty cart
   */
  if (items.length === 0) {
    return (
      <main
        style={{
          minHeight: "100vh",
          background: "#f6f8fc",
          padding: "50px 18px",
          color: "#172033",
        }}
      >
        <div
          style={{
            maxWidth: 650,
            margin: "0 auto",
            textAlign: "center",
            background: "#fff",
            padding: 45,
            borderRadius: 20,
            boxShadow:
              "0 8px 30px rgba(15,23,42,.06)",
          }}
        >
          <div
            style={{
              fontSize: 55,
            }}
          >
            🛒
          </div>

          <h1>
            Your Cart is Empty
          </h1>

          <p
            style={{
              color: "#64748b",
            }}
          >
            Add some products before
            proceeding to checkout.
          </p>

          <button
            type="button"
            onClick={() =>
              router.push("/")
            }
            style={{
              marginTop: 15,
              border: 0,
              borderRadius: 10,
              padding: "13px 24px",
              background: "#2563eb",
              color: "#fff",
              fontWeight: 800,
              cursor: "pointer",
            }}
          >
            Continue Shopping
          </button>
        </div>
      </main>
    );
  }

  /*
   * Main checkout page
   */
  return (
    <main
      style={{
        minHeight: "100vh",
        background: "#f6f8fc",
        color: "#172033",
        padding: "30px 18px 60px",
      }}
    >
      <div
        style={{
          maxWidth: 1150,
          margin: "0 auto",
        }}
      >
        <button
          type="button"
          onClick={() =>
            router.push("/cart")
          }
          style={{
            border: 0,
            background: "transparent",
            cursor: "pointer",
            fontWeight: 800,
            marginBottom: 20,
          }}
        >
          ← Back to Cart
        </button>

        <h1
          style={{
            fontSize: 34,
            marginBottom: 8,
          }}
        >
          Checkout
        </h1>

        <p
          style={{
            color: "#64748b",
            marginBottom: 28,
          }}
        >
          Complete your delivery
          and payment details.
        </p>

        <div
          style={{
            display: "grid",
            gridTemplateColumns:
              "minmax(0, 1.5fr) minmax(300px, .8fr)",
            gap: 25,
            alignItems: "start",
          }}
        >
          {/* DELIVERY DETAILS */}

          <section
            style={{
              background: "#fff",
              borderRadius: 18,
              padding: 25,
              boxShadow:
                "0 8px 30px rgba(15,23,42,.06)",
            }}
          >
            <h2
              style={{
                marginTop: 0,
              }}
            >
              📦 Delivery Details
            </h2>

            <div
              style={{
                display: "grid",
                gridTemplateColumns:
                  "repeat(2,minmax(0,1fr))",
                gap: 15,
              }}
            >
              <label>
                <span
                  style={labelStyle}
                >
                  Full Name *
                </span>

                <input
                  value={customer.name}
                  onChange={(e) =>
                    updateCustomer(
                      "name",
                      e.target.value
                    )
                  }
                  placeholder="Enter your name"
                  style={inputStyle}
                />
              </label>

              <label>
                <span
                  style={labelStyle}
                >
                  Email *
                </span>

                <input
                  type="email"
                  value={customer.email}
                  onChange={(e) =>
                    updateCustomer(
                      "email",
                      e.target.value
                    )
                  }
                  placeholder="you@example.com"
                  style={inputStyle}
                />
              </label>

              <label>
                <span
                  style={labelStyle}
                >
                  Mobile Number *
                </span>

                <input
                  value={customer.phone}
                  onChange={(e) =>
                    updateCustomer(
                      "phone",
                      e.target.value.replace(
                        /\D/g,
                        ""
                      )
                    )
                  }
                  placeholder="10-digit mobile number"
                  maxLength={10}
                  inputMode="numeric"
                  style={inputStyle}
                />
              </label>

              <label>
                <span
                  style={labelStyle}
                >
                  PIN Code *
                </span>

                <input
                  value={
                    customer.pincode
                  }
                  onChange={(e) =>
                    updateCustomer(
                      "pincode",
                      e.target.value.replace(
                        /\D/g,
                        ""
                      )
                    )
                  }
                  placeholder="6-digit PIN"
                  maxLength={6}
                  inputMode="numeric"
                  style={inputStyle}
                />
              </label>

              <label
                style={{
                  gridColumn:
                    "1 / -1",
                }}
              >
                <span
                  style={labelStyle}
                >
                  Full Address *
                </span>

                <textarea
                  value={
                    customer.address
                  }
                  onChange={(e) =>
                    updateCustomer(
                      "address",
                      e.target.value
                    )
                  }
                  placeholder="House/flat, street, area"
                  rows={4}
                  style={{
                    ...inputStyle,
                    resize: "vertical",
                  }}
                />
              </label>

              <label>
                <span
                  style={labelStyle}
                >
                  City *
                </span>

                <input
                  value={customer.city}
                  onChange={(e) =>
                    updateCustomer(
                      "city",
                      e.target.value
                    )
                  }
                  placeholder="City"
                  style={inputStyle}
                />
              </label>

              <label>
                <span
                  style={labelStyle}
                >
                  State *
                </span>

                <input
                  value={customer.state}
                  onChange={(e) =>
                    updateCustomer(
                      "state",
                      e.target.value
                    )
                  }
                  placeholder="State"
                  style={inputStyle}
                />
              </label>
            </div>

            <hr
              style={{
                border: 0,
                borderTop:
                  "1px solid #e5e7eb",
                margin: "28px 0",
              }}
            />

            {/* PAYMENT */}

            <h2>
              💳 Payment Method
            </h2>

            <div
              style={{
                display: "grid",
                gap: 12,
              }}
            >
              <label
                style={{
                  border:
                    paymentMethod ===
                    "COD"
                      ? "2px solid #2563eb"
                      : "1px solid #dbe3f0",

                  borderRadius: 12,

                  padding: 15,

                  cursor: "pointer",

                  background:
                    paymentMethod ===
                    "COD"
                      ? "#eff6ff"
                      : "#fff",
                }}
              >
                <input
                  type="radio"
                  name="payment"
                  value="COD"
                  checked={
                    paymentMethod ===
                    "COD"
                  }
                  onChange={() =>
                    setPaymentMethod(
                      "COD"
                    )
                  }
                />{" "}
                <strong>
                  Cash on Delivery
                </strong>

                <div
                  style={{
                    color: "#64748b",
                    marginLeft: 24,
                    marginTop: 5,
                    fontSize: 14,
                  }}
                >
                  Pay when your order
                  is delivered.
                </div>
              </label>

              <label
                style={{
                  border:
                    paymentMethod ===
                    "ONLINE"
                      ? "2px solid #2563eb"
                      : "1px solid #dbe3f0",

                  borderRadius: 12,

                  padding: 15,

                  cursor: "pointer",

                  background:
                    paymentMethod ===
                    "ONLINE"
                      ? "#eff6ff"
                      : "#fff",
                }}
              >
                <input
                  type="radio"
                  name="payment"
                  value="ONLINE"
                  checked={
                    paymentMethod ===
                    "ONLINE"
                  }
                  onChange={() =>
                    setPaymentMethod(
                      "ONLINE"
                    )
                  }
                />{" "}
                <strong>
                  Online Payment
                </strong>

                <div
                  style={{
                    color: "#64748b",
                    marginLeft: 24,
                    marginTop: 5,
                    fontSize: 14,
                  }}
                >
                  Payment gateway
                  integration can be
                  connected here.
                </div>
              </label>
            </div>
          </section>

          {/* ORDER SUMMARY */}

          <aside
            style={{
              background: "#fff",
              borderRadius: 18,
              padding: 23,
              boxShadow:
                "0 8px 30px rgba(15,23,42,.06)",
              position: "sticky",
              top: 20,
            }}
          >
            <h2
              style={{
                marginTop: 0,
              }}
            >
              Order Summary
            </h2>

            <div
              style={{
                display: "grid",
                gap: 12,
                marginBottom: 18,
              }}
            >
              {items.map((item) => {
                const discountPrice =
                  Number(
                    item.discount_price
                  );

                const normalPrice =
                  Number(item.price);

                const price =
                  Number.isFinite(
                    discountPrice
                  ) &&
                  discountPrice > 0
                    ? discountPrice
                    : Number.isFinite(
                        normalPrice
                      )
                    ? normalPrice
                    : 0;

                const quantity =
                  Number(item.quantity) > 0
                    ? Number(item.quantity)
                    : 1;

                const image =
                  getImage(item);

                return (
                  <div
                    key={item.id}
                    style={{
                      display: "flex",
                      gap: 12,
                      alignItems:
                        "center",
                      paddingBottom: 12,
                      borderBottom:
                        "1px solid #eef2f7",
                    }}
                  >
                    {/* PRODUCT IMAGE */}

                    <div
                      style={{
                        width: 80,
                        height: 80,
                        flexShrink: 0,
                        borderRadius: 10,
                        overflow: "hidden",
                        background:
                          "#f1f5f9",
                        border:
                          "1px solid #e2e8f0",
                      }}
                    >
                      <img
                        src={image}
                        alt={item.name}
                        loading="eager"
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
                            `https://placehold.co/600x450/png?text=${encodeURIComponent(
                              item.name ||
                                "Product"
                            )}`;
                        }}
                        style={{
                          width: "100%",
                          height: "100%",
                          display: "block",
                          objectFit: "cover",
                        }}
                      />
                    </div>

                    {/* PRODUCT INFO */}

                    <div
                      style={{
                        flex: 1,
                        minWidth: 0,
                      }}
                    >
                      <strong
                        style={{
                          display: "block",
                          fontSize: 14,
                          lineHeight: 1.35,
                          marginBottom: 5,
                          overflow: "hidden",
                          textOverflow:
                            "ellipsis",
                          whiteSpace:
                            "nowrap",
                        }}
                      >
                        {item.name}
                      </strong>

                      <span
                        style={{
                          display: "block",
                          color: "#64748b",
                          fontSize: 13,
                        }}
                      >
                        Qty: {quantity}
                      </span>

                      <span
                        style={{
                          display: "block",
                          color: "#2563eb",
                          fontSize: 13,
                          fontWeight: 700,
                          marginTop: 3,
                        }}
                      >
                        {money(price)} each
                      </span>
                    </div>

                    {/* ITEM TOTAL */}

                    <strong
                      style={{
                        whiteSpace:
                          "nowrap",
                        fontSize: 14,
                      }}
                    >
                      {money(
                        price * quantity
                      )}
                    </strong>
                  </div>
                );
              })}
            </div>

            {/* ITEMS */}

            <div
              style={summaryRow}
            >
              <span>
                Subtotal ({totalItems}{" "}
                {totalItems === 1
                  ? "item"
                  : "items"})
              </span>

              <strong>
                {money(subtotal)}
              </strong>
            </div>

            {/* DELIVERY */}

            <div
              style={{
                ...summaryRow,
                marginTop: 12,
              }}
            >
              <span>
                Delivery
              </span>

              <strong
                style={{
                  color: "#16a34a",
                }}
              >
                FREE
              </strong>
            </div>

            <hr
              style={{
                border: 0,
                borderTop:
                  "1px solid #e5e7eb",
                margin: "18px 0",
              }}
            />

            {/* TOTAL */}

            <div
              style={{
                display: "flex",
                justifyContent:
                  "space-between",
                alignItems: "center",
                fontSize: 21,
                margin: "17px 0",
              }}
            >
              <strong>
                Total
              </strong>

              <strong
                style={{
                  color: "#2563eb",
                }}
              >
                {money(total)}
              </strong>
            </div>

            {/* PLACE ORDER */}

            <button
              type="button"
              disabled={placingOrder}
              onClick={placeOrder}
              style={{
                width: "100%",
                padding: 15,
                border: 0,
                borderRadius: 11,

                background:
                  placingOrder
                    ? "#94a3b8"
                    : "linear-gradient(135deg,#2563eb,#4f46e5)",

                color: "#fff",

                cursor:
                  placingOrder
                    ? "not-allowed"
                    : "pointer",

                fontWeight: 900,

                fontSize: 16,
              }}
            >
              {placingOrder
                ? "Placing Order..."
                : "Place Order →"}
            </button>

            <p
              style={{
                color: "#64748b",
                fontSize: 12,
                textAlign: "center",
                marginTop: 12,
              }}
            >
              Your cart will be
              cleared only after the
              order is successfully
              saved.
            </p>
          </aside>
        </div>
      </div>
    </main>
  );
}

const labelStyle: CSSProperties = {
  display: "block",
  marginBottom: 6,
  fontWeight: 700,
};

const inputStyle: CSSProperties = {
  width: "100%",
  boxSizing: "border-box",
  border:
    "1px solid #dbe3f0",
  borderRadius: 10,
  padding: "12px 13px",
  fontSize: 15,
  outline: "none",
  background: "#fff",
};

const summaryRow: CSSProperties = {
  display: "flex",
  justifyContent:
    "space-between",
  alignItems: "center",
  gap: 12,
};