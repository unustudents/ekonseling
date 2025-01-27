bool isValidEmpty(String? value) {
  bool empty = value == null || value.isEmpty;
  return empty;
}

bool isValidPassword(String value) => value.length >= 6;
