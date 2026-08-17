"use client";

import { useEffect, useMemo, useState } from "react";
import { useParams, useRouter } from "next/navigation";

type ProductImage = {
  image_url: string;
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

const FALLBACK_IMAGES = {
  stationery:
    "https://images.unsplash.com/photo-1456735190827-d1262f71b8a3?auto=format&fit=crop&w=1200&q=85",

  book:
    "https://images.unsplash.com/photo-1495446815901-a7297e633e8d?auto=format&fit=crop&w=1200&q=85",

  laptop:
    "https://images.unsplash.com/photo-1496181133206-80ce9b88a853?auto=format&fit=crop&w=1200&q=85",

  backpack:
    "https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&w=1200&q=85",

  laboratory:
    "https://images.unsplash.com/photo-1532094349884-543bc11b234d?auto=format&fit=crop&w=1200&q=85",

  paper:
    "https://images.unsplash.com/photo-1455390582262-044cdead277a?auto=format&fit=crop&w=1200&q=85",
};

function money(value: string | number | undefined) {
  return `₹${Number(value || 0).toLocaleString("en-IN")}`;
}

function getFallbackImage(product: Product) {
  const text =
    `${product.name} ${product.category_name || ""} ${product.category_slug || ""}`
      .toLowerCase();

  if (
    text.includes("laptop") ||
    text.includes("computer") ||
    text.includes("macbook")
  ) {
    return FALLBACK_IMAGES.laptop;
  }

  if (
    text.includes("backpack") ||
    text.includes("bag") ||
    text.includes("sleeve")
  ) {
    return FALLBACK_IMAGES.backpack;
  }

  if (
    text.includes("lab") ||
    text.includes("laboratory") ||
    text.includes("microscope") ||
    text.includes("beaker") ||
    text.includes("test tube")
  ) {
    return FALLBACK_IMAGES.laboratory;
  }

  if (
    text.includes("paper") ||
    text.includes("assignment") ||
    text.includes("chart")
  ) {
    return FALLBACK_IMAGES.paper;
  }

  if (
    text.includes("book") ||
    text.includes("ncert") ||
    text.includes("upsc") ||
    text.includes("jee") ||
    text.includes("neet") ||
    text.includes("gate") ||
    text.includes("cat") ||
    text.includes("exam") ||
    text.includes("history") ||
    text.includes("geography")
  ) {
    return FALLBACK_IMAGES.book;
  }

  return FALLBACK_IMAGES.stationery;
}

function getProductImage(product: Product) {
  const primary =
    product.images?.find(
      (image) => image.is_primary
    ) ||
    product.images?.[0];

  const imageUrl = primary?.image_url || "";

  if (
    imageUrl &&
    !imageUrl.includes("placehold.co") &&
    !imageUrl.includes("loremflickr")
  ) {
    return imageUrl;
  }

  return getFallbackImage(product);
}

export default function ProductDetailsPage() {
  const params = useParams<{ id: string }>();
  const router = useRouter();

  const id = params?.id
    ? decodeURIComponent(params.id)
    : "";

  const [product, setProduct] =
    useState<Product | null>(null);

  const [loading, setLoading] =
    useState(true);

  const [error, setError] =
    useState("");

  const [addingCart, setAddingCart] =
    useState(false);

  const [addingWishlist, setAddingWishlist] =
    useState(false);

  useEffect(() => {
    if (!id) {
      setLoading(false);
      return;
    }

    let active = true;

    async function loadProduct() {
      try {
        setLoading(true);
        setError("");

        const response = await fetch(
          `/api/products/${encodeURIComponent(id)}`,
          {
            method: "GET",
            cache: "no-store",
          }
        );

        const result = await response.json();

        if (!response.ok) {
          throw new Error(
            result?.message ||
              "Unable to load product."
          );
        }

        const data =
          result?.data ||
          result?.product ||
          result;

        if (!data?.id) {
          throw new Error(
            "Product was not found."
          );
        }

        if (active) {
          setProduct({
            ...data,
            id: String(data.id),
          });
        }
      } catch (err) {
        console.error(
          "PRODUCT DETAILS ERROR:",
          err
        );

        if (active) {
          setError(
            err instanceof Error
              ? err.message
              : "Unable to load product."
          );
        }
      } finally {
        if (active) {
          setLoading(false);
        }
      }
    }

    loadProduct();

    return () => {
      active = false;
    };
  }, [id]);

  const image = useMemo(
    () =>
      product
        ? getProductImage(product)
        : "",
    [product]
  );

  const addToCart = () => {
    if (!product || addingCart) {
      return;
    }

    try {
      setAddingCart(true);

      const stored = JSON.parse(
        localStorage.getItem(
          "student-marketplace-cart"
        ) || "[]"
      );

      const cart = Array.isArray(stored)
        ? stored
        : [];

      const existing = cart.find(
        (item: any) =>
          String(item.id) ===
          String(product.id)
      );

      const next = existing
        ? cart.map((item: any) =>
            String(item.id) ===
            String(product.id)
              ? {
                  ...item,
                  image,
                  quantity:
                    Number(
                      item.quantity || 1
                    ) + 1,
                }
              : item
          )
        : [
            ...cart,
            {
              ...product,
              image,
              quantity: 1,
            },
          ];

      localStorage.setItem(
        "student-marketplace-cart",
        JSON.stringify(next)
      );

      window.dispatchEvent(
        new Event(
          "student-marketplace-cart-updated"
        )
      );

      router.push("/cart");
    } catch (err) {
      console.error(err);
      window.alert(
        "Unable to add product to cart."
      );
    } finally {
      setAddingCart(false);
    }
  };

  const addToWishlist = () => {
    if (!product || addingWishlist) {
      return;
    }

    try {
      setAddingWishlist(true);

      const stored = JSON.parse(
        localStorage.getItem(
          "student-marketplace-wishlist"
        ) || "[]"
      );

      const wishlist = Array.isArray(stored)
        ? stored
        : [];

      const alreadyExists =
        wishlist.some(
          (item: any) =>
            String(item.id) ===
            String(product.id)
        );

      const next = alreadyExists
        ? wishlist
        : [
            ...wishlist,
            {
              ...product,
              image,
            },
          ];

      localStorage.setItem(
        "student-marketplace-wishlist",
        JSON.stringify(next)
      );

      window.dispatchEvent(
        new Event(
          "student-marketplace-wishlist-updated"
        )
      );

      router.push("/wishlist");
    } catch (err) {
      console.error(err);

      window.alert(
        "Unable to add product to wishlist."
      );
    } finally {
      setAddingWishlist(false);
    }
  };

  if (loading) {
    return (
      <main className="details-page">
        <div className="details-loading">
          <div className="loading-spinner" />
          <h2>Loading Product...</h2>
          <p>
            Please wait while we fetch the
            product details.
          </p>
        </div>
      </main>
    );
  }

  if (error || !product) {
    return (
      <main className="details-page">
        <div className="details-error">
          <div className="error-icon">
            📦
          </div>

          <h1>Product Not Found</h1>

          <p>
            {error ||
              "This product could not be loaded."}
          </p>

          <button
            type="button"
            className="details-primary-button"
            onClick={() => router.push("/")}
          >
            ← Back to Marketplace
          </button>
        </div>
      </main>
    );
  }

  const price = Number(product.price || 0);

  const discountPrice = Number(
    product.discount_price || 0
  );

  const hasDiscount =
    discountPrice > 0 &&
    discountPrice < price;

  const currentPrice = hasDiscount
    ? discountPrice
    : price;

  const discountPercent =
    hasDiscount
      ? Math.round(
          ((price - discountPrice) /
            price) *
            100
        )
      : 0;

  return (
    <main className="details-page">
      <div className="details-container">
        <button
          type="button"
          className="details-back"
          onClick={() => router.push("/")}
        >
          ← Back to Marketplace
        </button>

        <section className="details-card">
          <div className="details-image-section">
            {hasDiscount && (
              <span className="details-sale">
                {discountPercent}% OFF
              </span>
            )}

            <img
              src={image}
              alt={
                product.images?.[0]
                  ?.alt_text ||
                product.name
              }
              className="details-main-image"
              onError={(event) => {
                const target =
                  event.currentTarget;

                const fallback =
                  getFallbackImage(
                    product
                  );

                if (
                  target.src !== fallback
                ) {
                  target.src = fallback;
                }
              }}
            />
          </div>

          <div className="details-content">
            <span className="details-category">
              {product.category_name ||
                "Student Essential"}
            </span>

            <h1>{product.name}</h1>

            {product.brand && (
              <div className="details-brand">
                Brand:{" "}
                <strong>
                  {product.brand}
                </strong>
              </div>
            )}

            <div className="details-rating">
              ★ 4.5
              <span>
                Student Marketplace
              </span>
            </div>

            <p className="details-description">
              {product.description ||
                "Useful product for school, college and everyday student life."}
            </p>

            <div className="details-price">
              <strong>
                {money(currentPrice)}
              </strong>

              {hasDiscount && (
                <del>
                  {money(price)}
                </del>
              )}
            </div>

            {hasDiscount && (
              <div className="details-saving">
                You save{" "}
                {money(
                  price -
                    discountPrice
                )}
              </div>
            )}

            <div className="details-actions">
              <button
                type="button"
                className="details-cart-button"
                onClick={addToCart}
                disabled={addingCart}
              >
                {addingCart
                  ? "Adding..."
                  : "🛒 Add to Cart"}
              </button>

              <button
                type="button"
                className="details-wishlist-button"
                onClick={addToWishlist}
                disabled={addingWishlist}
              >
                {addingWishlist
                  ? "Saving..."
                  : "♡ Wishlist"}
              </button>
            </div>

            <div className="details-features">
              <div>
                <span>🚚</span>
                <div>
                  <strong>
                    Student Friendly
                  </strong>
                  <small>
                    Easy shopping experience
                  </small>
                </div>
              </div>

              <div>
                <span>✓</span>
                <div>
                  <strong>
                    Verified Product
                  </strong>
                  <small>
                    Product information from
                    marketplace catalog
                  </small>
                </div>
              </div>

              <div>
                <span>🔒</span>
                <div>
                  <strong>
                    Secure Shopping
                  </strong>
                  <small>
                    Your cart is saved safely
                  </small>
                </div>
              </div>
            </div>
          </div>
        </section>

        <section className="details-extra">
          <h2>Product Information</h2>

          <div className="details-info-grid">
            <div>
              <span>Product</span>
              <strong>
                {product.name}
              </strong>
            </div>

            <div>
              <span>Category</span>
              <strong>
                {product.category_name ||
                  "Student Essential"}
              </strong>
            </div>

            {product.brand && (
              <div>
                <span>Brand</span>
                <strong>
                  {product.brand}
                </strong>
              </div>
            )}

            {product.sku && (
              <div>
                <span>SKU</span>
                <strong>
                  {product.sku}
                </strong>
              </div>
            )}
          </div>
        </section>

        <div className="details-bottom-actions">
          <button
            type="button"
            onClick={() => router.push("/")}
          >
            ← Continue Shopping
          </button>

          <button
            type="button"
            onClick={() => router.push("/cart")}
          >
            🛒 Open Cart
          </button>

          <button
            type="button"
            onClick={() =>
              router.push("/wishlist")
            }
          >
            ♡ Open Wishlist
          </button>
        </div>
      </div>
    </main>
  );
}