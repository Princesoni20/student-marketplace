"use client";

import {
  useEffect,
  useMemo,
  useState,
  type FormEvent,
  type ReactNode,
} from "react";
import { getAuthToken, removeAuthToken } from "@/lib/auth";
const API_BASE_URL = "/api";

const PRODUCT_SERVICE_URL = "/api";
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

type CartItem = {
  product: Product;
  quantity: number;
};

const EXAMS = [
  {
    key: "upsc",
    title: "UPSC",
    icon: "🏛️",
    words: [
      "upsc",
      "indian history",
      "indian polity",
      "indian economy",
      "geography",
      "ethics",
      "environment",
      "current affairs",
      "csat",
      "art & culture",
      "science & technology",
    ],
  },
  {
    key: "jee",
    title: "JEE",
    icon: "🎯",
    words: ["jee main", "jee advanced", "jee", "iit jee"],
  },
  {
    key: "neet",
    title: "NEET",
    icon: "🧬",
    words: ["neet", "biology"],
  },
  {
    key: "gate",
    title: "GATE",
    icon: "⚙️",
    words: ["gate"],
  },
  {
    key: "cat",
    title: "CAT",
    icon: "📊",
    words: ["cat"],
  },
  {
    key: "banking",
    title: "Banking",
    icon: "🏦",
    words: ["banking", "bank"],
  },
  {
    key: "ssc",
    title: "SSC",
    icon: "📝",
    words: ["ssc"],
  },
  {
    key: "railway",
    title: "Railway",
    icon: "🚆",
    words: ["railway"],
  },
  {
    key: "other",
    title: "Other Government Exams",
    icon: "📚",
    words: ["other government exams", "government exam"],
  },
];

const GROUPS = [
  {
    key: "pens",
    title: "Pens",
    subtitle:
      "Ball, gel, fountain, marker, sketch and correction pens",
    icon: "🖊️",
    words: ["pen"],
  },
  {
    key: "notebooks",
    title: "Notebooks",
    subtitle:
      "Class, long, rough, spiral and practical notebooks",
    icon: "📓",
    words: ["notebook"],
  },
  {
    key: "geometry",
    title: "Geometry & Mathematics Tools",
    subtitle:
      "Geometry box, compass, ruler, protractor and scissors",
    icon: "📐",
    words: [
      "geometry",
      "compass",
      "protractor",
      "ruler",
      "scale",
      "set square",
      "scissors",
      "calculator",
    ],
  },
  {
    key: "paper",
    title: "Paper & Project Supplies",
    subtitle:
      "Assignment pages, chart paper and coloured paper",
    icon: "📄",
    words: ["paper", "assignment", "chart"],
  },
  {
    key: "files",
    title: "Files & Organization",
    subtitle:
      "Practical files, folders, clips, staplers and desk supplies",
    icon: "📁",
    words: [
      "file",
      "folder",
      "binder",
      "stapler",
      "staples",
      "divider",
      "sticky",
      "desk organizer",
    ],
  },
];

const IMAGE_LIBRARY: Record<string, string[]> = {
  books: [
    "https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=900&q=85",
    "https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?auto=format&fit=crop&w=900&q=85",
    "https://images.unsplash.com/photo-1495446815901-a7297e633e8?auto=format&fit=crop&w=900&q=85",
    "https://images.unsplash.com/photo-1589998059171-988d887df646?auto=format&fit=crop&w=900&q=85",
    "https://images.unsplash.com/photo-1516979187457-637abb4f9353?auto=format&fit=crop&w=900&q=85",
    "https://images.unsplash.com/photo-1521587760476-6c12a4b040da?auto=format&fit=crop&w=900&q=85",
  ],

  notebooks: [
    "https://images.unsplash.com/photo-1531346878377-a5be20888e57?auto=format&fit=crop&w=900&q=85",
    "https://images.unsplash.com/photo-1517842645767-c639042777db?auto=format&fit=crop&w=900&q=85",
    "https://images.unsplash.com/photo-1511108690759-009324a90311?auto=format&fit=crop&w=900&q=85",
    "https://images.unsplash.com/photo-1499951360447-b19be8fe80f5?auto=format&fit=crop&w=900&q=85",
  ],

  stationery: [
    "https://images.unsplash.com/photo-1455390582262-044cdead277a?auto=format&fit=crop&w=900&q=85",
    "https://images.unsplash.com/photo-1585336261022-680e295ce3fe?auto=format&fit=crop&w=900&q=85",
    "https://images.unsplash.com/photo-1586075010923-2dd4570fb338?auto=format&fit=crop&w=900&q=85",
    "https://images.unsplash.com/photo-1516962215378-7fae4f6b1c59?auto=format&fit=crop&w=900&q=85",
  ],

  laptops: [
    "https://images.unsplash.com/photo-1496181133206-80ce9b88a853?auto=format&fit=crop&w=900&q=85",
    "https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&w=900&q=85",
    "https://images.unsplash.com/photo-1593642632823-8f785ba67e45?auto=format&fit=crop&w=900&q=85",
    "https://images.unsplash.com/photo-1496181133206-80ce9b88a853?auto=format&fit=crop&w=900&q=85",
  ],

  technology: [
    "https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?auto=format&fit=crop&w=900&q=85",
    "https://images.unsplash.com/photo-1527814050087-3793815479db?auto=format&fit=crop&w=900&q=85",
    "https://images.unsplash.com/photo-1587829741301-dc798b83add3?auto=format&fit=crop&w=900&q=85",
    "https://images.unsplash.com/photo-1546435770-a3e426bf472b?auto=format&fit=crop&w=900&q=85",
  ],

  lab: [
    "https://images.unsplash.com/photo-1532094349884-543bc11b234d?auto=format&fit=crop&w=900&q=85",
    "https://images.unsplash.com/photo-1579154204601-01588f351e67?auto=format&fit=crop&w=900&q=85",
    "https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=900&q=85",
    "https://images.unsplash.com/photo-1581093458791-9d42e3c6f0f6?auto=format&fit=crop&w=900&q=85",
    "https://images.unsplash.com/photo-1559757175-0eb30cd8c063?auto=format&fit=crop&w=900&q=85",
  ],

  backpack: [
    "https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&w=900&q=85",
    "https://images.unsplash.com/photo-1622560480605-d83c853bc5c3?auto=format&fit=crop&w=900&q=85",
    "https://images.unsplash.com/photo-1581605405669-fcdf81165afa?auto=format&fit=crop&w=900&q=85",
  ],

  paper: [
    "https://images.unsplash.com/photo-1455390582262-044cdead277a?auto=format&fit=crop&w=900&q=85",
    "https://images.unsplash.com/photo-1499951360447-b19be8fe80f5?auto=format&fit=crop&w=900&q=85",
  ],

  calculator: [
    "https://images.unsplash.com/photo-1596495578064-1c8cae2b8b6a?auto=format&fit=crop&w=900&q=85",
  ],

  default: [
    "https://images.unsplash.com/photo-1497633762265-9d179a990aa6?auto=format&fit=crop&w=900&q=85",
    "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?auto=format&fit=crop&w=900&q=85",
    "https://images.unsplash.com/photo-1523240795612-9a054b0db644?auto=format&fit=crop&w=900&q=85",
  ],
};

function normalize(value = "") {
  return value.toLowerCase().replace(/\s+/g, " ").trim();
}

function hasAny(product: Product, words: string[]) {
  const text = normalize(
    `${product.name} ${product.category_name || ""} ${
      product.category_slug || ""
    } ${product.sku || ""}`
  );

  return words.some((word) =>
    text.includes(normalize(word))
  );
}

function money(value: string | number | undefined) {
  return `₹${Number(value || 0).toLocaleString("en-IN")}`;
}

function slug(value: string) {
  return value
    .toLowerCase()
    .replace(/&/g, "and")
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-|-$/g, "");
}

function categoryIcon(name: string) {
  const n = normalize(name);

  if (n.includes("laptop") || n.includes("macbook")) return "💻";
  if (n.includes("book") || n.includes("ncert")) return "📚";
  if (n.includes("pen")) return "🖊️";
  if (n.includes("notebook")) return "📓";
  if (n.includes("lab")) return "🔬";
  if (n.includes("backpack") || n.includes("bag")) return "🎒";
  if (n.includes("paper") || n.includes("page")) return "📄";
  if (n.includes("calculator")) return "🧮";
  if (n.includes("water")) return "🧴";

  return "🛍️";
}

function isBook(product: Product) {
  return hasAny(product, [
    "book",
    "ncert",
    "upsc",
    "jee",
    "neet",
    "gate",
    "cat",
    "banking",
    "ssc",
    "railway",
    "csat",
    "history",
    "geography",
    "economy",
    "polity",
    "ethics",
    "current affairs",
  ]);
}

function imageType(product: Product) {
  const text = normalize(
    `${product.name} ${product.category_name || ""} ${
      product.category_slug || ""
    }`
  );

  if (
    text.includes("laboratory") ||
    text.includes("laboratory") ||
    text.includes(" lab") ||
    text.endsWith("lab")
  ) {
    return "lab";
  }

  if (
    text.includes("laptop") ||
    text.includes("macbook") ||
    text.includes("surface")
  ) {
    return "laptops";
  }

  if (
    text.includes("backpack") ||
    text.includes("school bag") ||
    text.includes("college bag")
  ) {
    return "backpack";
  }

  if (text.includes("notebook")) {
    return "notebooks";
  }

  if (
    text.includes("pen") ||
    text.includes("pencil") ||
    text.includes("marker") ||
    text.includes("stationery") ||
    text.includes("geometry") ||
    text.includes("ruler") ||
    text.includes("compass")
  ) {
    return "stationery";
  }

  if (
    text.includes("keyboard") ||
    text.includes("mouse") ||
    text.includes("headphone") ||
    text.includes("earphone") ||
    text.includes("tws") ||
    text.includes("usb")
  ) {
    return "technology";
  }

  if (
    text.includes("paper") ||
    text.includes("chart") ||
    text.includes("assignment")
  ) {
    return "paper";
  }

  if (text.includes("calculator")) {
    return "calculator";
  }

  if (isBook(product)) {
    return "books";
  }

  return "default";
}

function hashProduct(product: Product) {
  return [...product.id].reduce(
    (sum, char) => sum + char.charCodeAt(0),
    0
  );
}

function fallbackImage(product: Product) {
  const type = imageType(product);
  const list = IMAGE_LIBRARY[type] || IMAGE_LIBRARY.default;
  const index = hashProduct(product) % list.length;

  // Always keep a guaranteed local/data-URI fallback.
  // This prevents broken-image icons when an external image host is unavailable.
  const emojiMap: Record<string, string> = {
    books: "📚",
    notebooks: "📓",
    stationery: "✏️",
    laptops: "💻",
    technology: "🖥️",
    lab: "🔬",
    backpack: "🎒",
    paper: "📄",
    calculator: "🧮",
    default: "🎓",
  };

  const emoji = emojiMap[type] || emojiMap.default;
  const title = product.name.replace(/[&<>"']/g, "").slice(0, 34);
  const svg = `<svg xmlns="http://www.w3.org/2000/svg" width="900" height="700" viewBox="0 0 900 700">
    <defs><linearGradient id="g" x1="0" x2="1" y1="0" y2="1"><stop offset="0" stop-color="#eef5ff"/><stop offset="1" stop-color="#dbeafe"/></linearGradient></defs>
    <rect width="900" height="700" rx="36" fill="url(#g)"/>
    <circle cx="450" cy="270" r="125" fill="#ffffff" opacity="0.92"/>
    <text x="450" y="315" text-anchor="middle" font-size="120">${emoji}</text>
    <text x="450" y="500" text-anchor="middle" font-family="Arial,sans-serif" font-size="34" font-weight="700" fill="#17345f">${title}</text>
    <text x="450" y="550" text-anchor="middle" font-family="Arial,sans-serif" font-size="22" fill="#64748b">Student Marketplace</text>
  </svg>`;

  // Try the curated remote image first; if it fails, the onError handler
  // replaces it with this guaranteed data image.
  return list[index] || `data:image/svg+xml;charset=UTF-8,${encodeURIComponent(svg)}`;
}

function guaranteedFallbackImage(product: Product) {
  const type = imageType(product);
  const emojiMap: Record<string, string> = {
    books: "📚", notebooks: "📓", stationery: "✏️", laptops: "💻",
    technology: "🖥️", lab: "🔬", backpack: "🎒", paper: "📄",
    calculator: "🧮", default: "🎓",
  };
  const emoji = emojiMap[type] || emojiMap.default;
  const title = product.name.replace(/[&<>"']/g, "").slice(0, 34);
  const svg = `<svg xmlns="http://www.w3.org/2000/svg" width="900" height="700" viewBox="0 0 900 700"><rect width="900" height="700" rx="36" fill="#eef5ff"/><circle cx="450" cy="270" r="125" fill="#fff"/><text x="450" y="315" text-anchor="middle" font-size="120">${emoji}</text><text x="450" y="500" text-anchor="middle" font-family="Arial,sans-serif" font-size="34" font-weight="700" fill="#17345f">${title}</text><text x="450" y="550" text-anchor="middle" font-family="Arial,sans-serif" font-size="22" fill="#64748b">Student Marketplace</text></svg>`;
  return `data:image/svg+xml;charset=UTF-8,${encodeURIComponent(svg)}`;
}

function ProductCard({
  product,
  onOpen,
  onAdd,
  onWishlist,
  isWishlisted,
  image,
}: {
  product: Product;
  onOpen: (product: Product) => void;
  onAdd: (product: Product) => void;
  onWishlist: (product: Product) => void;
  isWishlisted: boolean;
  image: string;
}) {
  const price = Number(product.price || 0);
  const sale = Number(product.discount_price || 0);
  const discounted = sale > 0 && sale < price;

  return (
    <article className="product-card">
      <div className="product-photo">
        {discounted && (
          <span className="sale-badge">
            {Math.round(((price - sale) / price) * 100)}% OFF
          </span>
        )}

        <button
          type="button"
          className="wishlist-button"
          aria-label="Add to wishlist"
          onClick={() => onWishlist(product)}
        >
          {isWishlisted ? "♥" : "♡"}
        </button>

        <button
          type="button"
          className="product-photo-button"
          onClick={() => onOpen(product)}
        >
          <img
            src={image}
            alt={product.name}
            loading="lazy"
            onError={(event) => {
              const target = event.currentTarget;

              if (!target.dataset.fallbackApplied) {
                target.dataset.fallbackApplied = "true";
                target.src = guaranteedFallbackImage(product);
              }
            }}
          />

          <span className="view-pill">
            View Product Details
          </span>
        </button>
      </div>

      <div className="product-info">
        <small>
          {product.category_name || "Student Essential"}
        </small>

        <h3>{product.name}</h3>

        <p>
          {product.description ||
            "Useful for school, college and student life."}
        </p>

        <div className="product-bottom">
          <div>
            <strong>
              {money(discounted ? sale : price)}
            </strong>

            {discounted && <del>{money(price)}</del>}
          </div>

          <button
            type="button"
            onClick={() => onAdd(product)}
          >
            + Cart
          </button>
        </div>
      </div>
    </article>
  );
}

export default function Home() {
  const [products, setProducts] = useState<Product[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  const [search, setSearch] = useState("");
  const [selectedCategory, setSelectedCategory] =
    useState("");

  const [selectedProduct, setSelectedProduct] =
    useState<Product | null>(null);

  const [searchInput, setSearchInput] = useState("");

  const [cart, setCart] = useState<CartItem[]>([]);
  const [wishlist, setWishlist] = useState<Product[]>([]);

  const [cartOpen, setCartOpen] = useState(false);
  const [wishlistOpen, setWishlistOpen] = useState(false);
  const [accountOpen, setAccountOpen] = useState(false);
  const [profile, setProfile] = useState({
    name: "Prince Kumar",
    email: "princesoni1220@gmail.com",
    phone: "7061332607",
  });

    const [authUser, setAuthUser] = useState<{
    id: string;
    firstName: string;
    lastName?: string | null;
    email: string;
    phone?: string | null;
    avatarUrl?: string | null;
    role?: string;
  } | null>(null);

  const [authLoading, setAuthLoading] = useState(true);

  const [mobileMenu, setMobileMenu] = useState(false);
  const [allCategoriesOpen, setAllCategoriesOpen] =
    useState(false);

  const [bookImages, setBookImages] = useState<
    Record<string, string>
  >({});

  useEffect(() => {
    try {
      const savedProfile = localStorage.getItem("student-marketplace-profile");
      if (savedProfile) setProfile(JSON.parse(savedProfile));
    } catch (storageError) {
      console.error("Could not restore profile.", storageError);
    }
  }, []);

  useEffect(() => {
    try {
      localStorage.setItem("student-marketplace-profile", JSON.stringify(profile));
    } catch {}
  }, [profile]);

  useEffect(() => {
    try {
      const savedCart = localStorage.getItem(
        "student-marketplace-cart"
      );

      const savedWishlist = localStorage.getItem(
        "student-marketplace-wishlist"
      );

      if (savedCart) {
        setCart(JSON.parse(savedCart));
      }

      if (savedWishlist) {
        setWishlist(JSON.parse(savedWishlist));
      }
    } catch (storageError) {
      console.error(
        "Could not restore saved shopping data.",
        storageError
      );
    }
  }, []);

  useEffect(() => {
    try {
      localStorage.setItem(
        "student-marketplace-cart",
        JSON.stringify(cart)
      );
    } catch {}
  }, [cart]);

  useEffect(() => {
    try {
      localStorage.setItem(
        "student-marketplace-wishlist",
        JSON.stringify(wishlist)
      );
    } catch {}
  }, [wishlist]);

  useEffect(() => {
    async function load() {
      try {
        setLoading(true);
        setError("");

        const response = await fetch(
          `${API_BASE_URL}/products?page=1&limit=1000`,
          {
            cache: "no-store",
          }
        );

        if (!response.ok) {
          throw new Error(
            "Product service unavailable."
          );
        }

        const result = await response.json();

        if (!result.success) {
          throw new Error(
            "Product API returned an error."
          );
        }

        setProducts(result.data || []);
      } catch (err) {
        console.error(err);

        setError(
          "Products could not be loaded. Make sure Product Service is running on port 5001."
        );
      } finally {
        setLoading(false);
      }
    }

    load();
  }, []);

  useEffect(() => {
    const books = products.filter(
      (product) =>
        isBook(product) &&
        !product.images?.some(
          (image) => image.is_primary || image.image_url
        )
    );

    let cancelled = false;

    async function loadBookCovers() {
      for (const product of books.slice(0, 50)) {
        if (bookImages[product.id]) continue;

        try {
          const q = encodeURIComponent(
            `intitle:${product.name.replace(
              /class (xi|xii|9|10)/gi,
              ""
            )}`
          );

          const response = await fetch(
            `https://www.googleapis.com/books/v1/volumes?q=${q}&maxResults=1&printType=books`
          );

          if (!response.ok) continue;

          const data = await response.json();

          const info = data.items?.[0]?.volumeInfo;

          const cover =
            info?.imageLinks?.thumbnail ||
            info?.imageLinks?.smallThumbnail;

          if (cover && !cancelled) {
            setBookImages((current) => ({
              ...current,
              [product.id]: cover.replace(
                "http://",
                "https://"
              ),
            }));
          }
        } catch {
          // Fallback image is used.
        }
      }
    }

    if (books.length) {
      loadBookCovers();
    }

    return () => {
      cancelled = true;
    };
  }, [products, bookImages]);

  const categories = useMemo(() => {
    const map = new Map<
      string,
      {
        slug: string;
        name: string;
        count: number;
        icon: string;
      }
    >();

    products.forEach((product) => {
      if (!product.category_name) return;

      const key =
        product.category_slug ||
        slug(product.category_name);

      const existing = map.get(key);

      if (existing) {
        existing.count += 1;
      } else {
        map.set(key, {
          slug: key,
          name: product.category_name,
          count: 1,
          icon: categoryIcon(product.category_name),
        });
      }
    });

    return [...map.values()].sort(
      (a, b) =>
        b.count - a.count ||
        a.name.localeCompare(b.name)
    );
  }, [products]);

  const filteredProducts = useMemo(() => {
    return products.filter((product) => {
      const matchesSearch =
        !search ||
        normalize(
          `${product.name} ${
            product.description || ""
          } ${product.brand || ""} ${
            product.category_name || ""
          }`
        ).includes(normalize(search));

      const matchesCategory =
        !selectedCategory ||
        (product.category_slug ||
          slug(product.category_name || "")) ===
          selectedCategory;

      return matchesSearch && matchesCategory;
    });
  }, [products, search, selectedCategory]);

  const ncert = products.filter((product) =>
    hasAny(product, [
      "class 9 ncert",
      "class 10 ncert",
      "class 11 ncert",
      "class 12 ncert",
    ])
  );

  const class9 = ncert.filter((product) =>
    hasAny(product, ["class 9 ncert"])
  );

  const class10 = ncert.filter((product) =>
    hasAny(product, ["class 10 ncert"])
  );

  const class11 = ncert.filter((product) =>
    hasAny(product, ["class 11 ncert"])
  );

  const class12 = ncert.filter((product) =>
    hasAny(product, ["class 12 ncert"])
  );

  const streams = (list: Product[]) => ({
    science: list.filter((product) =>
      hasAny(product, [
        "physics",
        "chemistry",
        "biology",
        "mathematics",
        "computer science",
      ])
    ),

    commerce: list.filter((product) =>
      hasAny(product, [
        "accountancy",
        "business studies",
        "economics",
      ])
    ),

    arts: list.filter((product) =>
      hasAny(product, [
        "history",
        "geography",
        "political",
        "psychology",
        "sociology",
        "art & culture",
      ])
    ),

    common: list.filter((product) =>
      hasAny(product, [
        "english",
        "hindi",
        "physical education",
      ])
    ),
  });

  const stream11 = streams(class11);
  const stream12 = streams(class12);

  const isUsableImageUrl = (value?: string) => {
    if (!value) return false;

    const url = value.trim().toLowerCase();

    if (!url) return false;

    // The product service currently returns placeholder URLs
    // for some products. Do not show those grey placeholders.
    return (
      !url.includes("placehold.co") &&
      !url.includes("placeholder.com") &&
      !url.includes("loremflickr.com") &&
      !url.includes("via.placeholder")
    );
  };

  const imageFor = (product: Product) => {
    const primaryImage =
      product.images?.find(
        (image) =>
          image.is_primary &&
          isUsableImageUrl(image.image_url)
      )?.image_url;

    const firstImage =
      product.images?.find((image) =>
        isUsableImageUrl(image.image_url)
      )?.image_url;

    const googleBookImage = bookImages[product.id];

    return (
      primaryImage ||
      firstImage ||
      (isUsableImageUrl(googleBookImage)
        ? googleBookImage
        : "") ||
      fallbackImage(product)
    );
  };

  const cartCount = cart.reduce(
    (total, item) => total + item.quantity,
    0
  );

  const cartTotal = cart.reduce((total, item) => {
    const price =
      Number(item.product.discount_price) ||
      Number(item.product.price) ||
      0;

    return total + price * item.quantity;
  }, 0);

  const isWishlisted = (product: Product) =>
    wishlist.some((item) => item.id === product.id);

  const scrollTo = (id: string) => {
    setMobileMenu(false);

    document.getElementById(id)?.scrollIntoView({
      behavior: "smooth",
      block: "start",
    });
  };

  const goHome = () => {
    setSearch("");
    setSearchInput("");
    setSelectedCategory("");
    setAllCategoriesOpen(false);
    setMobileMenu(false);

    window.scrollTo({
      top: 0,
      behavior: "smooth",
    });
  };

  const chooseCategory = (value: string) => {
    setSearch("");
    setSearchInput("");
    setSelectedCategory(value);

    scrollTo("products");
  };

  const addToCart = (product: Product) => {
    setCart((current) => {
      const existing = current.find(
        (item) => item.product.id === product.id
      );

      if (existing) {
        return current.map((item) =>
          item.product.id === product.id
            ? {
                ...item,
                quantity: item.quantity + 1,
              }
            : item
        );
      }

      return [
        ...current,
        {
          product,
          quantity: 1,
        },
      ];
    });

    setCartOpen(true);
  };

  const removeFromCart = (productId: string) => {
    setCart((current) =>
      current.filter(
        (item) => item.product.id !== productId
      )
    );
  };

  const changeQuantity = (
    productId: string,
    amount: number
  ) => {
    setCart((current) =>
      current
        .map((item) =>
          item.product.id === productId
            ? {
                ...item,
                quantity: Math.max(
                  1,
                  item.quantity + amount
                ),
              }
            : item
        )
        .filter((item) => item.quantity > 0)
    );
  };

  const toggleWishlist = (product: Product) => {
    setWishlist((current) => {
      const exists = current.some(
        (item) => item.id === product.id
      );

      if (exists) {
        return current.filter(
          (item) => item.id !== product.id
        );
      }

      return [...current, product];
    });
  };

  const searchSubmit = (event: FormEvent) => {
    event.preventDefault();

    setSelectedCategory("");
    setSearch(searchInput.trim());

    scrollTo("products");
  };

  const sectionProducts = (words: string[]) =>
    products.filter((product) =>
      hasAny(product, words)
    );

  const examProducts = (words: string[]) =>
    products.filter((product) =>
      hasAny(product, words)
    );

  const renderCards = (list: Product[]) => {
    if (!list.length) {
      return (
        <div className="empty-mini">
          <span>📦</span>
          <strong>Products coming soon</strong>
          <small>
            This category is ready for more student
            products.
          </small>
        </div>
      );
    }

    return (
      <div className="product-grid">
        {list.map((product) => (
          <ProductCard
            key={product.id}
            product={product}
            image={imageFor(product)}
            onOpen={setSelectedProduct}
            onAdd={addToCart}
            onWishlist={toggleWishlist}
            isWishlisted={isWishlisted(product)}
          />
        ))}
      </div>
    );
  };

  return (
    <>
      <style jsx global>{`
        /* These styles keep the marketplace functional even if
           an older globals.css is still cached. */

        .drawer-backdrop {
          position: fixed !important;
          inset: 0 !important;
          z-index: 99999 !important;
          display: flex !important;
          justify-content: flex-end !important;
          background: rgba(15, 23, 42, 0.62) !important;
          backdrop-filter: blur(5px) !important;
          -webkit-backdrop-filter: blur(5px) !important;
        }

        .cart-drawer {
          position: relative !important;
          width: min(460px, 94vw) !important;
          height: 100vh !important;
          max-height: 100vh !important;
          overflow-y: auto !important;
          box-sizing: border-box !important;
          padding: 24px !important;
          background: #ffffff !important;
          color: #10203a !important;
          box-shadow: -20px 0 60px rgba(15, 23, 42, 0.25) !important;
          animation: marketplaceDrawerIn 0.25s ease-out !important;
        }

        @keyframes marketplaceDrawerIn {
          from {
            transform: translateX(100%);
            opacity: 0.6;
          }
          to {
            transform: translateX(0);
            opacity: 1;
          }
        }

        .drawer-header {
          display: flex !important;
          align-items: flex-start !important;
          justify-content: space-between !important;
          gap: 16px !important;
          padding-bottom: 18px !important;
          margin-bottom: 18px !important;
          border-bottom: 1px solid #e2e8f0 !important;
        }

        .drawer-header h2 {
          margin: 5px 0 0 !important;
        }

        .drawer-header > button {
          width: 40px !important;
          height: 40px !important;
          flex: 0 0 40px !important;
          border: 1px solid #dbe3ef !important;
          border-radius: 50% !important;
          background: #fff !important;
          cursor: pointer !important;
        }

        .drawer-empty {
          min-height: 55vh !important;
          display: grid !important;
          place-items: center !important;
          align-content: center !important;
          text-align: center !important;
        }

        .drawer-empty > div {
          font-size: 58px !important;
          line-height: 1 !important;
        }

        .drawer-empty p {
          max-width: 300px !important;
          color: #64748b !important;
          line-height: 1.6 !important;
        }

        .cart-list,
        .wishlist-list {
          display: grid !important;
          gap: 12px !important;
        }

        .cart-item {
          display: grid !important;
          grid-template-columns: 72px minmax(0, 1fr) auto !important;
          gap: 12px !important;
          align-items: center !important;
          padding: 12px !important;
          border: 1px solid #e2e8f0 !important;
          border-radius: 14px !important;
          background: #f8fafc !important;
        }

        .cart-item img,
        .wishlist-item img {
          width: 100% !important;
          height: 72px !important;
          object-fit: cover !important;
          display: block !important;
          border-radius: 10px !important;
          background: #eef2f7 !important;
        }

        .cart-item-info {
          min-width: 0 !important;
        }

        .cart-item-info strong,
        .wishlist-item strong {
          display: block !important;
          line-height: 1.35 !important;
        }

        .quantity {
          display: flex !important;
          align-items: center !important;
          gap: 8px !important;
          margin-top: 9px !important;
        }

        .quantity button {
          width: 30px !important;
          height: 30px !important;
          border: 1px solid #dbe3ef !important;
          border-radius: 7px !important;
          background: #fff !important;
          cursor: pointer !important;
        }

        .remove-item {
          width: 34px !important;
          height: 34px !important;
          border: 1px solid #fecaca !important;
          border-radius: 8px !important;
          background: #fff !important;
          cursor: pointer !important;
        }

        .wishlist-item {
          display: grid !important;
          grid-template-columns: 78px minmax(0, 1fr) !important;
          gap: 12px !important;
          padding: 12px !important;
          border: 1px solid #e2e8f0 !important;
          border-radius: 14px !important;
          background: #fff !important;
        }

        .wishlist-actions {
          display: flex !important;
          flex-wrap: wrap !important;
          gap: 7px !important;
          margin-top: 10px !important;
        }

        .wishlist-actions button {
          border: 1px solid #dbe3ef !important;
          border-radius: 8px !important;
          padding: 7px 9px !important;
          background: #fff !important;
          cursor: pointer !important;
          font-weight: 800 !important;
        }

        .wishlist-actions button:nth-child(2) {
          color: #fff !important;
          background: #2563eb !important;
          border-color: #2563eb !important;
        }

        .wishlist-actions button:nth-child(3) {
          color: #dc2626 !important;
          border-color: #fecaca !important;
        }

        .cart-summary {
          margin-top: 18px !important;
          padding: 16px !important;
          border: 1px solid #e2e8f0 !important;
          border-radius: 14px !important;
          background: #f8fafc !important;
        }

        .cart-summary > div {
          display: flex !important;
          justify-content: space-between !important;
          margin-bottom: 10px !important;
        }

        .checkout-button {
          width: 100% !important;
        }

        .modal-backdrop {
          position: fixed !important;
          inset: 0 !important;
          z-index: 99998 !important;
          display: grid !important;
          place-items: center !important;
          padding: 20px !important;
          box-sizing: border-box !important;
          background: rgba(15, 23, 42, 0.7) !important;
          backdrop-filter: blur(5px) !important;
          -webkit-backdrop-filter: blur(5px) !important;
        }

        .modal {
          position: relative !important;
          width: min(900px, 96vw) !important;
          max-height: 90vh !important;
          overflow-y: auto !important;
          display: grid !important;
          grid-template-columns: minmax(280px, 0.9fr) minmax(280px, 1fr) !important;
          gap: 28px !important;
          padding: 28px !important;
          box-sizing: border-box !important;
          border-radius: 22px !important;
          background: #fff !important;
          color: #10203a !important;
          box-shadow: 0 30px 90px rgba(15, 23, 42, 0.3) !important;
        }

        .modal-close {
          position: absolute !important;
          top: 12px !important;
          right: 12px !important;
          z-index: 3 !important;
          width: 38px !important;
          height: 38px !important;
          border: 1px solid #dbe3ef !important;
          border-radius: 50% !important;
          background: #fff !important;
          cursor: pointer !important;
        }

        .modal-image-wrap {
          min-height: 360px !important;
          overflow: hidden !important;
          border-radius: 16px !important;
          background: #f1f5f9 !important;
        }

        .modal-image-wrap img {
          width: 100% !important;
          height: 100% !important;
          min-height: 360px !important;
          display: block !important;
          object-fit: cover !important;
        }

        .modal-actions {
          display: flex !important;
          flex-wrap: wrap !important;
          gap: 9px !important;
          margin-top: 20px !important;
        }

        .modal-actions button {
          min-height: 44px !important;
        }

        .product-card {
          overflow: hidden !important;
          min-width: 0 !important;
        }

        .product-photo {
          position: relative !important;
          overflow: hidden !important;
          min-height: 260px !important;
          background: #eef2f7 !important;
          border-radius: 18px !important;
        }

        .product-photo-button {
          position: relative !important;
          display: block !important;
          width: 100% !important;
          height: 260px !important;
          padding: 0 !important;
          border: 0 !important;
          background: #eef2f7 !important;
          cursor: pointer !important;
          overflow: hidden !important;
        }

        .product-photo-button img {
          width: 100% !important;
          height: 100% !important;
          min-height: 260px !important;
          display: block !important;
          object-fit: cover !important;
          transition: transform .25s ease !important;
        }

        .product-photo-button:hover img {
          transform: scale(1.04) !important;
        }

        .view-pill {
          position: absolute !important;
          left: 12px !important;
          right: 12px !important;
          bottom: 12px !important;
          padding: 9px 12px !important;
          border-radius: 10px !important;
          background: rgba(15,23,42,.86) !important;
          color: #fff !important;
          font-size: 12px !important;
          font-weight: 800 !important;
          text-align: center !important;
        }

        .wishlist-button {
          position: absolute !important;
          top: 12px !important;
          right: 12px !important;
          z-index: 4 !important;
          width: 40px !important;
          height: 40px !important;
          border: 1px solid rgba(255,255,255,.8) !important;
          border-radius: 50% !important;
          background: rgba(255,255,255,.94) !important;
          cursor: pointer !important;
          font-size: 20px !important;
        }

        .account-drawer {
          width: min(520px, 94vw) !important;
          min-height: 100vh !important;
          overflow-y: auto !important;
          box-sizing: border-box !important;
          padding: 26px !important;
          background: #fff !important;
          color: #10203a !important;
          box-shadow: -20px 0 60px rgba(15,23,42,.25) !important;
        }

        .dashboard-grid {
          display: grid !important;
          grid-template-columns: repeat(3, minmax(0,1fr)) !important;
          gap: 10px !important;
          margin: 18px 0 !important;
        }

        .dashboard-stat {
          padding: 16px !important;
          border: 1px solid #e2e8f0 !important;
          border-radius: 14px !important;
          background: #f8fafc !important;
          text-align: center !important;
        }

        .dashboard-stat strong {
          display: block !important;
          font-size: 24px !important;
        }

        .dashboard-stat span {
          color: #64748b !important;
          font-size: 12px !important;
        }

        .profile-form {
          display: grid !important;
          gap: 12px !important;
        }

        .profile-form label {
          display: grid !important;
          gap: 6px !important;
          font-size: 13px !important;
          font-weight: 800 !important;
        }

        .profile-form input {
          width: 100% !important;
          box-sizing: border-box !important;
          padding: 12px 13px !important;
          border: 1px solid #dbe3ef !important;
          border-radius: 10px !important;
          outline: none !important;
        }

        .account-links {
          display: grid !important;
          gap: 9px !important;
          margin: 18px 0 !important;
        }

        .account-link {
          display: flex !important;
          align-items: center !important;
          justify-content: space-between !important;
          padding: 13px 14px !important;
          border: 1px solid #e2e8f0 !important;
          border-radius: 12px !important;
          background: #fff !important;
          cursor: pointer !important;
          font-weight: 800 !important;
        }

        .footer {
          position: relative !important;
          z-index: 1 !important;
          clear: both !important;
        }

        @media (max-width: 700px) {
          .dashboard-grid {
            grid-template-columns: 1fr !important;
          }

          .product-photo,
          .product-photo-button,
          .product-photo-button img {
            min-height: 230px !important;
            height: 230px !important;
          }

          .cart-drawer {
            width: 100% !important;
            padding: 18px !important;
          }

          .modal {
            grid-template-columns: 1fr !important;
            padding: 18px !important;
          }

          .modal-image-wrap,
          .modal-image-wrap img {
            min-height: 250px !important;
          }

          .cart-item {
            grid-template-columns: 62px minmax(0, 1fr) auto !important;
          }

          .wishlist-item {
            grid-template-columns: 65px minmax(0, 1fr) !important;
          }

          .cart-item img,
          .wishlist-item img {
            height: 62px !important;
          }
        }
      `}</style>

      <main className="site">
      <header className="header">
        <div className="header-main">
          <button
            type="button"
            className="logo"
            onClick={goHome}
          >
            <span className="logo-mark">🎓</span>

            <span>
              <strong>Student</strong>
              <small>MARKETPLACE</small>
            </span>
          </button>

          <form
            className="search"
            onSubmit={searchSubmit}
          >
            <span>⌕</span>

            <input
              value={searchInput}
              onChange={(event) =>
                setSearchInput(event.target.value)
              }
              placeholder="Search books, laptops, pens, exams..."
            />

            <button type="submit">Search</button>
          </form>

          <div className="header-actions">
            <button
              type="button"
              onClick={() => {
                setWishlistOpen(true);
                setCartOpen(false);
              }}
            >
              ♡ Wishlist
              {wishlist.length > 0 && (
                <b>{wishlist.length}</b>
              )}
            </button>

            <button
              type="button"
              onClick={() => {
                setCartOpen(true);
                setWishlistOpen(false);
              }}
            >
              🛒 Cart
              {cartCount > 0 && <b>{cartCount}</b>}
            </button>

            <button
              type="button"
              onClick={() => {
                setAccountOpen(true);
                setCartOpen(false);
                setWishlistOpen(false);
              }}
            >
              👤 Account
            </button>
          </div>

          <button
            type="button"
            className="mobile-menu"
            onClick={() =>
              setMobileMenu((value) => !value)
            }
          >
            ☰
          </button>
        </div>

        <nav
          className={
            mobileMenu ? "nav nav-open" : "nav"
          }
        >
          <button
            type="button"
            className="active"
            onClick={goHome}
          >
            🏠 Home
          </button>

          <button
            type="button"
            onClick={() => scrollTo("study")}
          >
            📚 Study
          </button>

          <button
            type="button"
            onClick={() => scrollTo("stationery")}
          >
            ✏️ Stationery
          </button>

          <button
            type="button"
            onClick={() => scrollTo("technology")}
          >
            💻 Technology
          </button>

          <button
            type="button"
            onClick={() => scrollTo("exams")}
          >
            🎯 Exams
          </button>

          <button
            type="button"
            onClick={() => scrollTo("products")}
          >
            🛍️ Shop All
          </button>

          <button
            type="button"
            onClick={() => scrollTo("about")}
          >
            About
          </button>

          <button
            type="button"
            onClick={() => scrollTo("contact")}
          >
            Contact
          </button>
        </nav>
      </header>

      <section className="hero" id="home">
        <div className="hero-copy">
          <span className="eyebrow">
            THE STUDENT-FIRST MARKETPLACE
          </span>

          <h1>
            Study smarter.
            <span>Shop everything.</span>
          </h1>

          <p>
            NCERT books, exam preparation, stationery,
            laptops, backpacks and everyday college
            essentials — organized around the way
            students actually study.
          </p>

          <div className="hero-buttons">
            <button
              type="button"
              className="primary"
              onClick={() => scrollTo("study")}
            >
              Explore Study Store →
            </button>

            <button
              type="button"
              className="secondary"
              onClick={() => scrollTo("exams")}
            >
              Find Exam Books
            </button>
          </div>

          <div className="hero-proof">
            <div>
              <strong>
                {products.length || 100}+
              </strong>
              <span>Products</span>
            </div>

            <div>
              <strong>
                {categories.length || 55}+
              </strong>
              <span>Categories</span>
            </div>

            <div>
              <strong>4</strong>
              <span>NCERT Classes</span>
            </div>
          </div>
        </div>

        <div className="hero-art">
          <div className="hero-card hero-card-one">
            <span>📖</span>
            <strong>NCERT</strong>
            <small>Class 9–12</small>
          </div>

          <div className="hero-card hero-card-two">
            <span>🎯</span>
            <strong>EXAMS</strong>
            <small>
              UPSC • JEE • CAT • GATE
            </small>
          </div>

          <div className="hero-card hero-card-three">
            <span>💻</span>
            <strong>TECH</strong>
            <small>MacBook • Windows</small>
          </div>

          <div className="hero-center">
            <div>🎓</div>
            <strong>
              Built for
              <br />
              students
            </strong>
            <small>Learn • Prepare • Grow</small>
          </div>
        </div>
      </section>

      <section className="study-section" id="study">
        <div className="section-title">
          <span>ACADEMIC STORE</span>

          <h2>
            Books arranged by class & stream
          </h2>

          <p>
            Class 9 and 10 stay simple. Class 11 and
            12 are split into Science, Commerce and
            Arts wherever the product data supports it.
          </p>
        </div>

        <div className="class-grid">
          <div className="class-card">
            <div className="class-head">
              <span>09</span>

              <div>
                <h3>Class 9 NCERT</h3>
                <small>{class9.length} books</small>
              </div>
            </div>

            {renderCards(class9)}
          </div>

          <div className="class-card">
            <div className="class-head">
              <span>10</span>

              <div>
                <h3>Class 10 NCERT</h3>
                <small>
                  {class10.length} books
                </small>
              </div>
            </div>

            {renderCards(class10)}
          </div>
        </div>

        <div className="senior-class">
          <div className="senior-head">
            <div>
              <span>11</span>

              <div>
                <h3>Class 11 NCERT</h3>
                <p>Science • Commerce • Arts</p>
              </div>
            </div>

            <b>{class11.length} books</b>
          </div>

          <StreamBlock
            title="Science"
            icon="🔬"
            products={stream11.science}
            renderCards={renderCards}
          />

          <StreamBlock
            title="Commerce"
            icon="📈"
            products={stream11.commerce}
            renderCards={renderCards}
          />

          <StreamBlock
            title="Arts / Humanities"
            icon="🎨"
            products={stream11.arts}
            renderCards={renderCards}
          />

          {stream11.common.length > 0 && (
            <StreamBlock
              title="Common Subjects"
              icon="📘"
              products={stream11.common}
              renderCards={renderCards}
            />
          )}
        </div>

        <div className="senior-class">
          <div className="senior-head">
            <div>
              <span>12</span>

              <div>
                <h3>Class 12 NCERT</h3>
                <p>Science • Commerce • Arts</p>
              </div>
            </div>

            <b>{class12.length} books</b>
          </div>

          <StreamBlock
            title="Science"
            icon="🔬"
            products={stream12.science}
            renderCards={renderCards}
          />

          <StreamBlock
            title="Commerce"
            icon="📈"
            products={stream12.commerce}
            renderCards={renderCards}
          />

          <StreamBlock
            title="Arts / Humanities"
            icon="🎨"
            products={stream12.arts}
            renderCards={renderCards}
          />

          {stream12.common.length > 0 && (
            <StreamBlock
              title="Common Subjects"
              icon="📘"
              products={stream12.common}
              renderCards={renderCards}
            />
          )}
        </div>
      </section>

      <section className="category-strip">
        <div className="section-title">
          <span>QUICK SHOP</span>

          <h2>
            Find what you need in seconds
          </h2>
        </div>

        <div className="category-row">
          {categories.slice(0, 12).map((category) => (
            <button
              type="button"
              key={category.slug}
              className={
                selectedCategory === category.slug
                  ? "category-chip selected"
                  : "category-chip"
              }
              onClick={() =>
                chooseCategory(category.slug)
              }
            >
              <span>{category.icon}</span>

              <strong>{category.name}</strong>

              <small>
                {category.count} products
              </small>
            </button>
          ))}
        </div>

        <button
          type="button"
          className="all-categories"
          onClick={() =>
            setAllCategoriesOpen((value) => !value)
          }
        >
          {allCategoriesOpen
            ? "Hide all categories ↑"
            : `View all ${
                categories.length || 55
              } categories ↓`}
        </button>

        {allCategoriesOpen && (
          <div className="all-category-grid">
            {categories.map((category) => (
              <button
                type="button"
                key={category.slug}
                onClick={() =>
                  chooseCategory(category.slug)
                }
              >
                <span>{category.icon}</span>

                <strong>{category.name}</strong>

                <small>{category.count}</small>
              </button>
            ))}
          </div>
        )}
      </section>

      <section
        className="group-section"
        id="stationery"
      >
        <div className="section-title">
          <span>STUDY DESK</span>

          <h2>
            Stationery, properly arranged
          </h2>

          <p>
            Pens are together, notebooks are together,
            geometry is together and project supplies
            are grouped separately.
          </p>
        </div>

        {GROUPS.map((group) => (
          <div
            className="product-group"
            key={group.key}
          >
            <div className="group-title">
              <div className="group-icon">
                {group.icon}
              </div>

              <div>
                <h3>{group.title}</h3>
                <p>{group.subtitle}</p>
              </div>
            </div>

            {renderCards(
              sectionProducts(group.words)
            )}
          </div>
        ))}
      </section>

      <section
        className="technology"
        id="technology"
      >
        <div className="section-title">
          <span>STUDENT TECHNOLOGY</span>

          <h2>
            Laptops & digital essentials
          </h2>
        </div>

        <div className="tech-grid">
          <div className="tech-panel">
            <div className="tech-title">
              <span>🍎</span>

              <div>
                <h3>MacBook</h3>
                <p>
                  Apple laptops for coding, study and
                  productivity
                </p>
              </div>
            </div>

            {renderCards(
              products.filter((product) =>
                hasAny(product, ["macbook"])
              )
            )}
          </div>

          <div className="tech-panel">
            <div className="tech-title">
              <span>🪟</span>

              <div>
                <h3>Windows Laptops</h3>

                <p>
                  Windows machines for development,
                  engineering and gaming
                </p>
              </div>
            </div>

            {renderCards(
              products.filter((product) =>
                hasAny(product, [
                  "windows laptop",
                  "msi modern",
                  "msi thin",
                  "surface laptop",
                ])
              )
            )}
          </div>

          <div className="tech-panel full">
            <div className="tech-title">
              <span>🎧</span>

              <div>
                <h3>Accessories</h3>

                <p>
                  Keyboard, mouse, earphones, storage
                  and study technology
                </p>
              </div>
            </div>

            {renderCards(
              sectionProducts([
                "keyboard",
                "mouse",
                "earphone",
                "headphone",
                "tws",
                "usb",
                "external storage",
                "study lamp",
                "calculator",
              ])
            )}
          </div>
        </div>
      </section>

      <section className="exams" id="exams">
        <div className="section-title">
          <span>EXAM PREPARATION</span>

          <h2>
            Prepare for the exam you are targeting
          </h2>

          <p>
            Existing exam books from your catalog are
            shown inside the relevant exam.
          </p>
        </div>

        <div className="exam-grid">
          {EXAMS.map((exam) => {
            const list = examProducts(exam.words);

            return (
              <div
                className="exam-card"
                key={exam.key}
              >
                <div className="exam-head">
                  <span>{exam.icon}</span>

                  <div>
                    <h3>{exam.title}</h3>

                    <small>
                      {list.length
                        ? `${list.length} products`
                        : "Coming soon"}
                    </small>
                  </div>
                </div>

                {list.length > 0 ? (
                  <div className="exam-products">
                    {list.slice(0, 4).map((product) => (
                      <button
                        type="button"
                        key={product.id}
                        onClick={() =>
                          setSelectedProduct(product)
                        }
                      >
                        <img
                          src={imageFor(product)}
                          alt={product.name}
                          onError={(event) => {
                            const target =
                              event.currentTarget;

                            if (
                              !target.dataset
                                .fallbackApplied
                            ) {
                              target.dataset
                                .fallbackApplied =
                                "true";

                              target.src =
                                fallbackImage(
                                  product
                                );
                            }
                          }}
                        />

                        <span>{product.name}</span>
                      </button>
                    ))}
                  </div>
                ) : (
                  <div className="exam-coming">
                    📚
                    <span>
                      Books will appear here
                    </span>
                  </div>
                )}

                <button
                  type="button"
                  className="exam-view"
                  onClick={() => {
                    setSearch(exam.title);
                    setSearchInput(exam.title);
                    scrollTo("products");
                  }}
                >
                  View {exam.title} books →
                </button>
              </div>
            );
          })}
        </div>
      </section>

      <section
        className="products-section"
        id="products"
      >
        <div className="products-head">
          <div>
            <span>SHOP ALL</span>

            <h2>
              {search
                ? `Results for "${search}"`
                : selectedCategory
                ? categories.find(
                    (category) =>
                      category.slug ===
                      selectedCategory
                  )?.name || "Category"
                : "Student Essentials"}
            </h2>

            <p>
              {filteredProducts.length} products shown
            </p>
          </div>

          {(search || selectedCategory) && (
            <button
              type="button"
              className="clear"
              onClick={() => {
                setSearch("");
                setSearchInput("");
                setSelectedCategory("");
              }}
            >
              ✕ Clear
            </button>
          )}
        </div>

        {loading && (
          <div className="loading">
            Loading your student store…
          </div>
        )}

        {!loading && error && (
          <div className="error">
            {error}

            <button
              type="button"
              onClick={() =>
                window.location.reload()
              }
            >
              Try Again
            </button>
          </div>
        )}

        {!loading &&
          !error &&
          renderCards(filteredProducts)}
      </section>

      <section className="about" id="about">
        <div className="about-card">
          <span className="about-icon">🎓</span>

          <div>
            <span>WHY STUDENT MARKETPLACE</span>

            <h2>
              One store built around student life.
            </h2>

            <p>
              The homepage is organized by how
              students shop: school classes,
              senior-secondary streams, exam goals,
              stationery desk groups, laptops and
              everyday essentials.
            </p>

            <div className="about-points">
              <span>✓ Class 9–12 NCERT</span>
              <span>
                ✓ Science / Commerce / Arts
              </span>
              <span>
                ✓ UPSC / JEE / NEET / CAT / GATE
              </span>
              <span>
                ✓ Pens & notebooks grouped
              </span>
              <span>
                ✓ MacBook & Windows laptops
              </span>
              <span>
                ✓ Student-friendly prices
              </span>
            </div>
          </div>
        </div>
      </section>

      <section className="contact" id="contact">
        <div className="section-title">
          <span>GET IN TOUCH</span>

          <h2>Need help?</h2>

          <p>
            Have a question about products, orders or
            the Student Marketplace? Get in touch.
          </p>
        </div>

        <div className="contact-grid">
          <a href="tel:7061332607">
            📞
            <span>7061332607</span>
          </a>

          <a href="mailto:princesoni1220@gmail.com">
            ✉️
            <span>
              princesoni1220@gmail.com
            </span>
          </a>

          <div>
            👤
            <span>
              Founder — Prince Soni
            </span>
          </div>

          <div>
            📍
            <span>India</span>
          </div>

          <div>
            🕘
            <span>
              Mon–Sun, 9 AM–9 PM
            </span>
          </div>
        </div>
      </section>

      <footer className="footer">
        <div className="footer-brand">
          <div className="footer-logo">
            🎓
          </div>

          <div>
            <strong>
              Student Marketplace
            </strong>

            <p>
              Built for students. Organized for the
              way they study.
            </p>
          </div>
        </div>

        <div className="footer-links">
          <button
            type="button"
            onClick={() => scrollTo("study")}
          >
            Study
          </button>

          <button
            type="button"
            onClick={() =>
              scrollTo("stationery")
            }
          >
            Stationery
          </button>

          <button
            type="button"
            onClick={() =>
              scrollTo("technology")
            }
          >
            Technology
          </button>

          <button
            type="button"
            onClick={() => scrollTo("exams")}
          >
            Exams
          </button>

          <button
            type="button"
            onClick={() => scrollTo("contact")}
          >
            Contact
          </button>
        </div>

        <div className="footer-founder">
          <strong>Founder</strong>
          <span>Prince Soni</span>
        </div>

        <div className="footer-bottom">
          <span>
            © 2026 Student Marketplace
          </span>

          <button
            type="button"
            onClick={goHome}
          >
            🏠 Back to Home
          </button>
        </div>
      </footer>

      <button
        type="button"
        className="floating-home"
        onClick={goHome}
      >
        🏠 <span>Home</span>
      </button>

      {accountOpen && (
        <div className="drawer-backdrop" onClick={() => setAccountOpen(false)}>
          <aside className="account-drawer" onClick={(event) => event.stopPropagation()}>
            <div className="drawer-header">
              <div>
                <span>STUDENT ACCOUNT</span>
                <h2>My Dashboard</h2>
              </div>
              <button type="button" onClick={() => setAccountOpen(false)}>✕</button>
            </div>

            <div className="dashboard-stat" style={{ textAlign: "left" }}>
              <strong>👋 Welcome, {profile.name || "Student"}</strong>
              <span>Manage your profile, cart and saved products.</span>
            </div>

            <div className="dashboard-grid">
              <div className="dashboard-stat"><strong>{cartCount}</strong><span>Cart Items</span></div>
              <div className="dashboard-stat"><strong>{wishlist.length}</strong><span>Wishlist</span></div>
              <div className="dashboard-stat"><strong>{products.length}</strong><span>Products</span></div>
            </div>

            <div className="account-links">
  <button
    type="button"
    className="account-link"
    onClick={() => {
      setAccountOpen(false);
      setCartOpen(true);
    }}
  >
    🛒 My Cart <span>→</span>
  </button>

  <button
    type="button"
    className="account-link"
    onClick={() => {
      setAccountOpen(false);
      setWishlistOpen(true);
    }}
  >
    ❤️ My Wishlist <span>→</span>
  </button>

  {/* My Orders */}
  <button
    type="button"
    className="account-link"
    onClick={() => {
      setAccountOpen(false);
      window.location.href = "/account";
    }}
  >
    📦 My Orders <span>→</span>
  </button>

  <button
    type="button"
    className="account-link"
    onClick={() => scrollTo("products")}
  >
    🛍️ Continue Shopping <span>→</span>
  </button>

  <button
    type="button"
    className="account-link"
    onClick={() => scrollTo("contact")}
  >
    📞 Help & Contact <span>→</span>
  </button>
</div>

            <h3>My Profile</h3>
            <form className="profile-form" onSubmit={(event) => { event.preventDefault(); localStorage.setItem("student-marketplace-profile", JSON.stringify(profile)); window.alert("Profile saved successfully."); }}>
              <label>Name<input value={profile.name} onChange={(event) => setProfile((current) => ({ ...current, name: event.target.value }))} placeholder="Your name" /></label>
              <label>Email<input type="email" value={profile.email} onChange={(event) => setProfile((current) => ({ ...current, email: event.target.value }))} placeholder="you@example.com" /></label>
              <label>Phone<input value={profile.phone} onChange={(event) => setProfile((current) => ({ ...current, phone: event.target.value }))} placeholder="Phone number" /></label>
              <button type="submit" className="primary">Save Profile</button>
              {authUser && (
  <button
    type="button"
    className="account-link"
    onClick={() => {
      removeAuthToken();
      setAuthUser(null);
      setAccountOpen(false);
      window.dispatchEvent(
        new Event("student-marketplace-auth-updated")
      );
      window.location.href = "/auth";
    }}
  >
    🚪 Logout <span>→</span>
  </button>
)}
            </form>
          </aside>
        </div>
      )}

      {selectedProduct && (
        <div
          className="modal-backdrop"
          onClick={() =>
            setSelectedProduct(null)
          }
        >
          <div
            className="modal"
            onClick={(event) =>
              event.stopPropagation()
            }
          >
            <button
              type="button"
              className="modal-close"
              onClick={() =>
                setSelectedProduct(null)
              }
            >
              ✕
            </button>

            <div className="modal-image-wrap">
              <img
                src={imageFor(selectedProduct)}
                alt={selectedProduct.name}
                onError={(event) => {
                  const target = event.currentTarget;

                  if (!target.dataset.fallbackApplied) {
                    target.dataset.fallbackApplied =
                      "true";

                    target.src = guaranteedFallbackImage(selectedProduct);
                  }
                }}
              />
            </div>

            <div>
              <small>
                {selectedProduct.category_name ||
                  "Student Product"}
              </small>

              <h2>
                {selectedProduct.name}
              </h2>

              <p>
                {selectedProduct.description ||
                  "A useful product for students."}
              </p>

              {selectedProduct.brand && (
                <p>
                  <strong>Brand:</strong>{" "}
                  {selectedProduct.brand}
                </p>
              )}

              <strong className="modal-price">
                {money(
                  selectedProduct.discount_price ||
                    selectedProduct.price
                )}
              </strong>

              <div className="modal-actions">
                <button
                  type="button"
                  className="primary modal-cart"
                  onClick={() => {
                    addToCart(selectedProduct);
                    setSelectedProduct(null);
                  }}
                >
                  🛒 Add to Cart
                </button>

                <button
                  type="button"
                  className="secondary"
                  onClick={() =>
                    toggleWishlist(
                      selectedProduct
                    )
                  }
                >
                  {isWishlisted(
                    selectedProduct
                  )
                    ? "♥ Wishlisted"
                    : "♡ Add to Wishlist"}
                </button>

                <button
                  type="button"
                  className="secondary"
                  onClick={() => {
                    const productId =
                      encodeURIComponent(
                        selectedProduct.id
                      );

                    window.location.href =
                      `/product/${productId}`;
                  }}
                >
                  View Full Details →
                </button>
              </div>
            </div>
          </div>
        </div>
      )}

      {cartOpen && (
        <div
          className="drawer-backdrop"
          onClick={() => setCartOpen(false)}
        >
          <aside
            className="cart-drawer"
            onClick={(event) =>
              event.stopPropagation()
            }
          >
            <div className="drawer-header">
              <div>
                <span>SHOPPING CART</span>
                <h2>Your Cart</h2>
              </div>

              <button
                type="button"
                onClick={() =>
                  setCartOpen(false)
                }
              >
                ✕
              </button>
            </div>

            {cart.length === 0 ? (
              <div className="drawer-empty">
                <div>🛒</div>
                <h3>Your cart is empty</h3>
                <p>
                  Add products from the marketplace
                  to see them here.
                </p>

                <button
                  type="button"
                  className="primary"
                  onClick={() => {
                    setCartOpen(false);
                    scrollTo("products");
                  }}
                >
                  Start Shopping
                </button>
              </div>
            ) : (
              <>
                <div className="cart-list">
                  {cart.map((item) => {
                    const itemPrice =
                      Number(
                        item.product.discount_price
                      ) ||
                      Number(item.product.price) ||
                      0;

                    return (
                      <div
                        className="cart-item"
                        key={item.product.id}
                      >
                        <img
                          src={imageFor(
                            item.product
                          )}
                          alt={item.product.name}
                        />

                        <div className="cart-item-info">
                          <strong>
                            {item.product.name}
                          </strong>

                          <small>
                            {money(itemPrice)}
                          </small>

                          <div className="quantity">
                            <button
                              type="button"
                              onClick={() =>
                                changeQuantity(
                                  item.product.id,
                                  -1
                                )
                              }
                            >
                              −
                            </button>

                            <span>
                              {item.quantity}
                            </span>

                            <button
                              type="button"
                              onClick={() =>
                                changeQuantity(
                                  item.product.id,
                                  1
                                )
                              }
                            >
                              +
                            </button>
                          </div>
                        </div>

                        <button
                          type="button"
                          className="remove-item"
                          onClick={() =>
                            removeFromCart(
                              item.product.id
                            )
                          }
                        >
                          🗑️
                        </button>
                      </div>
                    );
                  })}
                </div>

                <div className="cart-summary">
                  <div>
                    <span>Items</span>
                    <strong>{cartCount}</strong>
                  </div>

                  <div>
                    <span>Total</span>
                    <strong>
                      {money(cartTotal)}
                    </strong>
                  </div>

                  <button
  type="button"
  className="primary checkout-button"
  onClick={() => {
    setCartOpen(false);
    window.location.href = "/checkout";
  }}
>
  Proceed to Checkout →
</button>
                </div>
              </>
            )}
          </aside>
        </div>
      )}

      {wishlistOpen && (
        <div
          className="drawer-backdrop"
          onClick={() =>
            setWishlistOpen(false)
          }
        >
          <aside
            className="cart-drawer"
            onClick={(event) =>
              event.stopPropagation()
            }
          >
            <div className="drawer-header">
              <div>
                <span>YOUR SAVED PRODUCTS</span>
                <h2>Wishlist</h2>
              </div>

              <button
                type="button"
                onClick={() =>
                  setWishlistOpen(false)
                }
              >
                ✕
              </button>
            </div>

            {wishlist.length === 0 ? (
              <div className="drawer-empty">
                <div>♡</div>

                <h3>
                  Your wishlist is empty
                </h3>

                <p>
                  Save products you want to check
                  later.
                </p>

                <button
                  type="button"
                  className="primary"
                  onClick={() => {
                    setWishlistOpen(false);
                    scrollTo("products");
                  }}
                >
                  Explore Products
                </button>
              </div>
            ) : (
              <div className="wishlist-list">
                {wishlist.map((product) => (
                  <div
                    className="wishlist-item"
                    key={product.id}
                  >
                    <img
                      src={imageFor(product)}
                      alt={product.name}
                    />

                    <div>
                      <strong>
                        {product.name}
                      </strong>

                      <small>
                        {money(
                          product.discount_price ||
                            product.price
                        )}
                      </small>

                      <div className="wishlist-actions">
                        <button
                          type="button"
                          onClick={() => {
                            setWishlistOpen(
                              false
                            );
                            setSelectedProduct(
                              product
                            );
                          }}
                        >
                          View Details
                        </button>

                        <button
                          type="button"
                          onClick={() =>
                            addToCart(product)
                          }
                        >
                          + Cart
                        </button>

                        <button
                          type="button"
                          onClick={() =>
                            toggleWishlist(
                              product
                            )
                          }
                        >
                          Remove
                        </button>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            )}
          </aside>
        </div>
      )}
    </main>
    </>
  );
}

function StreamBlock({
  title,
  icon,
  products,
  renderCards,
}: {
  title: string;
  icon: string;
  products: Product[];
  renderCards: (
    products: Product[]
  ) => ReactNode;
}) {
  return (
    <div className="stream-block">
      <div className="stream-title">
        <span>{icon}</span>

        <div>
          <h4>{title}</h4>

          <small>
            {products.length} books
          </small>
        </div>
      </div>

      {renderCards(products)}
    </div>
  );
}