export function Footer() {
    return (
      <footer className="bg-gray-50 dark:bg-gray-900">
        <div className="container mx-auto px-4 py-12">
          <div className="grid grid-cols-1 md:grid-cols-4 gap-8">
            <div>
              <h3 className="text-lg font-semibold mb-4">AquaEcho</h3>
              <p className="text-gray-600 dark:text-gray-400">
                Smart swimming assistance for athletes of all abilities.
              </p>
            </div>
  
            <div>
              <h4 className="text-sm font-semibold uppercase mb-4">Product</h4>
              <ul className="space-y-2">
                <FooterLink href="#features">Features</FooterLink>
                <FooterLink href="#about">About</FooterLink>
                <FooterLink href="#contact">Contact</FooterLink>
              </ul>
            </div>
  
            <div>
              <h4 className="text-sm font-semibold uppercase mb-4">Legal</h4>
              <ul className="space-y-2">
                <FooterLink href="/privacy">Privacy Policy</FooterLink>
                <FooterLink href="/terms">Terms of Service</FooterLink>
              </ul>
            </div>
  
            <div>
              <h4 className="text-sm font-semibold uppercase mb-4">Connect</h4>
              <ul className="space-y-2">
                <FooterLink href="https://twitter.com/aquaecho">Twitter</FooterLink>
                <FooterLink href="https://github.com/aquaecho">GitHub</FooterLink>
                <FooterLink href="mailto:contact@aquaecho.com">Email</FooterLink>
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
  
  function FooterLink({ href, children }: { href: string; children: React.ReactNode }) {
    return (
      <li>
        <a
          href={href}
          className="text-gray-600 hover:text-primary-600 dark:text-gray-400 dark:hover:text-primary-400 transition-colors"
        >
          {children}
        </a>
      </li>
    );
  }