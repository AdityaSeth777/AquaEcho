import Animated, {
  withSpring,
  withTiming,
  WithSpringConfig,
  WithTimingConfig,
} from 'react-native-reanimated';
import { theme } from '../theme';

export const springConfig: WithSpringConfig = {
  ...theme.animations.spring.default,
};

export const timingConfig: WithTimingConfig = {
  duration: theme.animations.timing.default,
  easing: theme.animations.easing.default,
};

export const createSpringAnimation = (
  toValue: number,
  config: Partial<WithSpringConfig> = {}
) => {
  return withSpring(toValue, {
    ...springConfig,
    ...config,
  });
};

export const createTimingAnimation = (
  toValue: number,
  config: Partial<WithTimingConfig> = {}
) => {
  return withTiming(toValue, {
    ...timingConfig,
    ...config,
  });
};

export const parallaxScrollAnimation = (
  scrollY: Animated.SharedValue<number>,
  inputRange: number[],
  outputRange: number[]
) => {
  'worklet';
  return Animated.interpolate(
    scrollY,
    inputRange,
    outputRange,
    Animated.Extrapolate.CLAMP
  );
};

export const scaleAnimation = (
  value: Animated.SharedValue<number>,
  scale: number = 1.1
) => {
  'worklet';
  return Animated.interpolate(
    value,
    [0, 1],
    [1, scale],
    Animated.Extrapolate.CLAMP
  );
};

export const fadeAnimation = (
  value: Animated.SharedValue<number>,
  opacity: number = 0
) => {
  'worklet';
  return Animated.interpolate(
    value,
    [0, 1],
    [1, opacity],
    Animated.Extrapolate.CLAMP
  );
};