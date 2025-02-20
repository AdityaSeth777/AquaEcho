import { useRef } from 'react';
import { useFrame } from '@react-three/fiber';
import * as THREE from 'three';

export function WaveForm() {
  const mesh = useRef<THREE.Mesh>();
  const material = useRef<THREE.ShaderMaterial>();

  const uniforms = {
    uTime: { value: 0 },
    uColor: { value: new THREE.Color('#60A5FA') },
    uFrequency: { value: new THREE.Vector2(2, 3) },
  };

  useFrame((state) => {
    if (material.current) {
      material.current.uniforms.uTime.value = state.clock.getElapsedTime();
    }
  });

  return (
    <mesh ref={mesh} rotation={[-Math.PI / 2, 0, 0]}>
      <planeGeometry args={[15, 15, 128, 128]} />
      <shaderMaterial
        ref={material}
        vertexShader={vertexShader}
        fragmentShader={fragmentShader}
        uniforms={uniforms}
        transparent
      />
    </mesh>
  );
}

const vertexShader = `
  uniform float uTime;
  uniform vec2 uFrequency;

  varying vec2 vUv;
  varying float vElevation;

  void main() {
    vec4 modelPosition = modelMatrix * vec4(position, 1.0);

    float elevation = sin(modelPosition.x * uFrequency.x - uTime) *
                     sin(modelPosition.z * uFrequency.y - uTime) *
                     0.2;

    modelPosition.y += elevation;

    vec4 viewPosition = viewMatrix * modelPosition;
    vec4 projectedPosition = projectionMatrix * viewPosition;

    gl_Position = projectedPosition;

    vUv = uv;
    vElevation = elevation;
  }
`;

const fragmentShader = `
  uniform vec3 uColor;
  
  varying vec2 vUv;
  varying float vElevation;

  void main() {
    float alpha = (vElevation + 0.2) * 0.5;
    gl_FragColor = vec4(uColor, alpha);
  }
`;