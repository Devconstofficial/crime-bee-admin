import 'package:crime_bee_admin/utils/app_strings.dart';
import 'package:crime_bee_admin/utils/session_management/session_management.dart';
import 'package:crime_bee_admin/utils/session_management/session_token_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../view/models/crime_category_model.dart';
import '../view/models/postion_model.dart';
import 'crime_category_enums.dart';

class CommonCode {
  static final List<CrimeCategoryModel> crimeCategories = <CrimeCategoryModel>[
    CrimeCategoryModel.init(
      name: "Bicycle theft",
      assetsAddress: "assets/crime_icon/bicycle-theft-icon.png",
      crimeType: CrimeCategoryEnums.kBicycleTheft,
    ),
    CrimeCategoryModel.init(
      name: "Burglary",
      assetsAddress: "assets/crime_icon/burglary-icon.png",
      crimeType: CrimeCategoryEnums.kBurglary,
    ),
    CrimeCategoryModel.init(
      name: "Criminal damage and arson",
      assetsAddress: "assets/crime_icon/criminal-icon.png",
      crimeType: CrimeCategoryEnums.kCriminalDamageAndArson,
    ),
    CrimeCategoryModel.init(
      name: "Drugs",
      assetsAddress: "assets/crime_icon/drags-icon.png",
      crimeType: CrimeCategoryEnums.kDrugs,
    ),
    CrimeCategoryModel.init(
      name: "Other theft",
      assetsAddress: "assets/crime_icon/other-crime-icon.png",
      crimeType: CrimeCategoryEnums.kOtherTheft,
    ),
    CrimeCategoryModel.init(
      name: "Possession of weapons",
      assetsAddress: "assets/crime_icon/weapon-icon.png",
      crimeType: CrimeCategoryEnums.kPossessionOfWeapons,
    ),
    CrimeCategoryModel.init(
      name: "Public order",
      assetsAddress: "assets/crime_icon/public-order-icon.png",
      crimeType: CrimeCategoryEnums.kPublicOrder,
    ),
    CrimeCategoryModel.init(
      name: "Robbery",
      assetsAddress: "assets/crime_icon/robbery-icon.png",
      crimeType: CrimeCategoryEnums.kRobbery,
    ),
    CrimeCategoryModel.init(
      name: "Shoplifting",
      assetsAddress: "assets/crime_icon/shoplifting-icon.png",
      crimeType: CrimeCategoryEnums.kShoplifting,
    ),
    CrimeCategoryModel.init(
      name: "Theft from the person",
      assetsAddress: "assets/crime_icon/theft-icon.png",
      crimeType: CrimeCategoryEnums.kTheftFromThePerson,
    ),
    CrimeCategoryModel.init(
      name: "Vehicle crime",
      assetsAddress: "assets/crime_icon/vehicle-crime-icon.png",
      crimeType: CrimeCategoryEnums.kVehicleCrime,
    ),
    CrimeCategoryModel.init(
      name: "Violence and sexual offense",
      assetsAddress: "assets/crime_icon/sexual-abuse-icon.png",
      crimeType: CrimeCategoryEnums.kViolenceAndSexualOffense,
    ),
  ];

  static void unFocus(BuildContext context) {
    FocusManager.instance.primaryFocus!.unfocus();
  }

  static Future<void> logout() async {
    Get.offNamedUntil(kLoginScreenRoute, (predicate)=>false);
    SessionManagement sessionManagement= SessionManagement();
    await sessionManagement.removeSession(token: SessionTokenKeys.kUserModelKey,);
    await sessionManagement.removeSession(token: SessionTokenKeys.kIsRememberMeKey,);
    await sessionManagement.removeSession(token: SessionTokenKeys.kUserTokenKey,);
    await sessionManagement.removeSession(token: SessionTokenKeys.kUserDataKey,);
  }

  static Future<BitmapDescriptor> loadPngFromAsset(String assetPath) async {
    ByteData data = await rootBundle.load(assetPath);
    Uint8List bytes = data.buffer.asUint8List();
    return BitmapDescriptor.bytes(bytes,height: 50.h,);
  }

  static Future<BitmapDescriptor> loadPin(CrimeCategoryEnums type) async {
    switch(type) {
      case CrimeCategoryEnums.kViolenceAndSexualOffense:
        return await CommonCode.loadPngFromAsset("assets/crime_icon/sexual-abuse-icon.png",);
      case CrimeCategoryEnums.kVehicleCrime:
        return await CommonCode.loadPngFromAsset("assets/crime_icon/vehicle-crime-icon.png",);
      case CrimeCategoryEnums.kTheftFromThePerson:
        return await CommonCode.loadPngFromAsset("assets/crime_icon/theft-icon.png",);
      case CrimeCategoryEnums.kShoplifting:
        return await CommonCode.loadPngFromAsset("assets/crime_icon/shoplifting-icon.png",);
      case CrimeCategoryEnums.kRobbery:
        return await CommonCode.loadPngFromAsset("assets/crime_icon/robbery-icon.png",);
      case CrimeCategoryEnums.kPossessionOfWeapons:
        return await CommonCode.loadPngFromAsset("assets/crime_icon/weapon-icon.png");
      case CrimeCategoryEnums.kPublicOrder:
        return await CommonCode.loadPngFromAsset("assets/crime_icon/public-order-icon.png");
      case CrimeCategoryEnums.kOtherTheft:
        return await CommonCode.loadPngFromAsset("assets/crime_icon/other-crime-icon.png");
      case CrimeCategoryEnums.kDrugs:
        return await CommonCode.loadPngFromAsset("assets/crime_icon/drags-icon.png");
      case CrimeCategoryEnums.kCriminalDamageAndArson:
        return await CommonCode.loadPngFromAsset("assets/crime_icon/criminal-icon.png");
      case CrimeCategoryEnums.kBicycleTheft:
        return await CommonCode.loadPngFromAsset("assets/crime_icon/bicycle-theft-icon.png");
      case CrimeCategoryEnums.kBurglary:
        return await CommonCode.loadPngFromAsset("assets/crime_icon/burglary-icon.png");
      case CrimeCategoryEnums.kTHEFT:
        return await CommonCode.loadPngFromAsset("assets/icons/map-theft-pin.png");
      case CrimeCategoryEnums.kASSAULT:
        return await CommonCode.loadPngFromAsset("assets/icons/map-assault-pin.png");
      case CrimeCategoryEnums.kVANDALISM:
        return await CommonCode.loadPngFromAsset("assets/icons/map-vandalism-pin.png");
      default:
        return await CommonCode.loadPngFromAsset("assets/icons/map-theft-pin.png");
    }
  }

  static String getCategoryAssetsPath(CrimeCategoryEnums type) {
    switch(type) {
      case CrimeCategoryEnums.kViolenceAndSexualOffense:
        return "assets/crime_icon/sexual-abuse-icon.png";
      case CrimeCategoryEnums.kVehicleCrime:
        return "assets/crime_icon/vehicle-crime-icon.png";
      case CrimeCategoryEnums.kTheftFromThePerson:
        return "assets/crime_icon/theft-icon.png";
      case CrimeCategoryEnums.kShoplifting:
        return "assets/crime_icon/shoplifting-icon.png";
      case CrimeCategoryEnums.kRobbery:
        return "assets/crime_icon/robbery-icon.png";
      case CrimeCategoryEnums.kPossessionOfWeapons:
        return "assets/crime_icon/weapon-icon.png";
      case CrimeCategoryEnums.kPublicOrder:
        return "assets/crime_icon/public-order-icon.png";
      case CrimeCategoryEnums.kOtherTheft:
        return "assets/crime_icon/other-crime-icon.png";
      case CrimeCategoryEnums.kDrugs:
        return "assets/crime_icon/drags-icon.png";
      case CrimeCategoryEnums.kCriminalDamageAndArson:
        return  "assets/crime_icon/criminal-icon.png";
      case CrimeCategoryEnums.kBicycleTheft:
        return "assets/crime_icon/bicycle-theft-icon.png";
      case CrimeCategoryEnums.kBurglary:
        return "assets/crime_icon/burglary-icon.png";
      case CrimeCategoryEnums.kTHEFT:
        return "assets/icons/map-theft-pin.png";
      case CrimeCategoryEnums.kASSAULT:
        return "assets/icons/map-assault-pin.png";
      case CrimeCategoryEnums.kVANDALISM:
        return "assets/icons/map-vandalism-pin.png";
      default:
        return "assets/icons/map-theft-pin.png";
    }
  }

  static Future<PositionModel?> getCurrentPositiion() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint("Location services are disabled.");
      return null;
    }

    // Check and request permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint("Location permission denied.");
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint("Location permission denied forever. Cannot request permissions.");
      return null;
    }
    Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        )
    );
    return PositionModel.empty()
      ..lng = position.longitude
      ..lat = position.latitude;
  }
}
