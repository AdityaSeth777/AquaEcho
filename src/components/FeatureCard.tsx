import { motion } from 'framer-motion';
import { Canvas } from '@react-three/fiber';
import { Float, Center, Sphere, Box } from '@react-three/drei';

interface FeatureCardProps {
  feature: {
    title: string;
    description: string;
    icon: string;
    color: string;
  };
  index: number;
}

function Icon3D({ color }: { color: string }) {
  return (
    <Float
      speed={4}
      rotationIntensity={1}
      floatIntensity={2}
    >
      <Center>
        <group>
          <Box args={[0.8, 0.8, 0.8]} position={[0, 0, 0]}>
            <meshStandardMaterial color={color} />
          </Box>
          <Sphere args={[0.3, 16, 16]} position={[0.4, 0.4, 0]}>
            <meshStandardMaterial color={color} />
          </Sphere>
        </group>
      </Center>
    </Float>
  );
}

export function FeatureCard({ feature, index }: FeatureCardProps) {
  return (
    <motion.div
      initial={{ opacity: 0, y: 20 }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true }}
      transition={{ duration: 0.8, delay: index * 0.2 }}
      className="bg-white/10 backdrop-blur-lg rounded-2xl p-6 hover:bg-white/20 transition-all hover:transform hover:scale-105"
    >
      <div className="h-32 relative mb-6">
        <Canvas camera={{ position: [0, 0, 5], fov: 75 }}>
          <ambientLight intensity={0.5} />
          <pointLight position={[10, 10, 10]} />
          <Icon3D color={feature.color} />
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