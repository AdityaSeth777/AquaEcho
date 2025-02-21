import { motion } from 'framer-motion';
import { Canvas } from '@react-three/fiber';
import { SwimmingAnimation } from './three/SwimmingAnimation';

export function About() {
  return (
    <section id="about" className="relative py-20 bg-gradient-to-b from-primary-950 to-primary-900">
      <div className="container mx-auto px-4">
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
          <motion.div
            initial={{ opacity: 0, x: -20 }}
            whileInView={{ opacity: 1, x: 0 }}
            viewport={{ once: true }}
            transition={{ duration: 0.8 }}
          >
            <h2 className="text-4xl md:text-5xl font-display font-bold text-white mb-6">
              Revolutionizing Swimming Assistance
            </h2>
            
            <p className="text-xl text-white/80 mb-8">
              AquaEcho combines cutting-edge technology with accessibility to create
              an unparalleled swimming experience for athletes of all abilities.
            </p>
            
            <ul className="space-y-4">
              {benefits.map((benefit, index) => (
                <motion.li
                  key={benefit}
                  initial={{ opacity: 0, x: -20 }}
                  whileInView={{ opacity: 1, x: 0 }}
                  viewport={{ once: true }}
                  transition={{ duration: 0.8, delay: index * 0.2 }}
                  className="flex items-center text-white/80"
                >
                  <span className="w-2 h-2 bg-primary-400 rounded-full mr-4" />
                  {benefit}
                </motion.li>
              ))}
            </ul>
          </motion.div>
          
          <motion.div
            initial={{ opacity: 0, scale: 0.9 }}
            whileInView={{ opacity: 1, scale: 1 }}
            viewport={{ once: true }}
            transition={{ duration: 0.8 }}
            className="h-[600px] relative"
          >
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