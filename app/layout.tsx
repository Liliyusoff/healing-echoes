import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "Healing Echoes",
  description: "Turn one healing offering into a complete, authentic campaign.",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body>
        <header className="site-header"><a className="brand" href="/campaigns">Healing Echoes <span>✦</span></a><nav><a href="/campaigns">Campaigns</a><a href="/brand-voice">Brand voice</a><a className="button small" href="/campaigns/new">New campaign</a></nav></header>
        {children}
      </body>
    </html>
  );
}
