import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "Student Marketplace",
  description:
    "Student Marketplace - Books, stationery, laptops and exam preparation essentials.",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}