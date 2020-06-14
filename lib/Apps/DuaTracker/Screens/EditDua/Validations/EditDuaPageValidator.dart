import 'package:form_field_validator/form_field_validator.dart';

class EditDuaPageValidator {
  static String duaNameValidator(String value) {
    var validator = MultiValidator([
      RequiredValidator(errorText: 'দোয়ার নাম আবশ্যক'),
      MinLengthValidator(1,
          errorText: 'দোয়ার নাম অন্তত এক অক্ষর বিশিষ্ট হতে হবে'),
      MaxLengthValidator(10,
          errorText: 'দোয়ার নাম ১০  অক্ষরের বেশি হতে পারবে না'),
    ]);

    return validator.call(value);
  }

  static String zikirNameValidator(String value) {
    var validator = MultiValidator([
      RequiredValidator(errorText: 'জিকিরের নাম আবশ্যক'),
      MinLengthValidator(1,
          errorText: 'জিকিরের নাম অন্তত এক অক্ষর বিশিষ্ট হতে হবে'),
      MaxLengthValidator(10,
          errorText: 'জিকিরের নাম ১০  অক্ষরের বেশি হতে পারবে না'),
    ]);

    return validator.call(value);
  }

  static String numberOfTimesWantToReadValidator(String value) {
    var validator = MultiValidator([
      RequiredValidator(errorText: 'আবশ্যক'),
      RangeValidator(
          min: 1, max: 999, errorText: '১ - ৯৯৯ এর মাঝে যে কোন সংখ্যা')
    ]);

    return validator.call(value);
  }

  static String numberOfTimesReadValidator(String value) {
    var validator = MultiValidator([
      RequiredValidator(errorText: 'আবশ্যক'),
    ]);

    return validator.call(value);
  }
}
