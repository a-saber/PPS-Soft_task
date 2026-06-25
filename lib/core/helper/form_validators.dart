import 'package:get/get.dart';

import '../translation/translation_keys.dart';

/// Advanced, reusable form validators.
///
/// Almost every validator accepts an `isRequired` flag:
/// - If `isRequired == true` (default for most fields) and the value is
///   empty -> returns "required" error.
/// - If `isRequired == false` and the value is empty -> returns `null`
///   (valid, field is optional).
/// - If the value is NOT empty, it is ALWAYS validated against the format
///   regardless of `isRequired`. (e.g. an optional phone field, once filled,
///   must still be a valid phone number).
class FormValidators {
  FormValidators._();

  // ---------------------------------------------------------------------
  // Regex patterns (compiled once, reused)
  // ---------------------------------------------------------------------
  static final RegExp _emailRegex =
  RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,4}$');

  static final RegExp _phoneRegex = RegExp(r'^\+?\d{9,15}$');

  static final RegExp _egyptPhoneRegex = RegExp(r'^01[0125]\d{8}$');

  static final RegExp _nameRegex =
  RegExp(r'^[a-zA-Z\u0600-\u06FF\s]{2,50}$');

  static final RegExp _usernameRegex = RegExp(r'^[a-zA-Z0-9_]{3,20}$');

  static final RegExp _urlRegex = RegExp(
    r'^(https?:\/\/)?([\w\-]+\.)+[\w\-]{2,}(\/[\w\-._~:/?#[\]@!$&()*+,;=%]*)?$',
  );

  static final RegExp _digitsOnlyRegex = RegExp(r'^\d+$');

  static final RegExp _decimalRegex = RegExp(r'^\d+(\.\d{1,2})?$');

  static final RegExp _postalCodeRegex = RegExp(r'^\d{4,10}$');

  static final RegExp _nationalIdRegex = RegExp(r'^\d{14}$');

  // ---------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------
  static bool _isEmpty(String? value) => value == null || value.trim().isEmpty;

  // ---------------------------------------------------------------------
  // Generic required / empty check
  // ---------------------------------------------------------------------
  static String? validateRequired(String? value, {bool isRequired = true}) {
    if (_isEmpty(value)) {
      return isRequired ? TranslationsKeys.fieldRequired.tr : null;
    }
    return null;
  }

  // ---------------------------------------------------------------------
  // Email
  // ---------------------------------------------------------------------
  static String? validateEmail(String? value, {bool isRequired = true}) {
    if (_isEmpty(value)) {
      return isRequired ? TranslationsKeys.fieldRequired.tr : null;
    }
    if (!_emailRegex.hasMatch(value!.trim())) {
      return TranslationsKeys.enterValidEmail.tr;
    }
    return null;
  }

  // ---------------------------------------------------------------------
  // Phone
  // ---------------------------------------------------------------------
  static String? validatePhone(
      String? value, {
        bool isRequired = true,
        bool egyptOnly = false,
      }) {
    if (_isEmpty(value)) {
      return isRequired ? TranslationsKeys.fieldRequired.tr : null;
    }
    final trimmed = value!.trim();
    final regex = egyptOnly ? _egyptPhoneRegex : _phoneRegex;
    if (!regex.hasMatch(trimmed)) {
      return TranslationsKeys.enterValidPhone.tr;
    }
    return null;
  }

  // ---------------------------------------------------------------------
  // Password / Confirm Password
  // ---------------------------------------------------------------------
  static String? validatePassword(
      String? value, {
        bool isRequired = true,
        int minLength = 6,
        int? maxLength,
        bool requireUppercase = false,
        bool requireLowercase = false,
        bool requireNumber = false,
        bool requireSpecialChar = false,
      }) {
    if (_isEmpty(value)) {
      return isRequired ? TranslationsKeys.fieldRequired.tr : null;
    }
    final v = value!;
    if (v.length < minLength) {
      return TranslationsKeys.fieldMustBeAtLeast6Characters.tr;
    }
    if (maxLength != null && v.length > maxLength) {
      return TranslationsKeys.fieldMaxLength.tr;
    }
    if (requireUppercase && !RegExp(r'[A-Z]').hasMatch(v)) {
      return TranslationsKeys.passwordRequireUppercase.tr;
    }
    if (requireLowercase && !RegExp(r'[a-z]').hasMatch(v)) {
      return TranslationsKeys.passwordRequireLowercase.tr;
    }
    if (requireNumber && !RegExp(r'\d').hasMatch(v)) {
      return TranslationsKeys.passwordRequireNumber.tr;
    }
    if (requireSpecialChar && !RegExp(r'[!@#\$&*~%^()\-_=+\[\]{}]').hasMatch(v)) {
      return TranslationsKeys.passwordRequireSpecialChar.tr;
    }
    return null;
  }

  static String? validateConfirmPassword(
      String? value,
      String? originalPassword, {
        bool isRequired = true,
      }) {
    if (_isEmpty(value)) {
      return isRequired ? TranslationsKeys.fieldRequired.tr : null;
    }
    if (value != originalPassword) {
      return TranslationsKeys.passwordsDoNotMatch.tr;
    }
    return null;
  }

  // ---------------------------------------------------------------------
  // Name (first / last / full)
  // ---------------------------------------------------------------------
  static String? validateName(
      String? value, {
        bool isRequired = true,
        int minLength = 2,
        int maxLength = 50,
      }) {
    if (_isEmpty(value)) {
      return isRequired ? TranslationsKeys.fieldRequired.tr : null;
    }
    final trimmed = value!.trim();
    if (trimmed.length < minLength || trimmed.length > maxLength) {
      return TranslationsKeys.fieldMustBeAtLeast6Characters.tr;
    }
    if (!_nameRegex.hasMatch(trimmed)) {
      return TranslationsKeys.enterValidName.tr;
    }
    return null;
  }

  // ---------------------------------------------------------------------
  // Username
  // ---------------------------------------------------------------------
  static String? validateUsername(String? value, {bool isRequired = true}) {
    if (_isEmpty(value)) {
      return isRequired ? TranslationsKeys.fieldRequired.tr : null;
    }
    if (!_usernameRegex.hasMatch(value!.trim())) {
      return TranslationsKeys.enterValidUsername.tr;
    }
    return null;
  }

  // ---------------------------------------------------------------------
  // Address (street/city/etc - free text with sane length bounds)
  // ---------------------------------------------------------------------
  static String? validateAddress(
      String? value, {
        bool isRequired = true,
        int minLength = 5,
        int maxLength = 200,
      }) {
    if (_isEmpty(value)) {
      return isRequired ? TranslationsKeys.fieldRequired.tr : null;
    }
    final trimmed = value!.trim();
    if (trimmed.length < minLength || trimmed.length > maxLength) {
      return TranslationsKeys.fieldMustBeAtLeast6Characters.tr;
    }
    return null;
  }

  // ---------------------------------------------------------------------
  // Postal / ZIP code
  // ---------------------------------------------------------------------
  static String? validatePostalCode(String? value, {bool isRequired = false}) {
    if (_isEmpty(value)) {
      return isRequired ? TranslationsKeys.fieldRequired.tr : null;
    }
    if (!_postalCodeRegex.hasMatch(value!.trim())) {
      return TranslationsKeys.enterValidPostalCode.tr;
    }
    return null;
  }

  // ---------------------------------------------------------------------
  // National ID
  // ---------------------------------------------------------------------
  static String? validateNationalId(String? value, {bool isRequired = true}) {
    if (_isEmpty(value)) {
      return isRequired ? TranslationsKeys.fieldRequired.tr : null;
    }
    if (!_nationalIdRegex.hasMatch(value!.trim())) {
      return TranslationsKeys.enterValidNationalId.tr;
    }
    return null;
  }

  // ---------------------------------------------------------------------
  // URL
  // ---------------------------------------------------------------------
  static String? validateUrl(String? value, {bool isRequired = false}) {
    if (_isEmpty(value)) {
      return isRequired ? TranslationsKeys.fieldRequired.tr : null;
    }
    if (!_urlRegex.hasMatch(value!.trim())) {
      return TranslationsKeys.enterValidUrl.tr;
    }
    return null;
  }

  // ---------------------------------------------------------------------
  // Numbers
  // ---------------------------------------------------------------------
  static String? validateDigitsOnly(String? value, {bool isRequired = true}) {
    if (_isEmpty(value)) {
      return isRequired ? TranslationsKeys.fieldRequired.tr : null;
    }
    if (!_digitsOnlyRegex.hasMatch(value!.trim())) {
      return TranslationsKeys.digitsOnly.tr;
    }
    return null;
  }

  static String? validateDecimal(String? value, {bool isRequired = true}) {
    if (_isEmpty(value)) {
      return isRequired ? TranslationsKeys.fieldRequired.tr : null;
    }
    if (!_decimalRegex.hasMatch(value!.trim())) {
      return TranslationsKeys.invalidNumber.tr;
    }
    return null;
  }

  static String? validateNumberRange(
      String? value, {
        bool isRequired = true,
        double? min,
        double? max,
      }) {
    if (_isEmpty(value)) {
      return isRequired ? TranslationsKeys.fieldRequired.tr : null;
    }
    final parsed = double.tryParse(value!.trim());
    if (parsed == null) {
      return TranslationsKeys.invalidNumber.tr;
    }
    if (min != null && parsed < min) {
      return TranslationsKeys.valueTooSmall.tr;
    }
    if (max != null && parsed > max) {
      return TranslationsKeys.valueTooLarge.tr;
    }
    return null;
  }

  // ---------------------------------------------------------------------
  // Length helpers
  // ---------------------------------------------------------------------
  static String? validateMinLength(
      String? value,
      int minLength, {
        bool isRequired = true,
      }) {
    if (_isEmpty(value)) {
      return isRequired ? TranslationsKeys.fieldRequired.tr : null;
    }
    if (value!.trim().length < minLength) {
      return TranslationsKeys.fieldMustBeAtLeast6Characters.tr;
    }
    return null;
  }

  static String? validateMaxLength(
      String? value,
      int maxLength, {
        bool isRequired = false,
      }) {
    if (_isEmpty(value)) {
      return isRequired ? TranslationsKeys.fieldRequired.tr : null;
    }
    if (value!.trim().length > maxLength) {
      return TranslationsKeys.fieldMaxLength.tr;
    }
    return null;
  }

  static String? validateLengthRange(
      String? value, {
        bool isRequired = true,
        required int minLength,
        required int maxLength,
      }) {
    if (_isEmpty(value)) {
      return isRequired ? TranslationsKeys.fieldRequired.tr : null;
    }
    final len = value!.trim().length;
    if (len < minLength || len > maxLength) {
      return TranslationsKeys.fieldMustBeAtLeast6Characters.tr;
    }
    return null;
  }

  // ---------------------------------------------------------------------
  // Match two fields (e.g. email confirmation, password confirmation)
  // ---------------------------------------------------------------------
  static String? validateMatch(
      String? value,
      String? otherValue, {
        bool isRequired = true,
      }) {
    if (_isEmpty(value)) {
      return isRequired ? TranslationsKeys.fieldRequired.tr : null;
    }
    if (value != otherValue) {
      return TranslationsKeys.fieldsDoNotMatch.tr;
    }
    return null;
  }

  // ---------------------------------------------------------------------
  // Compose multiple validators into one (runs in order, stops at first error)
  // ---------------------------------------------------------------------
  static String? Function(String?) compose(
      List<String? Function(String?)> validators,
      ) {
    return (String? value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) return result;
      }
      return null;
    };
  }
}