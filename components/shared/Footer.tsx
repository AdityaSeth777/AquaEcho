import { View, Text, StyleSheet, TouchableOpacity } from 'react-native';
import { theme } from '../../core/theme';
import { Ionicons } from '@expo/vector-icons';

export function Footer() {
  return (
    <View style={styles.container}>
      <View style={styles.content}>
        <View style={styles.section}>
          <Text style={styles.title}>AquaEcho</Text>
          <Text style={styles.text}>
            Smart swimming assistant for visually impaired and competitive swimmers
          </Text>
        </View>

        <View style={styles.section}>
          <Text style={styles.sectionTitle}>Connect</Text>
          <View style={styles.socialLinks}>
            <TouchableOpacity style={styles.socialLink}>
              <Ionicons name="logo-github" size={24} color={theme.colors.text} />
            </TouchableOpacity>
            <TouchableOpacity style={styles.socialLink}>
              <Ionicons name="logo-linkedin" size={24} color={theme.colors.text} />
            </TouchableOpacity>
            <TouchableOpacity style={styles.socialLink}>
              <Ionicons name="logo-twitter" size={24} color={theme.colors.text} />
            </TouchableOpacity>
          </View>
        </View>
      </View>

      <Text style={styles.copyright}>
        © 2024 AquaEcho. All rights reserved.
      </Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    backgroundColor: theme.colors.background,
    paddingVertical: theme.spacing.xl,
    borderTopWidth: 1,
    borderTopColor: theme.colors.border,
  },
  content: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    paddingHorizontal: theme.spacing.xl,
    marginBottom: theme.spacing.lg,
  },
  section: {
    flex: 1,
    maxWidth: 300,
    marginRight: theme.spacing.xl,
  },
  title: {
    fontSize: theme.typography.sizes.xl,
    fontWeight: theme.typography.weights.bold,
    color: theme.colors.primary,
    marginBottom: theme.spacing.md,
  },
  sectionTitle: {
    fontSize: theme.typography.sizes.lg,
    fontWeight: theme.typography.weights.semibold,
    color: theme.colors.text,
    marginBottom: theme.spacing.md,
  },
  text: {
    fontSize: theme.typography.sizes.md,
    color: theme.colors.textLight,
    lineHeight: 24,
  },
  socialLinks: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  socialLink: {
    marginRight: theme.spacing.md,
  },
  copyright: {
    textAlign: 'center',
    fontSize: theme.typography.sizes.sm,
    color: theme.colors.textLight,
    marginTop: theme.spacing.lg,
  },
});