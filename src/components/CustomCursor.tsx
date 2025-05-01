'use client';

import { motion } from 'framer-motion';
import { useEffect, useState } from 'react';
import { useTheme } from 'next-themes'; // Import useTheme
import resolveConfig from 'tailwindcss/resolveConfig';
import tailwindConfig from '../../tailwind.config.js'; // Adjust path if necessary

const fullConfig = resolveConfig(tailwindConfig);

export function CustomCursor() {
  const [position, setPosition] = useState({ x: 0, y: 0 });
  const [isPointer, setIsPointer] = useState(false);
  const { theme } = useTheme(); // Get current theme

  useEffect(() => {
    const updateCursor = (e: MouseEvent) => {
      setPosition({ x: e.clientX, y: e.clientY });
      const target = e.target as HTMLElement;
      // Check if the target or its parent has cursor: pointer style
      let currentTarget: HTMLElement | null = target;
      let pointer = false;
      while (currentTarget) {
        if (window.getComputedStyle(currentTarget).cursor === 'pointer') {
          pointer = true;
          break;
        }
        currentTarget = currentTarget.parentElement;
      }
      setIsPointer(pointer);
    };

    window.addEventListener('mousemove', updateCursor);
    return () => window.removeEventListener('mousemove', updateCursor);
  }, []);

  // Define colors based on theme and hover state
  const primaryColor = fullConfig.theme.colors.primary[500]; // e.g., #0ea5e9
  const lightModeHoverColor = '#f97316'; // Tailwind orange-500 - complementary to blue

  const innerBackgroundColor = theme === 'light' && isPointer ? lightModeHoverColor : primaryColor;
  const outerBorderColor = theme === 'light' && isPointer ? lightModeHoverColor : primaryColor;
  const innerScale = isPointer ? 1.5 : 1;
  const outerScale = isPointer ? 1.5 : 1; // Scale outer ring as well on hover

  return (
    <>
      {/* Inner Dot */}
      <motion.div
        className="fixed top-0 left-0 w-4 h-4 rounded-full mix-blend-difference pointer-events-none z-50"
        animate={{
          x: position.x - 8,
          y: position.y - 8,
          scale: innerScale,
          backgroundColor: innerBackgroundColor, // Animate background color
        }}
        transition={{ type: "spring", stiffness: 500, damping: 28 }}
      />
      {/* Outer Ring */}
      <motion.div
        className="fixed top-0 left-0 w-8 h-8 rounded-full border-2 mix-blend-difference pointer-events-none z-50"
        animate={{
          x: position.x - 16,
          y: position.y - 16,
          scale: outerScale, // Animate scale
          borderColor: outerBorderColor, // Animate border color
        }}
        // Adjust transition for smoother color/scale change
        transition={{ type: "spring", stiffness: 400, damping: 28 }}
      />
    </>
  );
}