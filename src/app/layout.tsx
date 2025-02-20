import { Inter, Cabinet_Grotesk } from 'next/font/google';
import { Navbar } from '@/components/Navbar';
import { Footer } from '@/components/Footer';
import { Providers } from '@/components/Providers';
import '@/styles/globals.css';

const inter = Inter({ 
  subsets: ['latin'],
  variable: '--font-inter',
});

const cabinetGrotesk = Cabinet_Grotesk({
  subsets: ['latin'],
  variable: '--font-cabinet-grotesk',
});

export const metadata = {
  title: 'AquaEcho - Smart Swimming Assistant',
  description: 'Real-time guidance and tracking for visually impaired and competitive swimmers',
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en" className={`${inter.variable} ${cabinetGrotesk.variable}`}>
      <body className="min-h-screen bg-white dark:bg-gray-950">
        <Providers>
          <Navbar />
          <main>{children}</main>
          <Footer />
        </Providers>
      </body>
    </html>
  );
}