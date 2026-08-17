import { NextRequest, NextResponse } from "next/server";

const PRODUCT_SERVICE_URL =
  process.env.PRODUCT_SERVICE_URL ||
  "http://localhost:5001/api";

export async function GET(
  request: NextRequest,
  context: {
    params: Promise<{ id: string }>;
  }
) {
  try {
    const { id } = await context.params;

    if (!id) {
      return NextResponse.json(
        {
          success: false,
          message: "Product ID is missing.",
        },
        { status: 400 }
      );
    }

    const url =
      `${PRODUCT_SERVICE_URL}/products/` +
      encodeURIComponent(id);

    console.log("NEXT PRODUCT PROXY:", url);

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
          message:
            `Product Service returned HTTP ${response.status}`,
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
          message:
            "Product Service returned invalid JSON.",
          rawResponse: text,
        },
        { status: 502 }
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
      "NEXT PRODUCT PROXY ERROR:",
      error
    );

    return NextResponse.json(
      {
        success: false,
        message:
          "Unable to connect to Product Service.",
        error:
          error instanceof Error
            ? error.message
            : "Unknown error",
      },
      { status: 500 }
    );
  }
}