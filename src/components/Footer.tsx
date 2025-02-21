import { Sparkles, Info, Phone, Shield, FileText, Twitter, Github, Mail, Home } from 'lucide-react';

export function Footer() {
  return (
    <footer className="bg-gray-50 dark:bg-gray-900">
      <div className="container mx-auto px-4 py-12">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-8">
          <div>
            <h3 className="text-lg font-semibold mb-4 flex items-center space-x-2">
              <Home className="w-5 h-5" />
              <span>AquaEcho</span>
            </h3>
            <p className="text-gray-600 dark:text-gray-400">
              Smart swimming assistance for athletes of all abilities.
            </p>
          </div>

          <div>
            <h4 className="text-sm font-semibold uppercase mb-4">Product</h4>
            <ul className="space-y-2">
              <FooterLink href="#features" icon={<Sparkles size={16} />}>Features</FooterLink>
              <FooterLink href="#about" icon={<Info size={16} />}>About</FooterLink>
              <FooterLink href="#contact" icon={<Phone size={16} />}>Contact</FooterLink>
            </ul>
          </div>

          <div>
            <h4 className="text-sm font-semibold uppercase mb-4">Legal</h4>
            <ul className="space-y-2">
              <FooterLink href="/privacy" icon={<Shield size={16} />}>Privacy Policy</FooterLink>
              <FooterLink href="/terms" icon={<FileText size={16} />}>Terms of Service</FooterLink>
            </ul>
          </div>

          <div>
            <h4 className="text-sm font-semibold uppercase mb-4">Connect</h4>
            <ul className="space-y-2">
              <FooterLink href="https://twitter.com/aquaecho" icon={<Twitter size={16} />}>Twitter</FooterLink>
              <FooterLink href="https://github.com/aquaecho" icon={<Github size={16} />}>GitHub</FooterLink>
              <FooterLink href="mailto:contact@aquaecho.com" icon={<Mail size={16} />}>Email</FooterLink>
            </ul>
          </div>
        </div>

        <div className="border-t border-gray-200 dark:border-gray-800 mt-12 pt-8 text-center text-gray-600 dark:text-gray-400">
          <p>&copy; {new Date().getFullYear()} AquaEcho. All rights reserved.</p>
        </div>
      </div>
    </footer>
  );
}

function FooterLink({ href, icon, children }: { href: string; icon: React.ReactNode; children: React.ReactNode }) {
  return (
    <li>
      <a
        href={href}
        className="flex items-center space-x-2 text-gray-600 hover:text-primary-600 dark:text-gray-400 dark:hover:text-primary-400 transition-colors"
      >
        {icon}
        <span>{children}</span>
      </a>
    </li>
  );
}