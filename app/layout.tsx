import type { Metadata } from "next";
import "./globals.css";
import AppShell from "./app-shell";
import { createClient } from "@/lib/supabase/server";

export const metadata: Metadata = { title: "Healing Echoes", description: "Turn one healing offering into a complete, authentic campaign." };

export default async function RootLayout({ children }: { children: React.ReactNode }) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();
  return <html lang="en"><body><AppShell userEmail={user?.email ?? null}>{children}</AppShell></body></html>;
}
