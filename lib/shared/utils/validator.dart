typedef ValidatorFunction = String? Function(String? value);

class Validator {
  final String? value;
  String? error;
  final bool _empty;

  Validator(this.value) : _empty = value == null || value.isEmpty;

  Validator custom(ValidatorFunction validator) {
    error ??= validator(value);
    return this;
  }

  Validator mandatory(String message) {
    if (_empty) {
      error ??= message;
    }
    return this;
  }

  Validator digits(String message) {
    final regex = RegExp(r'^[0-9]*$');
    if (!_empty && !regex.hasMatch(value!)) {
      error ??= message;
    }
    return this;
  }

  Validator number(String message) {
    final parsed = value == null ? null : double.tryParse(value!);
    final isInvalid = parsed == null || !parsed.isFinite || parsed.isNegative;
    if (!_empty && isInvalid) {
      error ??= message;
    }
    return this;
  }

  Validator alpha(String message) {
    final regex = RegExp(r"^[\p{L} ,.'-]+$", unicode: true);
    if (!_empty && !regex.hasMatch(value!)) {
      error ??= message;
    }
    return this;
  }

  Validator email(String message) {
    final regex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
    );
    if (!_empty && !regex.hasMatch(value!)) {
      error ??= message;
    }
    return this;
  }

  Validator length(int length, String message) {
    if (!_empty && value!.length != length) {
      error ??= message;
    }
    return this;
  }

  Validator equal(String other, String message) {
    if (!_empty && value != other) {
      error ??= message;
    }
    return this;
  }

  Validator min(int min, String message) {
    if (!_empty && value!.length < min) {
      error ??= message;
    }
    return this;
  }

  Validator max(int max, String message) {
    if (!_empty && value!.length > max) {
      error ??= message;
    }
    return this;
  }

  Validator startsWith(String start, String message) {
    if (!_empty && !value!.startsWith(start)) {
      error ??= message;
    }
    return this;
  }
}
