"use client";

import { useEffect, useMemo, useState } from "react";
import { useRouter } from "next/navigation";

type ProductImage = {
  image_url?: string;
  alt_text?: string;
  is_primary?: boolean;
};

type Product = {
  id: string;
  sku?: string;
  name: string;
  slug?: string;
  description?: string;
  brand?: string;
  price: string | number;
  discount_price?: string | number;
  category_name?: string;
  category_slug?: string;
  images?: ProductImage[];
};

type CartItem = {
  product: Product;
  quantity: number;
};

const CART_KEY = "student-marketplace-cart";

const FALLBACK_IMAGE =
  "https://placehold.co/800x600/png?text=Student+Marketplace";

function getProductImage(product: Product): string {
  const primaryImage = product.images?.find(
    (image) => image.is_primary && image.image_url
  );

  if (primaryImage?.image_url) {
    return primaryImage.image_url;
  }

  const firstImage = product.images?.find(
    (image) => image.image_url
  );

  if (firstImage?.image_url) {
    return firstImage.image_url;
  }

  return FALLBACK_IMAGE;
}

function getProductPrice(product: Product): number {
  const discountPrice = Number(product.discount_price || 0);
  const normalPrice = Number(product.price || 0);

  if (
    discountPrice > 0 &&
    normalPrice > 0 &&
    discountPrice < normalPrice
  ) {
    return discountPrice;
  }

  return normalPrice;
}

function formatMoney(value: number): string {
  return `₹${value.toLocaleString("en-IN", {
    maximumFractionDigits: 2,
  })}`;
}

function normalizeCart(value: unknown): CartItem[] {
  if (!Array.isArray(value)) {
    return [];
  }

  return value
    .filter((item): item is CartItem => {
      if (!item || typeof item !== "object") {
        return false;
      }

      const cartItem = item as Partial<CartItem>;

      return Boolean(
        cartItem.product &&
          typeof cartItem.product === "object" &&
          cartItem.product.id &&
          cartItem.product.name
      );
    })
    .map((item) => ({
      product: item.product,
      quantity:
        Number(item.quantity) > 0
          ? Math.floor(Number(item.quantity))
          : 1,
    }));
}

export default function CartPage() {
  const router = useRouter();

  const [cart, setCart] = useState<CartItem[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const loadCart = () => {
      try {
        const savedCart = localStorage.getItem(CART_KEY);

        if (!savedCart) {
          setCart([]);
          return;
        }

        const parsed = JSON.parse(savedCart);

        setCart(normalizeCart(parsed));
      } catch (error) {
        console.error("CART LOAD ERROR:", error);
        setCart([]);
      } finally {
        setLoading(false);
      }
    };

    loadCart();

    const handleCartUpdate = () => {
      loadCart();
    };

    window.addEventListener(
      "student-marketplace-cart-updated",
      handleCartUpdate
    );

    window.addEventListener("storage", handleCartUpdate);

    return () => {
      window.removeEventListener(
        "student-marketplace-cart-updated",
        handleCartUpdate
      );

      window.removeEventListener(
        "storage",
        handleCartUpdate
      );
    };
  }, []);

  const saveCart = (nextCart: CartItem[]) => {
    setCart(nextCart);

    try {
      localStorage.setItem(
        CART_KEY,
        JSON.stringify(nextCart)
      );

      window.dispatchEvent(
        new Event("student-marketplace-cart-updated")
      );
    } catch (error) {
      console.error("CART SAVE ERROR:", error);
    }
  };

  const increaseQuantity = (productId: string) => {
    const nextCart = cart.map((item) => {
      if (item.product.id !== productId) {
        return item;
      }

      return {
        ...item,
        quantity: item.quantity + 1,
      };
    });

    saveCart(nextCart);
  };

  const decreaseQuantity = (productId: string) => {
    const nextCart = cart
      .map((item) => {
        if (item.product.id !== productId) {
          return item;
        }

        return {
          ...item,
          quantity: item.quantity - 1,
        };
      })
      .filter((item) => item.quantity > 0);

    saveCart(nextCart);
  };

  const removeItem = (productId: string) => {
    const nextCart = cart.filter(
      (item) => item.product.id !== productId
    );

    saveCart(nextCart);
  };

  const clearCart = () => {
    const confirmed = window.confirm(
      "Are you sure you want to remove all products from your cart?"
    );

    if (!confirmed) {
      return;
    }

    saveCart([]);
  };

  const totalItems = useMemo(() => {
    return cart.reduce(
      (total, item) => total + item.quantity,
      0
    );
  }, [cart]);

  const subtotal = useMemo(() => {
    return cart.reduce((total, item) => {
      const price = getProductPrice(item.product);

      return total + price * item.quantity;
    }, 0);
  }, [cart]);

  const originalTotal = useMemo(() => {
    return cart.reduce((total, item) => {
      const originalPrice = Number(
        item.product.price || 0
      );

      return (
        total +
        originalPrice * item.quantity
      );
    }, 0);
  }, [cart]);

  const totalSavings = Math.max(
    0,
    originalTotal - subtotal
  );

  const deliveryCharge = subtotal > 0 ? 0 : 0;

  const grandTotal = subtotal + deliveryCharge;

  const goToCheckout = () => {
    if (cart.length === 0) {
      window.alert(
        "Your cart is empty. Please add a product first."
      );

      router.push("/");
      return;
    }

    router.push("/checkout");
  };

  if (loading) {
    return (
      <main
        style={{
          minHeight: "100vh",
          background: "#f6f8fc",
          display: "grid",
          placeItems: "center",
          color: "#172033",
        }}
      >
        <div
          style={{
            textAlign: "center",
          }}
        >
          <div
            style={{
              fontSize: 45,
              marginBottom: 10,
            }}
          >
            🛒
          </div>

          <h2>Loading your cart...</h2>
        </div>
      </main>
    );
  }

  return (
    <main
      style={{
        minHeight: "100vh",
        background: "#f6f8fc",
        color: "#172033",
        paddingBottom: 70,
      }}
    >
      {/* HEADER */}
      <header
        style={{
          background: "#ffffff",
          borderBottom:
            "1px solid #e5e7eb",
          position: "sticky",
          top: 0,
          zIndex: 20,
        }}
      >
        <div
          style={{
            maxWidth: 1200,
            margin: "0 auto",
            padding: "16px 20px",
            display: "flex",
            alignItems: "center",
            justifyContent: "space-between",
            gap: 15,
          }}
        >
          <button
            type="button"
            onClick={() => router.push("/")}
            style={{
              border: 0,
              background: "transparent",
              cursor: "pointer",
              display: "flex",
              alignItems: "center",
              gap: 10,
              color: "#172033",
            }}
          >
            <span
              style={{
                width: 42,
                height: 42,
                borderRadius: 12,
                display: "grid",
                placeItems: "center",
                background:
                  "linear-gradient(135deg,#2563eb,#4f46e5)",
                color: "#fff",
                fontSize: 21,
              }}
            >
              🎓
            </span>

            <span
              style={{
                textAlign: "left",
              }}
            >
              <strong
                style={{
                  display: "block",
                  fontSize: 17,
                }}
              >
                Student
              </strong>

              <small
                style={{
                  display: "block",
                  color: "#2563eb",
                  fontWeight: 900,
                  letterSpacing: 2,
                  fontSize: 9,
                }}
              >
                MARKETPLACE
              </small>
            </span>
          </button>

          <button
            type="button"
            onClick={() => router.push("/")}
            style={{
              border: 0,
              borderRadius: 10,
              padding: "10px 16px",
              background: "#eff6ff",
              color: "#2563eb",
              fontWeight: 800,
              cursor: "pointer",
            }}
          >
            🏠 Continue Shopping
          </button>
        </div>
      </header>

      {/* CONTENT */}
      <div
        style={{
          maxWidth: 1200,
          margin: "0 auto",
          padding: "35px 20px",
        }}
      >
        {/* PAGE TITLE */}
        <div
          style={{
            marginBottom: 25,
          }}
        >
          <p
            style={{
              margin: 0,
              color: "#2563eb",
              fontWeight: 900,
              fontSize: 13,
              letterSpacing: 1.5,
            }}
          >
            YOUR SHOPPING CART
          </p>

          <h1
            style={{
              margin: "6px 0",
              fontSize: 36,
              lineHeight: 1.15,
            }}
          >
            Shopping Cart
          </h1>

          <p
            style={{
              margin: 0,
              color: "#64748b",
              fontSize: 15,
            }}
          >
            {totalItems === 0
              ? "Your cart is currently empty."
              : `${totalItems} item${
                  totalItems === 1 ? "" : "s"
                } in your cart`}
          </p>
        </div>

        {/* EMPTY CART */}
        {cart.length === 0 ? (
          <section
            style={{
              background: "#fff",
              borderRadius: 22,
              padding: "70px 25px",
              textAlign: "center",
              boxShadow:
                "0 10px 35px rgba(15,23,42,.07)",
            }}
          >
            <div
              style={{
                width: 90,
                height: 90,
                borderRadius: "50%",
                background: "#eff6ff",
                display: "grid",
                placeItems: "center",
                margin: "0 auto 20px",
                fontSize: 42,
              }}
            >
              🛒
            </div>

            <h2
              style={{
                margin: "0 0 8px",
                fontSize: 27,
              }}
            >
              Your Cart is Empty
            </h2>

            <p
              style={{
                maxWidth: 500,
                margin: "0 auto 25px",
                color: "#64748b",
                lineHeight: 1.6,
              }}
            >
              You haven't added anything to your
              cart yet. Explore our student products
              and find something useful.
            </p>

            <button
              type="button"
              onClick={() => router.push("/")}
              style={primaryButton}
            >
              🛍️ Start Shopping
            </button>
          </section>
        ) : (
          <div
            style={{
              display: "grid",
              gridTemplateColumns:
                "minmax(0, 1.55fr) minmax(300px, .75fr)",
              gap: 25,
              alignItems: "start",
            }}
          >
            {/* CART PRODUCTS */}
            <section
              style={{
                background: "#fff",
                borderRadius: 20,
                padding: 22,
                boxShadow:
                  "0 10px 35px rgba(15,23,42,.07)",
              }}
            >
              <div
                style={{
                  display: "flex",
                  alignItems: "center",
                  justifyContent: "space-between",
                  gap: 10,
                  marginBottom: 18,
                }}
              >
                <div>
                  <h2
                    style={{
                      margin: 0,
                      fontSize: 22,
                    }}
                  >
                    Cart Items
                  </h2>

                  <p
                    style={{
                      margin: "5px 0 0",
                      color: "#64748b",
                      fontSize: 14,
                    }}
                  >
                    Review your products before
                    checkout.
                  </p>
                </div>

                <button
                  type="button"
                  onClick={clearCart}
                  style={{
                    border: 0,
                    background: "#fef2f2",
                    color: "#dc2626",
                    borderRadius: 9,
                    padding: "9px 12px",
                    fontWeight: 800,
                    cursor: "pointer",
                  }}
                >
                  Clear Cart
                </button>
              </div>

              <div
                style={{
                  display: "grid",
                  gap: 15,
                }}
              >
                {cart.map((item) => {
                  const product = item.product;

                  const price =
                    getProductPrice(product);

                  const normalPrice = Number(
                    product.price || 0
                  );

                  const hasDiscount =
                    normalPrice > price;

                  const image =
                    getProductImage(product);

                  return (
                    <article
                      key={product.id}
                      style={{
                        display: "grid",
                        gridTemplateColumns:
                          "110px minmax(0,1fr) auto",
                        gap: 17,
                        alignItems: "center",
                        padding: 14,
                        border:
                          "1px solid #e8edf5",
                        borderRadius: 16,
                        background: "#fff",
                      }}
                    >
                      {/* IMAGE */}
                      <button
                        type="button"
                        onClick={() =>
                          router.push(
                            `/product/${product.id}`
                          )
                        }
                        style={{
                          border: 0,
                          padding: 0,
                          background: "transparent",
                          cursor: "pointer",
                        }}
                      >
                        <img
                          src={image}
                          alt={
                            product.name ||
                            "Product"
                          }
                          onError={(event) => {
                            if (
                              event.currentTarget
                                .src !==
                              FALLBACK_IMAGE
                            ) {
                              event.currentTarget.src =
                                FALLBACK_IMAGE;
                            }
                          }}
                          style={{
                            width: 110,
                            height: 100,
                            objectFit: "cover",
                            borderRadius: 12,
                            background:
                              "#f1f5f9",
                            display: "block",
                          }}
                        />
                      </button>

                      {/* PRODUCT INFO */}
                      <div
                        style={{
                          minWidth: 0,
                        }}
                      >
                        <button
                          type="button"
                          onClick={() =>
                            router.push(
                              `/product/${product.id}`
                            )
                          }
                          style={{
                            border: 0,
                            padding: 0,
                            background:
                              "transparent",
                            cursor: "pointer",
                            textAlign: "left",
                            color: "#172033",
                            fontWeight: 900,
                            fontSize: 17,
                            marginBottom: 5,
                          }}
                        >
                          {product.name}
                        </button>

                        <div
                          style={{
                            color: "#64748b",
                            fontSize: 13,
                            marginBottom: 7,
                          }}
                        >
                          {product.category_name ||
                            "Student Essential"}
                        </div>

                        <div
                          style={{
                            display: "flex",
                            alignItems: "center",
                            gap: 9,
                            flexWrap: "wrap",
                            marginBottom: 12,
                          }}
                        >
                          <strong
                            style={{
                              fontSize: 18,
                              color: "#172033",
                            }}
                          >
                            {formatMoney(price)}
                          </strong>

                          {hasDiscount && (
                            <del
                              style={{
                                color: "#94a3b8",
                                fontSize: 13,
                              }}
                            >
                              {formatMoney(
                                normalPrice
                              )}
                            </del>
                          )}

                          {hasDiscount && (
                            <span
                              style={{
                                background:
                                  "#dcfce7",
                                color: "#15803d",
                                borderRadius: 999,
                                padding:
                                  "3px 7px",
                                fontSize: 11,
                                fontWeight: 900,
                              }}
                            >
                              SAVE
                            </span>
                          )}
                        </div>

                        {/* QUANTITY */}
                        <div
                          style={{
                            display: "flex",
                            alignItems: "center",
                            gap: 9,
                          }}
                        >
                          <span
                            style={{
                              fontSize: 13,
                              color: "#64748b",
                              fontWeight: 700,
                            }}
                          >
                            Quantity:
                          </span>

                          <div
                            style={{
                              display: "flex",
                              alignItems:
                                "center",
                              border:
                                "1px solid #dbe3ef",
                              borderRadius: 9,
                              overflow: "hidden",
                            }}
                          >
                            <button
                              type="button"
                              onClick={() =>
                                decreaseQuantity(
                                  product.id
                                )
                              }
                              style={
                                quantityButton
                              }
                            >
                              −
                            </button>

                            <span
                              style={{
                                minWidth: 38,
                                textAlign:
                                  "center",
                                fontWeight: 900,
                                fontSize: 14,
                              }}
                            >
                              {item.quantity}
                            </span>

                            <button
                              type="button"
                              onClick={() =>
                                increaseQuantity(
                                  product.id
                                )
                              }
                              style={
                                quantityButton
                              }
                            >
                              +
                            </button>
                          </div>
                        </div>
                      </div>

                      {/* RIGHT */}
                      <div
                        style={{
                          display: "flex",
                          flexDirection:
                            "column",
                          alignItems: "flex-end",
                          justifyContent:
                            "space-between",
                          height: "100%",
                          gap: 20,
                        }}
                      >
                        <strong
                          style={{
                            fontSize: 17,
                          }}
                        >
                          {formatMoney(
                            price *
                              item.quantity
                          )}
                        </strong>

                        <button
                          type="button"
                          onClick={() =>
                            removeItem(
                              product.id
                            )
                          }
                          style={{
                            border: 0,
                            background:
                              "#fef2f2",
                            color: "#dc2626",
                            borderRadius: 8,
                            padding:
                              "7px 10px",
                            cursor: "pointer",
                            fontWeight: 800,
                          }}
                        >
                          🗑️ Remove
                        </button>
                      </div>
                    </article>
                  );
                })}
              </div>
            </section>

            {/* ORDER SUMMARY */}
            <aside
              style={{
                background: "#fff",
                borderRadius: 20,
                padding: 23,
                boxShadow:
                  "0 10px 35px rgba(15,23,42,.07)",
                position: "sticky",
                top: 90,
              }}
            >
              <h2
                style={{
                  margin: "0 0 20px",
                  fontSize: 22,
                }}
              >
                Order Summary
              </h2>

              <div
                style={{
                  display: "grid",
                  gap: 13,
                }}
              >
                <div
                  style={summaryRow}
                >
                  <span>
                    Items ({totalItems})
                  </span>

                  <strong>
                    {formatMoney(subtotal)}
                  </strong>
                </div>

                <div
                  style={summaryRow}
                >
                  <span>Delivery</span>

                  <strong
                    style={{
                      color: "#16a34a",
                    }}
                  >
                    FREE
                  </strong>
                </div>

                {totalSavings > 0 && (
                  <div
                    style={summaryRow}
                  >
                    <span>You Save</span>

                    <strong
                      style={{
                        color: "#16a34a",
                      }}
                    >
                      -{formatMoney(
                        totalSavings
                      )}
                    </strong>
                  </div>
                )}
              </div>

              <hr
                style={{
                  border: 0,
                  borderTop:
                    "1px solid #e5e7eb",
                  margin: "20px 0",
                }}
              />

              <div
                style={{
                  display: "flex",
                  justifyContent:
                    "space-between",
                  alignItems: "center",
                  gap: 10,
                  marginBottom: 20,
                }}
              >
                <strong
                  style={{
                    fontSize: 19,
                  }}
                >
                  Total
                </strong>

                <strong
                  style={{
                    fontSize: 25,
                    color: "#2563eb",
                  }}
                >
                  {formatMoney(grandTotal)}
                </strong>
              </div>

              {/* CHECKOUT */}
              <button
                type="button"
                onClick={goToCheckout}
                style={{
                  ...primaryButton,
                  width: "100%",
                  fontSize: 16,
                  padding: "15px 18px",
                }}
              >
                Proceed to Checkout →
              </button>

              <button
                type="button"
                onClick={() => router.push("/")}
                style={{
                  width: "100%",
                  marginTop: 10,
                  padding: "12px 16px",
                  border:
                    "1px solid #dbe3ef",
                  borderRadius: 10,
                  background: "#fff",
                  color: "#334155",
                  fontWeight: 800,
                  cursor: "pointer",
                }}
              >
                ← Continue Shopping
              </button>

              <div
                style={{
                  marginTop: 20,
                  padding: 13,
                  borderRadius: 11,
                  background: "#f8fafc",
                  color: "#64748b",
                  fontSize: 12,
                  lineHeight: 1.5,
                  textAlign: "center",
                }}
              >
                🔒 Your cart is saved locally
                and will remain available while
                you shop.
              </div>
            </aside>
          </div>
        )}
      </div>

      {/* RESPONSIVE CSS */}
      <style jsx>{`
        @media (max-width: 850px) {
          main > div {
            padding-left: 14px !important;
            padding-right: 14px !important;
          }

          main section + div {
            grid-template-columns: 1fr !important;
          }

          aside {
            position: static !important;
          }
        }

        @media (max-width: 620px) {
          article {
            grid-template-columns: 80px minmax(0, 1fr) !important;
          }

          article > button:first-child img {
            width: 80px !important;
            height: 80px !important;
          }

          article > div:last-child {
            grid-column: 2 !important;
            flex-direction: row !important;
            align-items: center !important;
            justify-content: space-between !important;
            height: auto !important;
          }

          h1 {
            font-size: 30px !important;
          }
        }

        @media (max-width: 430px) {
          header button:last-child {
            padding: 8px 10px !important;
            font-size: 12px !important;
          }

          article {
            gap: 10px !important;
            padding: 10px !important;
          }

          article > button:first-child img {
            width: 70px !important;
            height: 70px !important;
          }
        }
      `}</style>
    </main>
  );
}

const primaryButton = {
  border: 0,
  borderRadius: 11,
  padding: "13px 20px",
  background:
    "linear-gradient(135deg,#2563eb,#4f46e5)",
  color: "#fff",
  fontWeight: 900,
  cursor: "pointer",
};

const quantityButton = {
  width: 34,
  height: 34,
  border: 0,
  background: "#f8fafc",
  cursor: "pointer",
  fontSize: 18,
  fontWeight: 900,
  color: "#2563eb",
};

const summaryRow = {
  display: "flex",
  justifyContent: "space-between",
  alignItems: "center",
  gap: 10,
  color: "#475569",
  fontSize: 14,
};