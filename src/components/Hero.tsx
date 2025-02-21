import { Canvas } from '@react-three/fiber';
import { motion } from 'framer-motion';
import { WaterScene } from './three/WaterScene';

export function Hero() {
  return (
    <section className="relative h-screen flex items-center justify-center">
      <Canvas
        className="absolute inset-0"
        camera={{ position: [0, 0, 5], fov: 75 }}
      >
        <WaterScene />
      </Canvas>
      
      <div className="relative z-10 container mx-auto px-4">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8 }}
          className="max-w-4xl mx-auto text-center"
        >
          <h1 className="text-5xl md:text-7xl font-display font-bold text-white mb-6 drop-shadow-lg">
            Smart Swimming Assistant
          </h1>
          
          <p className="text-xl md:text-2xl text-white/90 mb-8 drop-shadow">
            Real-time guidance and tracking for visually impaired and competitive swimmers
          </p>
          
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.8, delay: 0.2 }}
          >
            <a
              href="#features"
              className="inline-flex items-center px-8 py-4 bg-white/10 backdrop-blur-lg border border-white/20 rounded-full text-white hover:bg-white/20 transition-colors"
            >
              <span className="text-lg font-semibold">Discover More</span>
              <svg className="w-6 h-6 ml-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
              </svg>
            </a>
          </motion.div>
        </motion.div>
      </div>
    </section>
  );
}