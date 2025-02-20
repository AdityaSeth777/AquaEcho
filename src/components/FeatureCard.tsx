'use client';

import { motion } from 'framer-motion';
import { Canvas } from '@react-three/fiber';
import { Icon3D } from './three/Icon3D';

interface FeatureCardProps {
  feature: {
    title: string;
    description: string;
    icon: string;
  };
  index: number;
}

export function FeatureCard({ feature, index }: FeatureCardProps) {
  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true }}
      transition={{ duration: 0.8, delay: index * 0.2 }}
      className="bg-white/10 backdrop-blur-lg rounded-2xl p-6 hover:bg-white/20 transition-colors"
    >
      <div className="h-24 relative mb-6">
        <Canvas camera={{ position: [0, 0, 5], fov: 75 }}>
          <Icon3D icon={feature.icon} />
        </Canvas>
      </div>
      
      <h3 className="text-2xl font-display font-bold text-white mb-4">
        {feature.title}
      </h3>
      
      <p className="text-white/80">
        {feature.description}
      </p>
    </motion.div>
  );
}