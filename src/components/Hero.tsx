import { Canvas } from '@react-three/fiber';
import { motion } from 'framer-motion';
import { WaterScene } from './three/WaterScene';

export function Hero() {
  return (
    <div className="relative h-screen">
      <Canvas
        className="absolute inset-0"
        camera={{ position: [0, 0, 5], fov: 75 }}
      >
        <WaterScene />
      </Canvas>
      
      <div className="relative z-10 flex items-center justify-center h-full">
        <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <motion.h1
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.8 }}
            className="text-5xl md:text-7xl font-display font-bold text-white mb-6"
          >
            Smart Swimming Assistant
          </motion.h1>
          
          <motion.p
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.8, delay: 0.2 }}
            className="text-xl md:text-2xl text-white/90 mb-8"
          >
            Real-time guidance and tracking for visually impaired and competitive swimmers
          </motion.p>
          
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.8, delay: 0.4 }}
          >
            <a
              href="#features"
              className="inline-flex items-center px-8 py-3 border border-transparent text-base font-medium rounded-full text-white bg-primary-600 hover:bg-primary-700 transition-colors"
            >
              Discover More
            </a>
          </motion.div>
        </div>
      </div>
    </div>
  );
}