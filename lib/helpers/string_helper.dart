String toCapitalized(String? s) {
  if (s == null || s == "") {
    return "";
  }
  return s[0].toUpperCase() + s.substring(1).toLowerCase();
}

extension StringExtension on String {
  String capitalize() {
    if (this.length == 0) return this;
    return this[0].toUpperCase() + this.substring(1).toLowerCase();
  }
}

extension OptionalStringExtension on String? {
  String? capitalize() {
    if (this == null) {
      return null;
    }
    return this!.capitalize();
  }
}
