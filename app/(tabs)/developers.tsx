import { View, Text, StyleSheet, ScrollView, Image } from 'react-native';
import { theme } from '../../core/theme';
import Animated, { FadeInUp } from 'react-native-reanimated';

export default function Developers() {
  return (
    <ScrollView style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.title}>Meet Our Team</Text>
        <Text style={styles.subtitle}>
          The passionate developers behind AquaEcho
        </Text>
      </View>

      <View style={styles.teamGrid}>
        {team.map((member, index) => (
          <Animated.View
            key={member.name}
            entering={FadeInUp.delay(index * 200)}
            style={styles.teamCard}
          >
            <Image
              source={{ uri: member.image }}
              style={styles.memberImage}
            />
            <Text style={styles.memberName}>{member.name}</Text>
            <Text style={styles.memberRole}>{member.role}</Text>
            <Text style={styles.memberBio}>{member.bio}</Text>
          </Animated.View>
        ))}
      </View>
    </ScrollView>
  );
}

const team = [
  {
    name: 'Sarah Chen',
    role: 'Lead Developer',
    bio: 'Passionate about creating accessible technology solutions with over 8 years of experience in mobile development.',
    image: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400&h=400&fit=crop',
  },
  {
    name: 'Marcus Rodriguez',
    role: 'UX Designer',
    bio: 'Focused on creating intuitive and accessible user experiences that make technology more inclusive.',
    image: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=400&fit=crop',
  },
  {
    name: 'Aisha Patel',
    role: 'Motion Tracking Specialist',
    bio: 'Expert in sensor fusion and motion tracking algorithms with a background in competitive swimming.',
    image: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400&h=400&fit=crop',
  },
  {
    name: 'David Kim',
    role: 'Audio Engineer',
    bio: 'Specializes in spatial audio and real-time sound processing for enhanced user feedback.',
    image: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400&h=400&fit=crop',
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
  teamGrid: {
    padding: theme.spacing.lg,
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: theme.spacing.xl,
    justifyContent: 'center',
  },
  teamCard: {
    width: '100%',
    maxWidth: 300,
    backgroundColor: theme.colors.background,
    borderRadius: theme.spacing.lg,
    padding: theme.spacing.xl,
    alignItems: 'center',
    shadowColor: theme.colors.text,
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.1,
    shadowRadius: 8,
    elevation: 3,
  },
  memberImage: {
    width: 120,
    height: 120,
    borderRadius: 60,
    marginBottom: theme.spacing.lg,
  },
  memberName: {
    fontSize: theme.typography.sizes.xl,
    fontWeight: theme.typography.weights.bold,
    color: theme.colors.text,
    marginBottom: theme.spacing.xs,
  },
  memberRole: {
    fontSize: theme.typography.sizes.md,
    color: theme.colors.primary,
    marginBottom: theme.spacing.md,
  },
  memberBio: {
    fontSize: theme.typography.sizes.md,
    color: theme.colors.textLight,
    textAlign: 'center',
    lineHeight: 24,
  },
});