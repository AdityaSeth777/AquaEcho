import { View, Text, StyleSheet, TextInput, ScrollView } from 'react-native';
import { theme } from '../../core/theme';
import { Button } from '../../components/shared/Button';
import { useState } from 'react';
import { validateForm } from '../../core/utils/validation';
import Animated, { FadeInUp } from 'react-native-reanimated';
import { Ionicons } from '@expo/vector-icons';

export default function Contact() {
  const [name, setName] = useState('');
  const [email, setEmail] = useState('');
  const [message, setMessage] = useState('');
  const [errors, setErrors] = useState<Record<string, string>>({});
  const [submitted, setSubmitted] = useState(false);

  const handleSubmit = () => {
    const validation = validateForm(email, name, message);
    setErrors(validation.errors);

    if (validation.isValid) {
      // Here you would typically send the form data to your backend
      setSubmitted(true);
      setName('');
      setEmail('');
      setMessage('');
    }
  };

  return (
    <ScrollView style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.title}>Get in Touch</Text>
        <Text style={styles.subtitle}>
          Have questions? We'd love to hear from you.
        </Text>
      </View>

      <View style={styles.content}>
        <View style={styles.contactInfo}>
          {contactMethods.map((method, index) => (
            <Animated.View
              key={method.title}
              entering={FadeInUp.delay(index * 200)}
              style={styles.contactMethod}
            >
              <View style={styles.iconContainer}>
                <Ionicons name={method.icon} size={24} color={theme.colors.primary} />
              </View>
              <Text style={styles.methodTitle}>{method.title}</Text>
              <Text style={styles.methodValue}>{method.value}</Text>
            </Animated.View>
          ))}
        </View>

        <Animated.View
          entering={FadeInUp.delay(400)}
          style={styles.formContainer}
        >
          {submitted ? (
            <View style={styles.successMessage}>
              <Ionicons name="checkmark-circle" size={48} color={theme.colors.success} />
              <Text style={styles.successText}>
                Thank you for your message! We'll get back to you soon.
              </Text>
            </View>
          ) : (
            <>
              <View style={styles.inputGroup}>
                <Text style={styles.label}>Name</Text>
                <TextInput
                  style={styles.input}
                  value={name}
                  onChangeText={setName}
                  placeholder="Your name"
                />
                {errors.name && <Text style={styles.error}>{errors.name}</Text>}
              </View>

              <View style={styles.inputGroup}>
                <Text style={styles.label}>Email</Text>
                <TextInput
                  style={styles.input}
                  value={email}
                  onChangeText={setEmail}
                  placeholder="your@email.com"
                  keyboardType="email-address"
                  autoCapitalize="none"
                />
                {errors.email && <Text style={styles.error}>{errors.email}</Text>}
              </View>

              <View style={styles.inputGroup}>
                <Text style={styles.label}>Message</Text>
                <TextInput
                  style={[styles.input, styles.messageInput]}
                  value={message}
                  onChangeText={setMessage}
                  placeholder="Your message"
                  multiline
                  numberOfLines={4}
                />
                {errors.message && <Text style={styles.error}>{errors.message}</Text>}
              </View>

              <Button
                title="Send Message"
                onPress={handleSubmit}
                style={styles.submitButton}
              />
            </>
          )}
        </Animated.View>
      </View>
    </ScrollView>
  );
}

const contactMethods = [
  {
    title: 'Email',
    value: 'contact@aquaecho.com',
    icon: 'mail-outline',
  },
  {
    title: 'Phone',
    value: '+1 (555) 123-4567',
    icon: 'call-outline',
  },
  {
    title: 'Location',
    value: 'San Francisco, CA',
    icon: 'location-outline',
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
  content: {
    padding: theme.spacing.lg,
  },
  contactInfo: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: theme.spacing.lg,
    marginBottom: theme.spacing.xxl,
  },
  contactMethod: {
    flex: 1,
    minWidth: 200,
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
  iconContainer: {
    width: 48,
    height: 48,
    borderRadius: 24,
    backgroundColor: theme.colors.primary + '10',
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: theme.spacing.md,
  },
  methodTitle: {
    fontSize: theme.typography.sizes.lg,
    fontWeight: theme.typography.weights.semibold,
    color: theme.colors.text,
    marginBottom: theme.spacing.xs,
  },
  methodValue: {
    fontSize: theme.typography.sizes.md,
    color: theme.colors.textLight,
  },
  formContainer: {
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
  inputGroup: {
    marginBottom: theme.spacing.lg,
  },
  label: {
    fontSize: theme.typography.sizes.md,
    fontWeight: theme.typography.weights.semibold,
    color: theme.colors.text,
    marginBottom: theme.spacing.xs,
  },
  input: {
    borderWidth: 1,
    borderColor: theme.colors.border,
    borderRadius: theme.spacing.sm,
    padding: theme.spacing.md,
    fontSize: theme.typography.sizes.md,
    color: theme.colors.text,
  },
  messageInput: {
    height: 120,
    textAlignVertical: 'top',
  },
  error: {
    color: theme.colors.error,
    fontSize: theme.typography.sizes.sm,
    marginTop: theme.spacing.xs,
  },
  submitButton: {
    marginTop: theme.spacing.lg,
  },
  successMessage: {
    alignItems: 'center',
    padding: theme.spacing.xl,
  },
  successText: {
    fontSize: theme.typography.sizes.lg,
    color: theme.colors.success,
    textAlign: 'center',
    marginTop: theme.spacing.lg,
  },
});