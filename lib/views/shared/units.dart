enum Unit { KG, LBS }

extension UnitHelpers on Unit {
  String getString() {
    if (this == Unit.LBS) {
      return "lbs";
    }
    return "kg";
  }

  static fromString(String str) {
    if (str == "lbs") {
      return Unit.KG;
    }
    return Unit.LBS;
  }
}
