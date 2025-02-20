import { View, Text, StyleSheet, TouchableOpacity } from 'react-native';
import { useRouter } from 'expo-router';
import { theme } from '../../core/theme';
import { Ionicons } from '@expo/vector-icons';

export function Navbar() {
  const router = useRouter();

  return (
    <View style={styles.container}>
      <TouchableOpacity 
        style={styles.logo}
        onPress={() => router.push('/')}
      >
        <Ionicons name="water" size={32} color={theme.colors.primary} />
        <Text style={styles.logoText}>AquaEcho</Text>
      </TouchableOpacity>

      <View style={styles.nav}>
        <TouchableOpacity 
          style={styles.navItem}
          onPress={() => router.push('/features')}
        >
          <Text style={styles.navText}>Features</Text>
        </TouchableOpacity>

        <TouchableOpacity 
          style={styles.navItem}
          onPress={() => router.push('/developers')}
        >
          <Text style={styles.navText}>Team</Text>
        </TouchableOpacity>

        <TouchableOpacity 
          style={styles.navItem}
          onPress={() => router.push('/contact')}
        >
          <Text style={styles.navText}>Contact</Text>
        </TouchableOpacity>
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingHorizontal: theme.spacing.lg,
    paddingVertical: theme.spacing.md,
    backgroundColor: theme.colors.background,
    borderBottomWidth: 1,
    borderBottomColor: theme.colors.border,
  },
  logo: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  logoText: {
    fontSize: theme.typography.sizes.lg,
    fontWeight: theme.typography.weights.bold,
    marginLeft: theme.spacing.sm,
    color: theme.colors.primary,
  },
  nav: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  navItem: {
    marginLeft: theme.spacing.lg,
  },
  navText: {
    fontSize: theme.typography.sizes.md,
    color: theme.colors.text,
  },
});