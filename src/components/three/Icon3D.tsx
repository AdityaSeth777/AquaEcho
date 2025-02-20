import { useRef } from 'react';
import { useFrame } from '@react-three/fiber';
import { Text3D } from '@react-three/drei';
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
        <Text3D
          font="/fonts/inter.json"
          size={1}
          height={0.2}
          curveSegments={12}
        >
          {icon}
          <meshStandardMaterial color="#60A5FA" />
        </Text3D>
      </mesh>
    </>
  );
}