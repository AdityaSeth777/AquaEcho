'use client';


import { motion } from 'framer-motion';

export default function TermsOfService() {
  return (
    <div className="min-h-screen pt-24 pb-12 bg-gray-50 dark:bg-gray-900">
      <div className="container mx-auto px-4">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8 }}
          className="max-w-4xl mx-auto bg-white dark:bg-gray-800 rounded-2xl shadow-xl p-8"
        >
          <h1 className="text-4xl font-display font-bold mb-8 text-primary-600 dark:text-primary-400">
            Terms of Service
          </h1>

          <div className="space-y-8">
            <Section title="1. Acceptance of Terms">
              <p>
                By accessing or using AquaEcho, you agree to be bound by these Terms
                of Service. If you disagree with any part of these terms, you may
                not access or use our service.
              </p>
            </Section>

            <Section title="2. Use License">
              <p>Permission is granted to temporarily use AquaEcho for personal,
                non-commercial use only. This is the grant of a license, not a
                transfer of title, and under this license you may not:</p>
              <ul className="list-disc list-inside ml-4 mt-2 space-y-2">
                <li>Modify or copy the materials</li>
                <li>Use the materials for any commercial purpose</li>
                <li>Attempt to decompile or reverse engineer any software</li>
                <li>Remove any copyright or proprietary notations</li>
              </ul>
            </Section>

            <Section title="3. Disclaimer">
              <p>
                AquaEcho is provided "as is". We make no warranties, expressed or
                implied, and hereby disclaim and negate all other warranties
                including, without limitation:
              </p>
              <ul className="list-disc list-inside ml-4 mt-2 space-y-2">
                <li>Merchantability</li>
                <li>Fitness for a particular purpose</li>
                <li>Non-infringement of intellectual property</li>
              </ul>
            </Section>

            <Section title="4. Limitations">
              <p>
                In no event shall AquaEcho or its suppliers be liable for any
                damages (including, without limitation, damages for loss of data or
                profit, or due to business interruption) arising out of the use or
                inability to use AquaEcho.
              </p>
            </Section>

            <Section title="5. User Responsibilities">
              <p>As a user of AquaEcho, you are responsible for:</p>
              <ul className="list-disc list-inside ml-4 mt-2 space-y-2">
                <li>Following pool safety guidelines</li>
                <li>Using the app as intended</li>
                <li>Maintaining the security of your account</li>
                <li>Any activity that occurs under your account</li>
              </ul>
            </Section>

            <Section title="6. Changes to Terms">
              <p>
                We reserve the right to modify these terms at any time. We will
                notify users of any changes by updating the date at the top of
                these terms.
              </p>
            </Section>

            <Section title="7. Contact Information">
              <p>
                Questions about the Terms of Service should be sent to us at:
                <br />
                <a
                  href="mailto:legal@aquaecho.com"
                  className="text-primary-600 dark:text-primary-400 hover:underline"
                >
                  legal@aquaecho.com
                </a>
              </p>
            </Section>
          </div>
        </motion.div>
      </div>
    </div>
  );
}

function Section({ title, children }: { title: string; children: React.ReactNode }) {
  return (
    <div>
      <h2 className="text-2xl font-display font-semibold mb-4 text-gray-900 dark:text-white">
        {title}
      </h2>
      <div className="text-gray-700 dark:text-gray-300 leading-relaxed">
        {children}
      </div>
    </div>
  );
}