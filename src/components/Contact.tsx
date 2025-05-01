import { useState } from 'react';
import { motion } from 'framer-motion';
import { Canvas } from '@react-three/fiber';
import { WaveForm } from './three/WaveForm';

export function Contact() {
  const [status, setStatus] = useState<'idle' | 'success' | 'error'>('idle');

  return (
    <section id="contact" className="relative min-h-screen py-20 bg-primary-950">
      <Canvas
        className="absolute inset-0"
        camera={{ position: [0, 0, 5], fov: 75 }}
      >
        <WaveForm />
      </Canvas>

      <div className="relative z-10 container mx-auto px-4">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.8 }}
          className="max-w-2xl mx-auto text-center mb-12"
        >
          <h2 className="text-4xl md:text-5xl font-display font-bold text-white mb-6">
            Get in Touch
          </h2>
          <p className="text-xl text-white/80">
            Have questions? We'd love to hear from you.
          </p>
        </motion.div>

        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.8, delay: 0.2 }}
          className="max-w-xl mx-auto bg-white/10 backdrop-blur-lg rounded-2xl p-8"
        >
          <form
            onSubmit={async (e) => {
              e.preventDefault();
              const form = e.currentTarget;
              const data = new FormData(form);

              try {
                const res = await fetch('https://formspree.io/f/xqaqevbj', {
                  method: 'POST',
                  body: data,
                  headers: {
                    Accept: 'application/json',
                  },
                });

                if (res.ok) {
                  setStatus('success');
                  form.reset();
                } else {
                  setStatus('error');
                }
              } catch {
                setStatus('error');
              }
            }}
            className="space-y-6"
          >
            <div>
              <label htmlFor="name" className="block text-white mb-2">
                Name
              </label>
              <input
                type="text"
                id="name"
                name="name"
                className="w-full px-4 py-3 bg-white/5 border border-white/10 rounded-lg text-white placeholder-white/50 focus:outline-none focus:border-primary-400"
                placeholder="Your name"
              />
            </div>

            <div>
              <label htmlFor="email" className="block text-white mb-2">
                Email
              </label>
              <input
                type="email"
                id="email"
                name="email"
                className="w-full px-4 py-3 bg-white/5 border border-white/10 rounded-lg text-white placeholder-white/50 focus:outline-none focus:border-primary-400"
                placeholder="your@email.com"
              />
            </div>

            <div>
              <label htmlFor="message" className="block text-white mb-2">
                Message
              </label>
              <textarea
                id="message"
                name="message"
                rows={4}
                className="w-full px-4 py-3 bg-white/5 border border-white/10 rounded-lg text-white placeholder-white/50 focus:outline-none focus:border-primary-400"
                placeholder="Your message"
              />
            </div>

            {status === 'success' && (
              <p className="text-green-400 font-medium">
                Thanks! Your message has been sent.
              </p>
            )}
            {status === 'error' && (
              <p className="text-red-400 font-medium">
                Oops! Something went wrong. Please try again.
              </p>
            )}

            <button
              type="submit"
              className="w-full px-8 py-4 bg-primary-600 hover:bg-primary-700 text-white font-semibold rounded-lg transition-colors"
            >
              Send Message
            </button>
          </form>
        </motion.div>
      </div>
    </section>
  );
}
