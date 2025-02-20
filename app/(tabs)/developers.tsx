import { StyleSheet, View } from 'react-native';
import { theme } from '../../core/theme';
import { DevelopersScreen } from '../../components/screens/DevelopersScreen';

export default function Developers() {
  return (
    <View style={styles.container}>
      <DevelopersScreen />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: theme.colors.background,
  },
});