import 'package:fluttertutorial/Apps/PotentialPlugins/MultiLanguageProvider/MultiLanguageProvider.dart';
import 'package:form_field_validator/form_field_validator.dart';

class EditDuaPageValidator {
  String duaNameValidator(String value) {
    int minLength = 1;
    int maxLength = 50;

    var validator = MultiValidator([
      RequiredValidator(
          errorText: getLanguageText('duaName_requiredValidation')),
      MinLengthValidator(minLength,
          errorText: getLanguageText('duaName_MinLengthValidation')
              .toString()
              .replaceAll('[minLength]', '$minLength')),
      MaxLengthValidator(maxLength,
          errorText: getLanguageText('duaName_MaxLengthValidation')
              .toString()
              .replaceAll('[maxLength]', '$maxLength')),
    ]);

    return validator.call(value);
  }

  String zikirNameValidator(String value) {
    int minLength = 1;
    int maxLength = 50;

    var validator = MultiValidator([
      RequiredValidator(
          errorText: getLanguageText('zikirName_requiredValidation')),
      MinLengthValidator(minLength,
          errorText: getLanguageText('zikirName_MinLengthValidation')
              .toString()
              .replaceAll('[minLength]', '$minLength')),
      MaxLengthValidator(maxLength,
          errorText: getLanguageText('zikirName_MaxLengthValidation')
              .toString()
              .replaceAll('[maxLength]', '$maxLength')),
    ]);

    return validator.call(value);
  }

  String numberOfTimesWantToReadValidator(String value) {
    int minValue = 1;
    int maxValue = 10000;

    var validator = MultiValidator([
      RequiredValidator(
          errorText: getLanguageText('timeToRead_RequiredValidaton')),
      RangeValidator(
          min: minValue,
          max: maxValue,
          errorText: getLanguageText('timeToRead_RangeValidation')
              .toString()
              .replaceAll('[minValue]', '$minValue')
              .replaceAll('[maxValue]', '$maxValue'))
    ]);

    return validator.call(value);
  }

  String numberOfTimesReadValidator(String value, int maxTimesValue) {
    int minValue = 0;
    int maxValue = maxTimesValue;

    var validator = MultiValidator([
      RequiredValidator(
          errorText: getLanguageText('timeRead_RequiredValidaton')),

      RangeValidator(
          min: minValue,
          max: maxValue,
          errorText: getLanguageText('timeRead_RangeValidation')
              .toString()
              .replaceAll('[minValue]', '$minValue')
              .replaceAll('[maxValue]', '$maxValue'))
    ]);

    return validator.call(value);
  }
}
