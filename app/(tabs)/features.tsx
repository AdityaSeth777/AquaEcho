import { View, Text, StyleSheet, ScrollView } from 'react-native';
import { theme } from '../../core/theme';
import { Card } from '../../components/shared/Card';
import { Ionicons } from '@expo/vector-icons';
import Animated, { FadeInUp } from 'react-native-reanimated';

export default function Features() {
  return (
    <ScrollView style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.title}>Features</Text>
        <Text style={styles.subtitle}>
          Discover how AquaEcho enhances your swimming experience
        </Text>
      </View>

      <View style={styles.featuresGrid}>
        {features.map((feature, index) => (
          <Animated.View
            key={feature.title}
            entering={FadeInUp.delay(index * 200)}
            style={styles.featureCard}
          >
            <View style={[styles.iconContainer, { backgroundColor: feature.color }]}>
              <Ionicons name={feature.icon} size={32} color="white" />
            </View>
            <Text style={styles.featureTitle}>{feature.title}</Text>
            <Text style={styles.featureDescription}>{feature.description}</Text>
          </Animated.View>
        ))}
      </View>
    </ScrollView>
  );
}

const features = [
  {
    title: 'Lane Guidance',
    description: 'Real-time audio feedback keeps you centered in your lane',
    icon: 'navigate',
    color: theme.colors.primary,
  },
  {
    title: 'Performance Tracking',
    description: 'Monitor your progress with detailed analytics and insights',
    icon: 'stats-chart',
    color: theme.colors.secondary,
  },
  {
    title: 'Accessibility',
    description: 'Designed for swimmers of all abilities with intuitive feedback',
    icon: 'accessibility',
    color: theme.colors.features.accessibility,
  },
  {
    title: 'Lap Counter',
    description: 'Automatic lap detection and counting for accurate tracking',
    icon: 'repeat',
    color: theme.colors.features.tracking,
  },
  {
    title: 'Health Integration',
    description: 'Sync your swimming data with Apple Health',
    icon: 'heart',
    color: theme.colors.success,
  },
  {
    title: 'Smart Analytics',
    description: 'Advanced metrics and performance analysis',
    icon: 'analytics',
    color: theme.colors.features.analytics,
  },
];

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: theme.colors.background,
  },
  header: {
    padding: theme.spacing.xxl,
    backgroundColor: theme.colors.background,
  },
  title: {
    fontSize: theme.typography.sizes.xxxl,
    fontWeight: theme.typography.weights.bold,
    color: theme.colors.text,
    marginBottom: theme.spacing.md,
  },
  subtitle: {
    fontSize: theme.typography.sizes.lg,
    color: theme.colors.textLight,
    lineHeight: 24,
  },
  featuresGrid: {
    padding: theme.spacing.lg,
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: theme.spacing.lg,
  },
  featureCard: {
    width: '100%',
    maxWidth: 380,
    backgroundColor: theme.colors.background,
    borderRadius: theme.spacing.lg,
    padding: theme.spacing.xl,
    shadowColor: theme.colors.text,
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.1,
    shadowRadius: 8,
    elevation: 3,
  },
  iconContainer: {
    width: 64,
    height: 64,
    borderRadius: 32,
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: theme.spacing.lg,
  },
  featureTitle: {
    fontSize: theme.typography.sizes.xl,
    fontWeight: theme.typography.weights.bold,
    color: theme.colors.text,
    marginBottom: theme.spacing.sm,
  },
  featureDescription: {
    fontSize: theme.typography.sizes.md,
    color: theme.colors.textLight,
    lineHeight: 24,
  },
});