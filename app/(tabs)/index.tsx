import { StyleSheet, View } from 'react-native';
import { theme } from '../../core/theme';
import { HomeScreen } from '../../components/screens/HomeScreen';

export default function Home() {
  return (
    <View style={styles.container}>
      <HomeScreen />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: theme.colors.background,
  },
});