'use client';

import { useState } from 'react';
import Link from 'next/link';
import Image from 'next/image';
import { Sparkles, Info, Phone, Shield, FileText, Menu, X } from 'lucide-react';

export function Navbar() {
  const [isMenuOpen, setIsMenuOpen] = useState(false);

  return (
    <nav className="fixed top-0 left-0 right-0 z-50 bg-white/80 backdrop-blur-lg dark:bg-gray-950/80">
      <div className="container mx-auto px-4">
        <div className="flex items-center justify-between h-16">
          <Link href="/" className="flex items-center space-x-2">
            <Image
              src="/images/main.jpg"
              alt="AquaEcho Logo"
              width={40}
              height={40}
              className="rounded-full"
            />
            <span className="text-2xl font-display font-bold text-primary-600">AquaEcho</span>
          </Link>

          {/* Desktop Navigation */}
          <div className="hidden md:flex items-center space-x-8">
            <NavLink href="#features" icon={<Sparkles size={18} />}>Features</NavLink>
            <NavLink href="#about" icon={<Info size={18} />}>About</NavLink>
            <NavLink href="#contact" icon={<Phone size={18} />}>Contact</NavLink>
            <NavLink href="/privacy" icon={<Shield size={18} />}>Privacy</NavLink>
            <NavLink href="/terms" icon={<FileText size={18} />}>Terms</NavLink>
          </div>

          {/* Mobile Menu Button */}
          <button
            className="md:hidden"
            onClick={() => setIsMenuOpen(!isMenuOpen)}
            aria-label="Toggle menu"
          >
            {isMenuOpen ? <X size={24} /> : <Menu size={24} />}
          </button>
        </div>

        {/* Mobile Navigation */}
        {isMenuOpen && (
          <div className="md:hidden py-4">
            <div className="flex flex-col space-y-4">
              <MobileNavLink href="#features" icon={<Sparkles size={18} />} onClick={() => setIsMenuOpen(false)}>
                Features
              </MobileNavLink>
              <MobileNavLink href="#about" icon={<Info size={18} />} onClick={() => setIsMenuOpen(false)}>
                About
              </MobileNavLink>
              <MobileNavLink href="#contact" icon={<Phone size={18} />} onClick={() => setIsMenuOpen(false)}>
                Contact
              </MobileNavLink>
              <MobileNavLink href="/privacy" icon={<Shield size={18} />} onClick={() => setIsMenuOpen(false)}>
                Privacy
              </MobileNavLink>
              <MobileNavLink href="/terms" icon={<FileText size={18} />} onClick={() => setIsMenuOpen(false)}>
                Terms
              </MobileNavLink>
            </div>
          </div>
        )}
      </div>
    </nav>
  );
}

function NavLink({ href, icon, children }: { href: string; icon: React.ReactNode; children: React.ReactNode }) {
  return (
    <Link
      href={href}
      className="flex items-center space-x-2 text-gray-600 hover:text-primary-600 dark:text-gray-300 dark:hover:text-primary-400 transition-colors"
    >
      {icon}
      <span>{children}</span>
    </Link>
  );
}

function MobileNavLink({
  href,
  icon,
  onClick,
  children,
}: {
  href: string;
  icon: React.ReactNode;
  onClick: () => void;
  children: React.ReactNode;
}) {
  return (
    <Link
      href={href}
      onClick={onClick}
      className="flex items-center space-x-2 text-gray-600 hover:text-primary-600 dark:text-gray-300 dark:hover:text-primary-400 transition-colors"
    >
      {icon}
      <span>{children}</span>
    </Link>
  );
}