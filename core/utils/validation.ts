export const validateEmail = (email: string): boolean => {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailRegex.test(email);
};

export const validateName = (name: string): boolean => {
  return name.length >= 2;
};

export const validateMessage = (message: string): boolean => {
  return message.length >= 10;
};

export const validateForm = (
  email: string,
  name: string,
  message: string
): { isValid: boolean; errors: Record<string, string> } => {
  const errors: Record<string, string> = {};

  if (!validateEmail(email)) {
    errors.email = 'Please enter a valid email address';
  }

  if (!validateName(name)) {
    errors.name = 'Name must be at least 2 characters long';
  }

  if (!validateMessage(message)) {
    errors.message = 'Message must be at least 10 characters long';
  }

  return {
    isValid: Object.keys(errors).length === 0,
    errors,
  };
};