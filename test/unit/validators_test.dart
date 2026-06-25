import 'package:flutter_test/flutter_test.dart';
import 'package:pps_soft_task/core/utils/validators.dart';

void main() {
  group('Validators.required', () {
    test('returns error when value is null', () {
      final result = Validators.required(null, fieldLabel: 'Subject');
      expect(result, isNotNull);
    });

    test('returns error when value is empty/whitespace', () {
      final result = Validators.required('   ', fieldLabel: 'Subject');
      expect(result, isNotNull);
    });

    test('returns null when value is valid', () {
      final result = Validators.required('Login issue', fieldLabel: 'Subject');
      expect(result, isNull);
    });

    test('returns Arabic message when isArabic is true', () {
      final result = Validators.required(null, fieldLabel: 'الموضوع', isArabic: true);
      expect(result, contains('مطلوب'));
    });
  });
}
