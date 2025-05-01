'use client';

import { motion, useScroll, useTransform } from 'framer-motion';
import { useRef } from 'react';
import { Canvas } from '@react-three/fiber';
import { SwimmingAnimation } from './three/SwimmingAnimation';

export function About() {
  const containerRef = useRef<HTMLDivElement>(null);
  const { scrollYProgress } = useScroll({
    target: containerRef,
    offset: ["start end", "end start"]
  });

  const y = useTransform(scrollYProgress, [0, 1], [100, -100]);
  const opacity = useTransform(scrollYProgress, [0, 0.2, 0.8, 1], [0, 1, 1, 0]);
  const scale = useTransform(scrollYProgress, [0, 0.2, 0.8, 1], [0.8, 1, 1, 0.8]);

  return (
    <section id="about" ref={containerRef} className="relative py-32 bg-gradient-to-b from-primary-950 to-primary-900 overflow-hidden">
      <div className="absolute inset-0 bg-[radial-gradient(circle_at_top_right,_var(--tw-gradient-stops))] from-primary-900/50 via-primary-950 to-primary-950" />
      
      <div className="container relative mx-auto px-4">
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-16 items-center">
          <motion.div
            style={{ y, opacity, scale }}
            className="relative z-10"
          >
            <motion.h2 
              className="text-5xl md:text-6xl font-display font-bold text-white mb-8 leading-tight"
              initial={{ opacity: 0, x: -50 }}
              whileInView={{ opacity: 1, x: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.8 }}
            >
              Revolutionizing
              <span className="block text-transparent bg-clip-text bg-gradient-to-r from-blue-400 to-cyan-400">
                Swimming Assistance
              </span>
            </motion.h2>
            
            <motion.p 
              className="text-xl text-white/80 mb-12"
              initial={{ opacity: 0, x: -50 }}
              whileInView={{ opacity: 1, x: 0 }}
              viewport={{ once: true }}
              transition={{ duration: 0.8, delay: 0.2 }}
            >
              AquaEcho combines cutting-edge technology with accessibility to create
              an unparalleled swimming experience for athletes of all abilities.
            </motion.p>
            
            <div className="space-y-6">
              {benefits.map((benefit, index) => (
                <motion.div
                  key={benefit}
                  initial={{ opacity: 0, x: -50 }}
                  whileInView={{ opacity: 1, x: 0 }}
                  viewport={{ once: true }}
                  transition={{ duration: 0.8, delay: 0.2 + index * 0.1 }}
                  className="flex items-center gap-4 group"
                >
                  <span className="w-2 h-2 rounded-full bg-gradient-to-r from-blue-400 to-cyan-400 group-hover:w-4 transition-all duration-300" />
                  <span className="text-white/80 group-hover:text-white transition-colors duration-300">
                    {benefit}
                  </span>
                </motion.div>
              ))}
            </div>
          </motion.div>
          
          <motion.div
            style={{ scale }}
            className="h-[600px] relative"
          >
            <div className="absolute inset-0 bg-gradient-to-r from-blue-500/20 to-cyan-500/20 rounded-3xl blur-3xl" />
            <Canvas camera={{ position: [0, 2, 5], fov: 75 }}>
              <SwimmingAnimation />
            </Canvas>
          </motion.div>
        </div>
      </div>
    </section>
  );
}

const benefits = [
  'Real-time audio and haptic feedback',
  'Advanced motion tracking technology',
  'Comprehensive performance analytics',
  'Seamless HealthKit integration',
  'Personalized training insights',
];