import { motion } from 'framer-motion';
import { FeatureCard } from './FeatureCard';

const features = [
  {
    title: 'Lane Guidance',
    description: 'Real-time audio feedback keeps you centered in your lane with precision accuracy',
    icon: 'navigation',
    color: '#60A5FA'
  },
  {
    title: 'Performance Tracking',
    description: 'Monitor your progress with detailed analytics and comprehensive insights',
    icon: 'chart',
    color: '#34D399'
  },
  {
    title: 'Accessibility',
    description: 'Designed for swimmers of all abilities with intuitive haptic and audio feedback',
    icon: 'accessibility',
    color: '#F472B6'
  },
  {
    title: 'Smart Analytics',
    description: 'Advanced metrics and AI-powered performance analysis for continuous improvement',
    icon: 'graph',
    color: '#A78BFA'
  },
];

export function Features() {
  return (
    <section id="features" className="relative py-20 bg-gradient-to-b from-primary-900 to-primary-950">
      <div className="container mx-auto px-4">
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