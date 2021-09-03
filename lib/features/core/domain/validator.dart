import 'value_objects.dart';

class Validator {
  static bool validate(List<ValueObject> values) {
    return values.every((value) => value.isValid());
  }
}
