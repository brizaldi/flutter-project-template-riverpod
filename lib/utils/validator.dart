import '../features/core/domain/value_objects.dart';

class Validator {
  static bool validate(List<ValueObject<dynamic>> values) {
    return values.every((value) => value.isValid());
  }
}
