'use client';


import { motion } from 'framer-motion';

export default function PrivacyPolicy() {
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
            Privacy Policy
          </h1>

          <div className="space-y-8">
            <Section title="Information We Collect">
              <p>We collect the following types of information:</p>
              <ul className="list-disc list-inside ml-4 mt-2 space-y-2">
                <li>Swimming metrics and performance data</li>
                <li>Device motion and sensor data</li>
                <li>Health and fitness information</li>
                <li>User profile information</li>
              </ul>
            </Section>

            <Section title="How We Use Your Information">
              <p>Your information is used to:</p>
              <ul className="list-disc list-inside ml-4 mt-2 space-y-2">
                <li>Provide real-time swimming guidance</li>
                <li>Track your progress and performance</li>
                <li>Generate personalized insights</li>
                <li>Improve our services</li>
              </ul>
            </Section>

            <Section title="Data Security">
              <p>
                We implement industry-standard security measures to protect your data:
              </p>
              <ul className="list-disc list-inside ml-4 mt-2 space-y-2">
                <li>End-to-end encryption</li>
                <li>Secure data storage</li>
                <li>Regular security audits</li>
                <li>Access controls and authentication</li>
              </ul>
            </Section>

            <Section title="Data Sharing">
              <p>
                We never share your personal information with third parties without
                your explicit consent, except when required by law.
              </p>
            </Section>

            <Section title="Your Rights">
              <p>You have the right to:</p>
              <ul className="list-disc list-inside ml-4 mt-2 space-y-2">
                <li>Access your personal data</li>
                <li>Request data correction</li>
                <li>Delete your account</li>
                <li>Export your data</li>
              </ul>
            </Section>

            <Section title="Contact Us">
              <p>
                If you have any questions about our privacy policy, please contact us at:
                <br />
                <a
                  href="mailto:privacy@aquaecho.com"
                  className="text-primary-600 dark:text-primary-400 hover:underline"
                >
                  privacy@aquaecho.com
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