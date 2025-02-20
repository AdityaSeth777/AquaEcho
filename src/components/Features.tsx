'use client';

import { motion } from 'framer-motion';
import { Canvas } from '@react-three/fiber';
import { Suspense } from 'react';
import { FeatureCard } from './FeatureCard';
import { ParticleField } from './three/ParticleField';

const features = [
  {
    title: 'Lane Guidance',
    description: 'Real-time audio feedback keeps you centered in your lane',
    icon: 'navigation',
  },
  {
    title: 'Performance Tracking',
    description: 'Monitor your progress with detailed analytics and insights',
    icon: 'chart',
  },
  {
    title: 'Accessibility',
    description: 'Designed for swimmers of all abilities with intuitive feedback',
    icon: 'accessibility',
  },
  {
    title: 'Smart Analytics',
    description: 'Advanced metrics and performance analysis for improvement',
    icon: 'graph',
  },
];

export function Features() {
  return (
    <section id="features" className="relative min-h-screen py-20 overflow-hidden">
      <div className="absolute inset-0">
        <Suspense fallback={null}>
          <Canvas camera={{ position: [0, 0, 5], fov: 75 }}>
            <ParticleField />
          </Canvas>
        </Suspense>
      </div>

      <div className="relative z-10 container mx-auto px-4">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.8 }}
          className="text-center mb-16"
        >
          <h2 className="text-4xl md:text-5xl font-display font-bold text-white mb-6">
            Cutting-Edge Features
          </h2>
          <p className="text-xl text-white/80 max-w-2xl mx-auto">
            Experience swimming like never before with our advanced technology
          </p>
        </motion.div>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-8 max-w-6xl mx-auto">
          {features.map((feature, index) => (
            <FeatureCard
              key={feature.title}
              feature={feature}
              index={index}
            />
          ))}
        </div>
      </div>
    </section>
  );
}