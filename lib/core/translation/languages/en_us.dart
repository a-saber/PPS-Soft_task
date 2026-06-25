import '../translation_keys.dart';

/// English (en_US) translations.
const Map<String, String> enUS = {
  // Generic / required
  TranslationsKeys.fieldRequired: 'This field is required',
  TranslationsKeys.fieldsDoNotMatch: 'Fields do not match',

  // Email / Phone
  TranslationsKeys.enterValidEmail: 'Please enter a valid email address',
  TranslationsKeys.enterValidPhone: 'Please enter a valid phone number',

  // Password
  TranslationsKeys.fieldMustBeAtLeast6Characters:
  'This field must be at least 6 characters',
  TranslationsKeys.fieldMaxLength: 'This field exceeds the maximum length',
  TranslationsKeys.passwordsDoNotMatch: 'Passwords do not match',
  TranslationsKeys.passwordRequireUppercase:
  'Password must contain at least one uppercase letter',
  TranslationsKeys.passwordRequireLowercase:
  'Password must contain at least one lowercase letter',
  TranslationsKeys.passwordRequireNumber:
  'Password must contain at least one number',
  TranslationsKeys.passwordRequireSpecialChar:
  'Password must contain at least one special character',

  // Name / Username
  TranslationsKeys.enterValidName: 'Please enter a valid name',
  TranslationsKeys.enterValidUsername: 'Please enter a valid username',

  // Address / Postal / National ID
  TranslationsKeys.enterValidPostalCode: 'Please enter a valid postal code',
  TranslationsKeys.enterValidNationalId: 'Please enter a valid national ID',

  // URL / Numbers
  TranslationsKeys.enterValidUrl: 'Please enter a valid URL',
  TranslationsKeys.digitsOnly: 'This field must contain digits only',
  TranslationsKeys.invalidNumber: 'Please enter a valid number',
  TranslationsKeys.valueTooSmall: 'Value is too small',
  TranslationsKeys.valueTooLarge: 'Value is too large',
};