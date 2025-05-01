'use client';

import { motion } from 'framer-motion';
import { useEffect, useState } from 'react';

export function Preloader() {
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    const timer = setTimeout(() => setIsLoading(false), 2000);
    return () => clearTimeout(timer);
  }, []);

  if (!isLoading) return null;

  return (
    <motion.div
      initial={{ opacity: 1 }}
      animate={{ opacity: 0 }}
      transition={{ duration: 0.5, delay: 1.5 }}
      onAnimationComplete={() => setIsLoading(false)}
      className="fixed inset-0 z-50 flex items-center justify-center bg-primary-950"
    >
      <div className="relative">
        <svg
          className="w-24 h-24"
          viewBox="0 0 100 100"
          xmlns="http://www.w3.org/2000/svg"
          suppressHydrationWarning
        >
          {/* Water Drop */}
          <motion.path
            d="M50 5 C50 5 20 50 20 70 C20 85 35 95 50 95 C65 95 80 85 80 70 C80 50 50 5 50 5"
            fill="none"
            stroke="#60A5FA"
            strokeWidth="4"
            initial={{ pathLength: 0 }}
            animate={{ pathLength: 1 }}
            transition={{ duration: 1.5, ease: "easeInOut" }}
          />
          
          {/* Ripples */}
          {[0, 1, 2].map((i) => (
            <motion.circle
              key={i}
              cx="50"
              cy="70"
              r={10 + i * 10}
              fill="none"
              stroke="#60A5FA"
              strokeWidth="2"
              initial={{ scale: 0, opacity: 0.8 }}
              animate={{ scale: 1.5, opacity: 0 }}
              transition={{
                duration: 1,
                delay: i * 0.2,
                repeat: Infinity,
                repeatDelay: 0.5
              }}
            />
          ))}
        </svg>
        
        <motion.div
          className="absolute -bottom-8 left-1/2 transform -translate-x-1/2 text-white font-display text-sm"
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ delay: 0.5 }}
        >
          Loading...
        </motion.div>
      </div>
    </motion.div>
  );
}