import { NextRequest, NextResponse } from "next/server";

const PRODUCT_SERVICE_URL =
  process.env.PRODUCT_SERVICE_URL ||
  "http://localhost:5001/api";

export async function GET(request: NextRequest) {
  try {
    const { searchParams } = new URL(request.url);

    const limit = searchParams.get("limit") || "272";
    const category = searchParams.get("category");
    const search = searchParams.get("search");

    const params = new URLSearchParams();

    params.set("limit", limit);

    if (category) {
      params.set("category", category);
    }

    if (search) {
      params.set("search", search);
    }

    const url = `${PRODUCT_SERVICE_URL}/products?${params.toString()}`;

    console.log("NEXT API → PRODUCT SERVICE:", url);

    const response = await fetch(url, {
      method: "GET",
      cache: "no-store",
      headers: {
        Accept: "application/json",
      },
    });

    const text = await response.text();

    console.log(
      "PRODUCT SERVICE STATUS:",
      response.status
    );

    if (!response.ok) {
      return NextResponse.json(
        {
          success: false,
          message: `Product Service returned HTTP ${response.status}`,
          serviceResponse: text,
        },
        {
          status: response.status,
        }
      );
    }

    let data: unknown;

    try {
      data = JSON.parse(text);
    } catch {
      return NextResponse.json(
        {
          success: false,
          message: "Product Service returned invalid JSON.",
          rawResponse: text,
        },
        {
          status: 502,
        }
      );
    }

    return NextResponse.json(data, {
      status: 200,
      headers: {
        "Cache-Control": "no-store",
      },
    });
  } catch (error) {
    console.error(
      "NEXT /api/products ERROR:",
      error
    );

    return NextResponse.json(
      {
        success: false,
        message: "Unable to connect to Product Service.",
        error:
          error instanceof Error
            ? error.message
            : "Unknown error",
      },
      {
        status: 500,
      }
    );
  }
}