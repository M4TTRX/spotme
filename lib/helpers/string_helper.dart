String toCapitalized(String? s) {
  if (s == null) {
    return "";
  }
  return s[0].toUpperCase() + s.substring(1).toLowerCase();
}
