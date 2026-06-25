
import '../translation_keys.dart';

/// Arabic (ar_SA) translations.
const Map<String, String> arSA = {
  // Generic / required
  TranslationsKeys.fieldRequired: 'هذا الحقل مطلوب',
  TranslationsKeys.fieldsDoNotMatch: 'الحقول غير متطابقة',

  // Email / Phone
  TranslationsKeys.enterValidEmail: 'من فضلك أدخل بريد إلكتروني صحيح',
  TranslationsKeys.enterValidPhone: 'من فضلك أدخل رقم هاتف صحيح',

  // Password
  TranslationsKeys.fieldMustBeAtLeast6Characters:
  'يجب أن يحتوي هذا الحقل على 6 أحرف على الأقل',
  TranslationsKeys.fieldMaxLength: 'هذا الحقل تجاوز الحد الأقصى للطول',
  TranslationsKeys.passwordsDoNotMatch: 'كلمتا المرور غير متطابقتين',
  TranslationsKeys.passwordRequireUppercase:
  'يجب أن تحتوي كلمة المرور على حرف كبير واحد على الأقل',
  TranslationsKeys.passwordRequireLowercase:
  'يجب أن تحتوي كلمة المرور على حرف صغير واحد على الأقل',
  TranslationsKeys.passwordRequireNumber:
  'يجب أن تحتوي كلمة المرور على رقم واحد على الأقل',
  TranslationsKeys.passwordRequireSpecialChar:
  'يجب أن تحتوي كلمة المرور على رمز خاص واحد على الأقل',

  // Name / Username
  TranslationsKeys.enterValidName: 'من فضلك أدخل اسمًا صحيحًا',
  TranslationsKeys.enterValidUsername: 'من فضلك أدخل اسم مستخدم صحيح',

  // Address / Postal / National ID
  TranslationsKeys.enterValidPostalCode: 'من فضلك أدخل رمزًا بريديًا صحيحًا',
  TranslationsKeys.enterValidNationalId: 'من فضلك أدخل رقم قومي صحيح',

  // URL / Numbers
  TranslationsKeys.enterValidUrl: 'من فضلك أدخل رابطًا صحيحًا',
  TranslationsKeys.digitsOnly: 'يجب أن يحتوي هذا الحقل على أرقام فقط',
  TranslationsKeys.invalidNumber: 'من فضلك أدخل رقمًا صحيحًا',
  TranslationsKeys.valueTooSmall: 'القيمة أصغر من المسموح',
  TranslationsKeys.valueTooLarge: 'القيمة أكبر من المسموح',
};