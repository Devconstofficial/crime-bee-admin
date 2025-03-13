enum CrimeCategoryEnums {
  kBicycleTheft,
  kBurglary,
  kDrugs,
  kOtherTheft,
  kPublicOrder,
  kRobbery,
  kTheftFromThePerson,
  kShoplifting,
  kVehicleCrime,
  kPossessionOfWeapons,
  kCriminalDamageAndArson,
  kViolenceAndSexualOffense,
  kTHEFT,
  kASSAULT,
  kVANDALISM,
}

extension CrimeCategoryString on CrimeCategoryEnums {
  String convertToString() {
    switch(this) {
      case CrimeCategoryEnums.kViolenceAndSexualOffense:
        return "Violence and sexual offense";
      case CrimeCategoryEnums.kVehicleCrime:
        return "Vehicle crime";
      case CrimeCategoryEnums.kTheftFromThePerson:
        return "Theft from the person";
      case CrimeCategoryEnums.kShoplifting:
        return "Shoplifting";
      case CrimeCategoryEnums.kRobbery:
        return "Robbery";
      case CrimeCategoryEnums.kPublicOrder:
        return "Public order";
      case CrimeCategoryEnums.kPossessionOfWeapons:
        return "Possession of weapons";
      case CrimeCategoryEnums.kOtherTheft:
        return "Other theft";
      case CrimeCategoryEnums.kDrugs:
        return "Drugs";
      case CrimeCategoryEnums.kCriminalDamageAndArson:
        return "Criminal damage and arson";
      case CrimeCategoryEnums.kBicycleTheft:
        return "Bicycle theft";
      case CrimeCategoryEnums.kBurglary:
        return "Burglary";
      case CrimeCategoryEnums.kTHEFT:
        return "Theft";
      case CrimeCategoryEnums.kASSAULT:
        return "Assault";
      case CrimeCategoryEnums.kVANDALISM:
        return "Vandalism";
      default:
        return toString();
    }
  }
}

extension StringToCrimeCategory on String {
  CrimeCategoryEnums convertToType() {
    switch(toLowerCase()) {
      case "Violence and sexual offense":
        return CrimeCategoryEnums.kViolenceAndSexualOffense;
      case "vehicle crime":
        return CrimeCategoryEnums.kVehicleCrime;
      case "theft from the person":
        return CrimeCategoryEnums.kTheftFromThePerson;
      case "shoplifting":
        return CrimeCategoryEnums.kShoplifting;
      case "robbery":
        return CrimeCategoryEnums.kRobbery;
      case "public order":
        return CrimeCategoryEnums.kPublicOrder;
      case "possession of weapons":
        return CrimeCategoryEnums.kPossessionOfWeapons;
      case "other theft":
        return CrimeCategoryEnums.kOtherTheft;
      case "drugs":
        return CrimeCategoryEnums.kDrugs;
      case "criminal damage and arson":
        return CrimeCategoryEnums.kCriminalDamageAndArson;
      case "burglary":
        return CrimeCategoryEnums.kBurglary;
      case "bicycle theft":
        return CrimeCategoryEnums.kBicycleTheft;
      case "theft":
        return CrimeCategoryEnums.kTHEFT;
      case "assault":
        return CrimeCategoryEnums.kASSAULT;
      case "vandalism":
        return CrimeCategoryEnums.kVANDALISM;
      default:
        return CrimeCategoryEnums.kTHEFT;
    }
  }
}