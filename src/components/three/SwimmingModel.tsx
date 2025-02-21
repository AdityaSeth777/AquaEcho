'use client';

import { useRef } from 'react';
import { useFrame } from '@react-three/fiber';
import { Box, Sphere } from '@react-three/drei';
import * as THREE from 'three';

export function SwimmingModel() {
  const group = useRef<THREE.Group>();

  useFrame((state) => {
    if (group.current) {
      group.current.rotation.y = Math.sin(state.clock.getElapsedTime() * 0.5) * 0.3;
      group.current.position.y = Math.sin(state.clock.getElapsedTime()) * 0.2;
    }
  });

  return (
    <group ref={group}>
      <ambientLight intensity={0.5} />
      <directionalLight position={[2, 2, 5]} intensity={1} />
      
      {/* Body */}
      <Box args={[1, 0.4, 0.3]} position={[0, 0, 0]}>
        <meshStandardMaterial color="#60A5FA" />
      </Box>
      
      {/* Head */}
      <Sphere args={[0.2]} position={[0.5, 0.2, 0]}>
        <meshStandardMaterial color="#60A5FA" />
      </Sphere>
      
      {/* Arms */}
      <Box args={[0.4, 0.1, 0.1]} position={[0, 0.2, 0.3]}>
        <meshStandardMaterial color="#60A5FA" />
      </Box>
      <Box args={[0.4, 0.1, 0.1]} position={[0, 0.2, -0.3]}>
        <meshStandardMaterial color="#60A5FA" />
      </Box>
      
      {/* Legs */}
      <Box args={[0.5, 0.1, 0.1]} position={[-0.4, 0, 0.15]}>
        <meshStandardMaterial color="#60A5FA" />
      </Box>
      <Box args={[0.5, 0.1, 0.1]} position={[-0.4, 0, -0.15]}>
        <meshStandardMaterial color="#60A5FA" />
      </Box>
    </group>
  );
}