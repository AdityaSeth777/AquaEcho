'use client';

import { Analytics } from "@vercel/analytics/react"
import { Hero } from '@/components/Hero';
import { Features } from '@/components/Features';
import { About } from '@/components/About';
import { Contact } from '@/components/Contact';

export default function Home() {
  return (
    <>
      <Hero />
      <Features />
      <About />
      <Contact />
    </>
  );
}