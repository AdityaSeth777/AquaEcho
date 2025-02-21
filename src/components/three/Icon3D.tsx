'use client';

import { useRef } from 'react';
import { useFrame } from '@react-three/fiber';
import { Text } from '@react-three/drei';
import * as THREE from 'three';

interface Icon3DProps {
  icon: string;
}

export function Icon3D({ icon }: Icon3DProps) {
  const mesh = useRef<THREE.Mesh>();

  useFrame((state) => {
    if (mesh.current) {
      mesh.current.rotation.x = Math.sin(state.clock.getElapsedTime()) * 0.2;
      mesh.current.rotation.y = state.clock.getElapsedTime() * 0.5;
    }
  });

  return (
    <>
      <ambientLight intensity={0.5} />
      <directionalLight position={[2, 2, 5]} intensity={1} />
      <mesh ref={mesh}>
        <Text
          fontSize={1}
          maxWidth={200}
          lineHeight={1}
          letterSpacing={0.02}
          textAlign="center"
        >
          {icon}
          <meshStandardMaterial color="#60A5FA" />
        </Text>
      </mesh>
    </>
  );
}