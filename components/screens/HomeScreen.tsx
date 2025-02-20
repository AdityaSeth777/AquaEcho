import { View, Text, StyleSheet, Image, ScrollView } from 'react-native';
import { theme } from '../../core/theme';
import { Button } from '../shared/Button';
import { Navbar } from '../shared/Navbar';
import { Footer } from '../shared/Footer';
import Animated, { 
  FadeInDown, 
  FadeInUp,
  useAnimatedScrollHandler,
  useSharedValue
} from 'react-native-reanimated';

export function HomeScreen() {
  const scrollY = useSharedValue(0);

  const scrollHandler = useAnimatedScrollHandler({
    onScroll: (event) => {
      scrollY.value = event.contentOffset.y;
    },
  });

  return (
    <ScrollView 
      style={styles.container}
      onScroll={scrollHandler}
      scrollEventThrottle={16}
    >
      <Navbar />
      
      {/* Hero Section */}
      <View style={styles.hero}>
        <Animated.View 
          entering={FadeInDown.duration(1000)}
          style={styles.heroContent}
        >
          <Text style={styles.heroTitle}>
            Smart Swimming Assistant for Everyone
          </Text>
          <Text style={styles.heroSubtitle}>
            Real-time guidance and tracking for visually impaired and competitive swimmers
          </Text>
          <Button 
            title="Get Started"
            onPress={() => {}}
            style={styles.heroButton}
          />
        </Animated.View>
        
        <Animated.Image 
          entering={FadeInUp.duration(1000).delay(300)}
          source={{ uri: 'https://source.unsplash.com/random/800x600/?swimming' }}
          style={styles.heroImage}
        />
      </View>

      {/* Features Preview */}
      <View style={styles.features}>
        <Text style={styles.sectionTitle}>Key Features</Text>
        <View style={styles.featureGrid}>
          {features.map((feature, index) => (
            <Animated.View 
              key={feature.title}
              entering={FadeInUp.duration(800).delay(index * 200)}
              style={styles.featureCard}
            >
              <Image source={{ uri: feature.image }} style={styles.featureImage} />
              <Text style={styles.featureTitle}>{feature.title}</Text>
              <Text style={styles.featureDescription}>{feature.description}</Text>
            </Animated.View>
          ))}
        </View>
      </View>

      <Footer />
    </ScrollView>
  );
}

const features = [
  {
    title: 'Lane Guidance',
    description: 'Real-time audio feedback for perfect lane positioning',
    image: 'https://source.unsplash.com/random/400x300/?swimming-pool',
  },
  {
    title: 'Performance Tracking',
    description: 'Comprehensive analytics and progress monitoring',
    image: 'https://source.unsplash.com/random/400x300/?swimming-competition',
  },
  {
    title: 'Accessibility',
    description: 'Designed for swimmers of all abilities',
    image: 'https://source.unsplash.com/random/400x300/?swimming-training',
  },
];

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: theme.colors.background,
  },
  hero: {
    minHeight: 600,
    padding: theme.spacing.xxl,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
  },
  heroContent: {
    flex: 1,
    marginRight: theme.spacing.xxl,
  },
  heroTitle: {
    fontSize: theme.typography.sizes.xxxl,
    fontWeight: theme.typography.weights.bold,
    color: theme.colors.text,
    marginBottom: theme.spacing.lg,
  },
  heroSubtitle: {
    fontSize: theme.typography.sizes.lg,
    color: theme.colors.textLight,
    marginBottom: theme.spacing.xl,
    lineHeight: 28,
  },
  heroButton: {
    width: 200,
  },
  heroImage: {
    flex: 1,
    height: 400,
    borderRadius: theme.spacing.lg,
  },
  features: {
    padding: theme.spacing.xxl,
  },
  sectionTitle: {
    fontSize: theme.typography.sizes.xxl,
    fontWeight: theme.typography.weights.bold,
    color: theme.colors.text,
    marginBottom: theme.spacing.xl,
    textAlign: 'center',
  },
  featureGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'center',
    gap: theme.spacing.xl,
  },
  featureCard: {
    width: 300,
    backgroundColor: theme.colors.background,
    borderRadius: theme.spacing.lg,
    overflow: 'hidden',
    shadowColor: theme.colors.text,
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.1,
    shadowRadius: 8,
    elevation: 3,
  },
  featureImage: {
    width: '100%',
    height: 200,
  },
  featureTitle: {
    fontSize: theme.typography.sizes.lg,
    fontWeight: theme.typography.weights.semibold,
    color: theme.colors.text,
    margin: theme.spacing.md,
  },
  featureDescription: {
    fontSize: theme.typography.sizes.md,
    color: theme.colors.textLight,
    marginHorizontal: theme.spacing.md,
    marginBottom: theme.spacing.md,
  },
});