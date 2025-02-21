import { motion } from 'framer-motion';
import { FeatureCard } from './FeatureCard';
import { Navigation, LineChart, Accessibility, BarChart } from 'lucide-react';

const features = [
  {
    title: 'Lane Guidance',
    description: 'Real-time audio feedback keeps you centered in your lane with precision accuracy',
    icon: Navigation,
    gradient: ['#3B82F6', '#60A5FA']
  },
  {
    title: 'Performance Tracking',
    description: 'Monitor your progress with detailed analytics and comprehensive insights',
    icon: LineChart,
    gradient: ['#059669', '#34D399']
  },
  {
    title: 'Accessibility',
    description: 'Designed for swimmers of all abilities with intuitive haptic and audio feedback',
    icon: Accessibility,
    gradient: ['#DB2777', '#F472B6']
  },
  {
    title: 'Smart Analytics',
    description: 'Advanced metrics and AI-powered performance analysis for continuous improvement',
    icon: BarChart,
    gradient: ['#7C3AED', '#A78BFA']
  },
];

export function Features() {
  return (
    <section id="features" className="relative py-32 bg-gradient-to-b from-primary-900 to-primary-950">
      <div className="absolute inset-0 bg-grid-white/5 bg-[size:3rem_3rem] [mask-image:radial-gradient(white,transparent_70%)]" />
      
      <div className="container relative mx-auto px-4">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          whileInView={{ opacity: 1, y: 0 }}
          viewport={{ once: true }}
          transition={{ duration: 0.8 }}
          className="text-center mb-20"
        >
          <h2 className="text-4xl md:text-6xl font-display font-bold text-white mb-6 tracking-tight">
            Cutting-Edge Features
          </h2>
          <p className="text-xl text-white/80 max-w-2xl mx-auto">
            Experience swimming like never before with our advanced technology
          </p>
        </motion.div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
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