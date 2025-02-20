export * from './colors';
export * from './spacing';
export * from './typography';
export * from './animations';

export const theme = {
  colors: require('./colors').colors,
  spacing: require('./spacing').spacing,
  typography: require('./typography').typography,
  animations: require('./animations').animations,
};