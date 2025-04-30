import { motion } from 'framer-motion';
import { DivideIcon as LucideIcon } from 'lucide-react';

interface FeatureCardProps {
  feature: {
    title: string;
    description: string;
    icon: typeof LucideIcon;
    gradient: string[];
  };
  index: number;
}

export function FeatureCard({ feature, index }: FeatureCardProps) {
  const Icon = feature.icon;
  
  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true }}
      transition={{ duration: 0.8, delay: index * 0.2 }}
      whileHover={{ scale: 1.05 }}
      className="group relative bg-white/5 backdrop-blur-xl rounded-2xl p-8 hover:bg-white/10 transition-all duration-500 overflow-hidden"
    >
      {/* Surprise Gradient Border on Hover */}
      <div
        className="absolute inset-[1px] rounded-2xl opacity-0 group-hover:opacity-100 transition-opacity duration-500"
        style={{
          background: `linear-gradient(135deg, ${feature.gradient[0]}, ${feature.gradient[1]})`,
          filter: 'blur(8px)',
          zIndex: -1
        }}
      />
      
      {/* Icon Container */}
      <div className="relative mb-6 group-hover:scale-110 transition-transform duration-500">
        <motion.div
          initial={{ rotate: 0 }}
          whileHover={{ rotate: 360 }}
          transition={{ duration: 0.8, type: "spring" }}
          className="w-16 h-16 rounded-xl bg-white/10 flex items-center justify-center"
        >
          <Icon 
            size={32}
            className="text-white transition-colors duration-500"
          />
        </motion.div>
      </div>
      
      <h3 className="text-2xl font-display font-bold text-white mb-4">
        {feature.title}
      </h3>
      
      <p className="text-white/80 group-hover:text-white/90 transition-colors duration-500">
        {feature.description}
      </p>
      
      {/* Hover Effect Corner */}
      <div className="absolute -bottom-1 -right-1 w-16 h-16 bg-gradient-to-br opacity-0 group-hover:opacity-100 transition-opacity duration-500 transform rotate-45"
           style={{
             background: `linear-gradient(135deg, ${feature.gradient[0]}, ${feature.gradient[1]})`
           }} />
    </motion.div>
  );
}