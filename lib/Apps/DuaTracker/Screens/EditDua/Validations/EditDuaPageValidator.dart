import 'package:form_field_validator/form_field_validator.dart';

class EditDuaPageValidator {
   String duaNameValidator(String value) {
    int minLength = 1;
    int maxLength = 50;

    var validator = MultiValidator([
      RequiredValidator(errorText: 'দোয়ার নাম আবশ্যক'),
      MinLengthValidator(minLength,
          errorText: 'দোয়ার নাম অন্তত $minLength অক্ষর বিশিষ্ট হতে হবে'),
      MaxLengthValidator(maxLength,
          errorText: 'দোয়ার নাম $maxLength  অক্ষরের বেশি হতে পারবে না'),
    ]);

    return validator.call(value);
  }

   String zikirNameValidator(String value) {
    int minLength = 1;
    int maxLength = 50;

    var validator = MultiValidator([
      RequiredValidator(errorText: 'জিকিরের  নাম আবশ্যক'),
      MinLengthValidator(minLength,
          errorText: 'জিকিরের নাম অন্তত $minLength অক্ষর বিশিষ্ট হতে হবে'),
      MaxLengthValidator(maxLength,
          errorText: 'জিকিরের নাম $maxLength অক্ষরের বেশি হতে পারবে না'),
    ]);

    return validator.call(value);
  }

  String numberOfTimesWantToReadValidator(String value) {
    int minValue = 1;
    int maxValue = 10000;

    var validator = MultiValidator([
      RequiredValidator(errorText: 'আবশ্যক'),
      RangeValidator(
          min: minValue,
          max: maxValue,
          errorText: '$minValue - $maxValue এর মাঝে যে কোন সংখ্যা')
    ]);

    return validator.call(value);
  }

   String numberOfTimesReadValidator(String value, int maxTimesValue) {
    int minValue = 0;
    int maxValue = maxTimesValue;

    var validator = MultiValidator([
      RequiredValidator(errorText: 'আবশ্যক'),
      RangeValidator(
          min: minValue,
          max: maxValue,
          errorText:
              '$minValue - $maxValue এর মাঝে যে কোন সংখ্যা। যতবার পড়তে চান, তার চেয়ে বড় সংখ্যা হতে পারবে না।')
    ]);

    return validator.call(value);
  }
}
