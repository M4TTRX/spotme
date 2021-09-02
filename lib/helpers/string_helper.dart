String toCapitalized(String? s) {
  if (s == null || s == "") {
    return "";
  }
  return s[0].toUpperCase() + s.substring(1).toLowerCase();
}
