import { Easing } from 'react-native-reanimated';

export const animations = {
  timing: {
    default: 300,
    fast: 200,
    slow: 500,
  },
  
  easing: {
    default: Easing.bezier(0.4, 0, 0.2, 1),
    easeIn: Easing.bezier(0.4, 0, 1, 1),
    easeOut: Easing.bezier(0, 0, 0.2, 1),
    easeInOut: Easing.bezier(0.4, 0, 0.2, 1),
  },
  
  spring: {
    default: {
      damping: 10,
      mass: 1,
      stiffness: 100,
      overshootClamping: false,
      restDisplacementThreshold: 0.001,
      restSpeedThreshold: 0.001,
    },
    gentle: {
      damping: 15,
      mass: 1,
      stiffness: 80,
      overshootClamping: false,
      restDisplacementThreshold: 0.001,
      restSpeedThreshold: 0.001,
    },
  },
  
  transitions: {
    scale: {
      from: 0.95,
      to: 1,
    },
    fade: {
      from: 0,
      to: 1,
    },
    slide: {
      from: 20,
      to: 0,
    },
  },
}