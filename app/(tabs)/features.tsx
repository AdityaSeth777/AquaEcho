import { StyleSheet, View } from 'react-native';
import { theme } from '../../core/theme';
import { FeaturesScreen } from '../../components/screens/FeaturesScreen';

export default function Features() {
  return (
    <View style={styles.container}>
      <FeaturesScreen />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: theme.colors.background,
  },
});