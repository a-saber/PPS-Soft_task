/// Centralized translation keys.
///
/// Never hardcode a translation string anywhere in the app — always
/// reference it through this class (e.g. `TranslationsKeys.fieldRequired.tr`).
/// This keeps every key in one place and makes it impossible to typo a
/// key string in two different files.
abstract class TranslationsKeys {
  // ---------------------------------------------------------------------
  // Generic / required
  // ---------------------------------------------------------------------
  static const String fieldRequired = 'fieldRequired';
  static const String fieldsDoNotMatch = 'fieldsDoNotMatch';

  // ---------------------------------------------------------------------
  // Email / Phone
  // ---------------------------------------------------------------------
  static const String enterValidEmail = 'enterValidEmail';
  static const String enterValidPhone = 'enterValidPhone';

  // ---------------------------------------------------------------------
  // Password
  // ---------------------------------------------------------------------
  static const String fieldMustBeAtLeast6Characters =
      'fieldMustBeAtLeast6Characters';
  static const String fieldMaxLength = 'fieldMaxLength';
  static const String passwordsDoNotMatch = 'passwordsDoNotMatch';
  static const String passwordRequireUppercase = 'passwordRequireUppercase';
  static const String passwordRequireLowercase = 'passwordRequireLowercase';
  static const String passwordRequireNumber = 'passwordRequireNumber';
  static const String passwordRequireSpecialChar =
      'passwordRequireSpecialChar';

  // ---------------------------------------------------------------------
  // Name / Username
  // ---------------------------------------------------------------------
  static const String enterValidName = 'enterValidName';
  static const String enterValidUsername = 'enterValidUsername';

  // ---------------------------------------------------------------------
  // Address / Postal / National ID
  // ---------------------------------------------------------------------
  static const String enterValidPostalCode = 'enterValidPostalCode';
  static const String enterValidNationalId = 'enterValidNationalId';

  // ---------------------------------------------------------------------
  // URL / Numbers
  // ---------------------------------------------------------------------
  static const String enterValidUrl = 'enterValidUrl';
  static const String digitsOnly = 'digitsOnly';
  static const String invalidNumber = 'invalidNumber';
  static const String valueTooSmall = 'valueTooSmall';
  static const String valueTooLarge = 'valueTooLarge';


  // ---------------------------------------------------------------------
  // Ticket / Status / Priority / Category
  // ---------------------------------------------------------------------
  static const String open = 'open';
  static const String inProgress = 'inProgress';
  static const String closed = 'closed';

  static const String low = 'low';
  static const String medium = 'medium';
  static const String high = 'high';

  static const String technical = 'technical';
  static const String billing = 'billing';
  static const String general = 'general';

  static const String newestFirst = 'newestFirst';
  static const String oldestFirst = 'oldestFirst';


}