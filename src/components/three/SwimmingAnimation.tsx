import { useRef } from 'react';
import { useFrame } from '@react-three/fiber';
import { Float } from '@react-three/drei';
import * as THREE from 'three';

export function SwimmingAnimation() {
  const swimmerRef = useRef<THREE.Group>();
  const waterRef = useRef<THREE.Mesh>();
  const waterMaterial = useRef<THREE.ShaderMaterial>();

  // Custom shader for water animation
  const waterShader = {
    uniforms: {
      time: { value: 0 },
      color: { value: new THREE.Color("#0EA5E9") },
      opacity: { value: 0.8 }
    },
    vertexShader: `
      uniform float time;
      varying vec2 vUv;
      
      void main() {
        vUv = uv;
        vec3 pos = position;
        pos.y += sin(pos.x * 2.0 + time) * 0.2;
        pos.y += sin(pos.z * 2.0 + time) * 0.2;
        gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
      }
    `,
    fragmentShader: `
      uniform vec3 color;
      uniform float opacity;
      varying vec2 vUv;
      
      void main() {
        gl_FragColor = vec4(color, opacity);
      }
    `
  };

  useFrame((state) => {
    if (swimmerRef.current) {
      swimmerRef.current.position.y = Math.sin(state.clock.getElapsedTime()) * 0.2;
      swimmerRef.current.rotation.z = Math.sin(state.clock.getElapsedTime() * 0.5) * 0.1;
    }
    
    if (waterMaterial.current) {
      waterMaterial.current.uniforms.time.value = state.clock.getElapsedTime();
    }
  });

  return (
    <>
      <ambientLight intensity={0.5} />
      <directionalLight position={[5, 5, 5]} intensity={1} />
      <Float
        speed={2}
        rotationIntensity={0.5}
        floatIntensity={0.5}
      >
        <group ref={swimmerRef}>
          {/* Swimmer body */}
          <mesh position={[0, 0, 0]}>
            <capsuleGeometry args={[0.3, 1, 4, 16]} />
            <meshStandardMaterial color="#60A5FA" />
          </mesh>
          
          {/* Head */}
          <mesh position={[0.6, 0.2, 0]}>
            <sphereGeometry args={[0.2, 32, 32]} />
            <meshStandardMaterial color="#60A5FA" />
          </mesh>
          
          {/* Arms */}
          <group position={[0, 0.2, 0]}>
            <mesh position={[0, 0, 0.4]}>
              <capsuleGeometry args={[0.1, 0.6, 4, 8]} />
              <meshStandardMaterial color="#60A5FA" />
            </mesh>
            <mesh position={[0, 0, -0.4]}>
              <capsuleGeometry args={[0.1, 0.6, 4, 8]} />
              <meshStandardMaterial color="#60A5FA" />
            </mesh>
          </group>
        </group>
      </Float>

      {/* Animated water surface */}
      <mesh 
        ref={waterRef} 
        rotation={[-Math.PI / 2, 0, 0]} 
        position={[0, -1, 0]}
      >
        <planeGeometry args={[10, 10, 32, 32]} />
        <shaderMaterial
          ref={waterMaterial}
          {...waterShader}
          transparent
        />
      </mesh>
    </>
  );
}