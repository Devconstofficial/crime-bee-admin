
import 'package:crime_bee_admin/view/models/rated_by_model.dart';

class UserModel {
  String userId = "";
  String email = "";
  String name = "";
  String vigilanteName = "";
  String phoneNumber = "";
  String profilePic = "";
  String password = "";
  String status = "";
  String createdAt = "";
  double rating = 0.0;
  int vigilantePoints = 0;
  int totalPage = 0;
  int currentPage = 0;
  bool isAnonymousMode = false;
  bool isPaidUser = false;
  bool isPaymentMethodSetup = false;
  List<String> roles = [];
  List<RatedByModel> ratedBy = <RatedByModel>[];
  List<String> notificationId = [];

  UserModel.empty();

  UserModel.fromJson(Map<String,dynamic> json) {
    userId = json["_id"] ?? json["id"] ?? userId;
    email = json["email"] ?? email;
    name = json["name"] ?? name;
    rating = double.parse("${json["rating"] ?? rating}");
    vigilantePoints = int.parse("${json["vigilantePoints"] ?? vigilantePoints}");
    vigilanteName = json["vigilanteName"] ?? vigilanteName;
    profilePic = json["profilePicUrl"] ?? profilePic;
    phoneNumber = json["phoneNumber"] ?? phoneNumber;
    status = json["status"] ?? status;
    createdAt = json["createdAt"] ?? createdAt;
    isAnonymousMode = json["anonymousMode"] ?? isAnonymousMode;
    isPaidUser = json["paidUser"] ?? isPaidUser;
    isPaymentMethodSetup = json["paymentMethodSetuped"] ?? isPaymentMethodSetup;
    if(json["roles"] is List) {
      for(var result in json["roles"]) {
        roles.add(result);
      }
    }
    if(json["ratedBy"] is List) {
      for(var result in json["ratedBy"]) {
        ratedBy.add(RatedByModel.fromJson(result));
      }
    }
    if(json["notificationIds"] is List) {
      for(var result in json["notificationIds"]) {
        roles.add(result);
      }
    }
  }

  Map<String,dynamic> toSignUpJson() {
    return {
      'name' : name,
      'email' : email,
      'phoneNumber' : phoneNumber,
      'password' : password,
    };
  }

  Map<String,dynamic> toUpdateUserJson() {
    return {
      'name' : name,
      'email' : email,
      'phoneNumber' : phoneNumber,
      'vigilanteName' : vigilanteName,
      'anonymousMode' : isAnonymousMode,
      if(profilePic.isNotEmpty)'profilePicUrl' : profilePic,
    };
  }

  @override
  String toString() {
    return 'UserModel{userId: $userId, email: $email, name: $name, vigilanteName: $vigilanteName, phoneNumber: $phoneNumber, profilePic: $profilePic, password: $password, status: $status, createdAt: $createdAt, rating: $rating, vigilantePoints: $vigilantePoints, totalPage: $totalPage, currentPage: $currentPage, isAnonymousMode: $isAnonymousMode, isPaidUser: $isPaidUser, isPaymentMethodSetup: $isPaymentMethodSetup, roles: $roles, ratedBy: $ratedBy, notificationId: $notificationId}';
  }
}