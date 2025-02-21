import { useRef, useMemo } from 'react';
import { useFrame } from '@react-three/fiber';
import { Float, Text3D, OrbitControls, MeshTransmissionMaterial } from '@react-three/drei';
import * as THREE from 'three';

export function SwimmingAnimation() {
  const pathRef = useRef<THREE.Line>();
  const trackerRef = useRef<THREE.Mesh>();
  const gridRef = useRef<THREE.GridHelper>();
  
  // Create a swimming lane path
  const curve = useMemo(() => {
    return new THREE.CatmullRomCurve3([
      new THREE.Vector3(-3, 0, 0),
      new THREE.Vector3(-2, 0, 0.2),
      new THREE.Vector3(-1, 0, -0.1),
      new THREE.Vector3(0, 0, 0.1),
      new THREE.Vector3(1, 0, -0.2),
      new THREE.Vector3(2, 0, 0.1),
      new THREE.Vector3(3, 0, 0),
    ]);
  }, []);

  // Create points for the path visualization
  const points = useMemo(() => curve.getPoints(50), [curve]);
  
  // Create lane boundaries
  const laneWidth = 2;
  const leftBoundary = points.map(p => new THREE.Vector3(p.x, p.y, p.z - laneWidth/2));
  const rightBoundary = points.map(p => new THREE.Vector3(p.x, p.y, p.z + laneWidth/2));

  useFrame((state) => {
    const time = state.clock.getElapsedTime();
    
    // Animate tracker along the path
    if (trackerRef.current) {
      const position = curve.getPointAt(Math.abs(Math.sin(time * 0.2)));
      trackerRef.current.position.copy(position);
      
      // Calculate and set tracker rotation to follow path direction
      const tangent = curve.getTangentAt(Math.abs(Math.sin(time * 0.2)));
      const lookAt = new THREE.Vector3().copy(position).add(tangent);
      trackerRef.current.lookAt(lookAt);
    }

    // Animate grid
    if (gridRef.current) {
      gridRef.current.position.y = Math.sin(time * 0.5) * 0.1;
    }
  });

  return (
    <>
      <OrbitControls enableZoom={false} enablePan={false} />
      <ambientLight intensity={0.5} />
      <directionalLight position={[5, 5, 5]} intensity={1} />
      
      {/* Swimming Lane Grid */}
      <gridHelper
        ref={gridRef}
        args={[10, 20, '#304050', '#304050']}
        position={[0, -1, 0]}
      />

      {/* Lane Boundaries */}
      <line>
        <bufferGeometry
          attach="geometry"
          attributes={{
            position: new THREE.Float32BufferAttribute(
              leftBoundary.flatMap(v => [v.x, v.y, v.z]),
              3
            )
          }}
        />
        <lineBasicMaterial attach="material" color="#60A5FA" linewidth={2} />
      </line>
      
      <line>
        <bufferGeometry
          attach="geometry"
          attributes={{
            position: new THREE.Float32BufferAttribute(
              rightBoundary.flatMap(v => [v.x, v.y, v.z]),
              3
            )
          }}
        />
        <lineBasicMaterial attach="material" color="#60A5FA" linewidth={2} />
      </line>

      {/* Swimmer Position Tracker */}
      <mesh ref={trackerRef} position={[0, 0, 0]}>
        <sphereGeometry args={[0.2, 32, 32]} />
        <MeshTransmissionMaterial
          backside
          samples={4}
          thickness={0.5}
          roughness={0}
          metalness={0}
          transmission={1}
          distortion={0.5}
          distortionScale={0.5}
          temporalDistortion={0.1}
          color="#60A5FA"
        />
      </mesh>

      {/* Motion Tracking Visualization */}
      <Float speed={2} rotationIntensity={0.5} floatIntensity={0.5}>
        <group position={[0, 1, 0]}>
          {/* Tracking Rings */}
          {[0, 1, 2].map((ring) => (
            <mesh key={ring} rotation-x={Math.PI * 0.5}>
              <torusGeometry args={[0.3 + ring * 0.2, 0.02, 16, 32]} />
              <meshStandardMaterial
                color="#60A5FA"
                transparent
                opacity={0.3 - ring * 0.1}
              />
            </mesh>
          ))}
        </group>
      </Float>

      {/* Data Points */}
      {points.filter((_, i) => i % 5 === 0).map((point, i) => (
        <mesh key={i} position={[point.x, point.y + 0.1, point.z]}>
          <sphereGeometry args={[0.05, 16, 16]} />
          <meshStandardMaterial
            color="#34D399"
            emissive="#34D399"
            emissiveIntensity={0.5}
          />
        </mesh>
      ))}
    </>
  );
}