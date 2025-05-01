'use client';

import { Canvas } from '@react-three/fiber';
import { motion } from 'framer-motion';
import { WaterScene } from './three/WaterScene';

export function Hero() {
  return (
    <motion.section 
      className="relative h-screen overflow-hidden"
      initial={{ opacity: 1 }}
      exit={{ opacity: 0 }}
      transition={{ duration: 1 }}
    >
      <Canvas
        className="absolute inset-0"
        camera={{ position: [0, 0, 5], fov: 75 }}
      >
        <WaterScene />
      </Canvas>
      
      <motion.div 
        initial={{ opacity: 0, y: 50 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 1 }}
        className="absolute top-[20%] left-0 right-0 z-10"
      >
        <div className="container mx-auto px-4">
          <motion.h1 
            className="group text-8xl md:text-[12rem] font-display font-black text-center leading-none"
            whileHover={{ scale: 1.05 }}
          >
            <span className="relative block overflow-hidden p-2">
              <motion.span
                className="block text-blue-900 dark:text-white/90 cursor-pointer hover:text-blue-700 dark:hover:text-blue-300 transition-colors duration-500"
                whileHover={{ y: -10 }}
                transition={{ type: "spring", stiffness: 300 }}
              >
                Aqua
              </motion.span>
            </span>
            <span className="relative block overflow-hidden p-2">
              <motion.span
                className="block bg-gradient-to-r from-blue-400 to-cyan-300 text-transparent bg-clip-text cursor-pointer"
                whileHover={{ y: -10 }}
                transition={{ type: "spring", stiffness: 300 }}
              >
                Echo
              </motion.span>
            </span>
          </motion.h1>
          
          <motion.p 
            className="text-2xl md:text-3xl text-center text-white/80 mt-8 max-w-3xl mx-auto font-light"
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 0.5, duration: 0.8 }}
          >
            Real-time guidance and tracking for visually impaired and competitive swimmers
          </motion.p>
        </div>
      </motion.div>
    </motion.section>
  );
}