import { StyleSheet, View } from 'react-native';
import { theme } from '../../core/theme';
import { ContactScreen } from '../../components/screens/ContactScreen';

export default function Contact() {
  return (
    <View style={styles.container}>
      <ContactScreen />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: theme.colors.background,
  },
});