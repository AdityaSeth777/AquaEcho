import { Dimensions, Platform, ScaledSize } from 'react-native';

const { width, height } = Dimensions.get('window');

export const isWeb = Platform.OS === 'web';
export const isIOS = Platform.OS === 'ios';
export const isAndroid = Platform.OS === 'android';

export const breakpoints = {
  sm: 640,
  md: 768,
  lg: 1024,
  xl: 1280,
};

export const getResponsiveValue = (
  value: number,
  scale: number = 1
): number => {
  const baseWidth = 375; // iPhone SE width
  const ratio = width / baseWidth;
  return value * ratio * scale;
};

export const getBreakpointValue = (
  mobile: number,
  tablet?: number,
  desktop?: number
): number => {
  if (width >= breakpoints.lg && desktop !== undefined) {
    return desktop;
  }
  if (width >= breakpoints.md && tablet !== undefined) {
    return tablet;
  }
  return mobile;
};

export const useResponsiveDimensions = () => {
  const window = Dimensions.get('window');
  const screen = Dimensions.get('screen');

  return {
    window,
    screen,
    isSmallDevice: window.width < breakpoints.sm,
    isTablet: window.width >= breakpoints.md && window.width < breakpoints.lg,
    isDesktop: window.width >= breakpoints.lg,
  };
};

export const getDeviceType = () => {
  if (width >= breakpoints.lg) return 'desktop';
  if (width >= breakpoints.md) return 'tablet';
  return 'mobile';
};

export const getFontScale = (size: number): number => {
  const deviceType = getDeviceType();
  const scales = {
    mobile: 1,
    tablet: 1.1,
    desktop: 1.2,
  };
  return size * scales[deviceType];
};