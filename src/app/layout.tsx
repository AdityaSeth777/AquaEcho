import { Inter, Montserrat } from 'next/font/google';
import { Navbar } from '@/components/NavBar';
import { Footer } from '@/components/Footer';
import Providers from '@/components/Providers';
import { Preloader } from '@/components/PreLoader';
import { CustomCursor } from '@/components/CustomCursor';
import '@/styles/globals.css';
import { Analytics } from "@vercel/analytics/react"
import { SpeedInsights } from "@vercel/speed-insights/next"

const inter = Inter({ 
  subsets: ['latin'],
  variable: '--font-inter',
});

const montserrat = Montserrat({
  subsets: ['latin'],
  variable: '--font-montserrat',
});

export const metadata = {
  title: 'AquaEcho - Smart Swimming Assistant',
  description: 'Real-time guidance and tracking for visually impaired and competitive swimmers',
  icons: {
    icon: '/images/favicon.ico',
  },
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en" className={`${inter.variable} ${montserrat.variable}`} suppressHydrationWarning>
      <body className="min-h-screen bg-white dark:bg-gray-950">
        <Providers>
          <Preloader />
          <CustomCursor />
          <Navbar />
          <main>{children}</main>
          <Footer />
        </Providers>
        <Analytics />
        <SpeedInsights />
      </body>
    </html>
  );
}