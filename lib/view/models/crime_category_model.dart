
import '../../utils/crime_category_enums.dart';

class CrimeCategoryModel {
  String name = '';
  String assetsAddress = '';
  CrimeCategoryEnums crimeType = CrimeCategoryEnums.kTHEFT;

  CrimeCategoryModel.init({
    this.name = "",
    this.assetsAddress = "",
    this.crimeType =CrimeCategoryEnums.kBicycleTheft,
  });

  @override
  String toString() {
    return 'CrimeCategoryModel{name: $name, assetsAddress: $assetsAddress, crimeType: $crimeType}';
  }
}
