import 'dart:convert';
import 'dart:developer';

import 'package:crime_bee_admin/view/models/terms_model.dart';
import 'package:crime_bee_admin/web_services/terms_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';

import '../../../../utils/app_colors.dart';

class TermsController extends GetxController{
  final TermsService _termsService = TermsService();
  final QuillController quillController = QuillController.basic();
  final QuillController readOnlyQuillController = QuillController.basic();
  RxInt selectedIndex = 0.obs;
  RxList notifications = [].obs;
  RxList activities = [].obs;
  RxBool isEditing = false.obs,
      hasText = false.obs,
      isLoading = false.obs,
      enabledDiscardChange = false.obs,
      enabledUpdate = false.obs,
      isNotificationVisible = false.obs;
  RxString termsText = ''.obs;
  String tempText="";
  TermsModel selectedTermModel = TermsModel.empty();

  // Method to toggle the editing state
  void toggleEditing() {
    isEditing.toggle();
    if(isEditing.value) {
      tempText=termsText.value;
      quillController.document = Document.fromJson(jsonDecode(termsText.value));
    } else {
      tempText = "";
    }
  }

  void onChangeIndex(int index) {
    if(isLoading.value)return;
    if(isEditing.value)return;
    selectedIndex.value = index;
    getPolicies();
  }

  void getPolicies() async {
    if(isLoading.value) return;
    isLoading.value=true;
    var result = selectedIndex.value == 0
        ? await _termsService.getPrivacyPolices()
        : selectedIndex.value == 1
            ? await _termsService.getCookieService()
            : await _termsService.getTermAndService();
    isLoading.value = false;
    if(result is TermsModel) {
      selectedTermModel = result;
      termsText.value = result.text;
      Document document = Document.fromJson(jsonDecode(termsText.value,),);
      readOnlyQuillController.document = document;
      readOnlyQuillController.readOnly = true;
    } else {
      Get.snackbar(
        "Error",
        result.toString(),
        colorText: kWhiteColor,
        backgroundColor: kPrimaryColor,
      );
    }
  }

  void setPolicies() async {
    if(isLoading.value) return;
    String text = jsonEncode(quillController.document.toDelta().toJson());
    Get.dialog(const Center(child: CircularProgressIndicator(),),);
    var result = selectedIndex.value == 0
        ? await _termsService.setPrivacyPolices(text: text)
        : selectedIndex.value == 1
            ? await _termsService.setCookieService(text: text)
            : await _termsService.setTermAndService(text: text);
    Get.back();
    if(result is TermsModel) {
      selectedTermModel = result;
      termsText.value = result.text;
      Document document = Document.fromJson(jsonDecode(termsText.value));
      readOnlyQuillController.document = document;
      readOnlyQuillController.readOnly = true;
      toggleEditing();
    } else {
      Get.snackbar(
        "Error",
        result.toString(),
        colorText: kWhiteColor,
        backgroundColor: kPrimaryColor,
      );
    }
  }

  void fetchNotifications() {
    notifications.addAll([
      {'title': 'New Host registered', 'time': '59 minutes ago', "backColor" : kPrimaryColor,},
      {'title': 'New Crime Reported', 'time': '1 hour ago',"backColor" : kOrangeColor,},
      {'title': 'Crime Resolved', 'time': '2 hours ago',"backColor" : kLightBlue,},
      {'title': 'Update on your case', 'time': '3 hours ago',"backColor" : kGrey,},
    ]);
  }

  void fetchActivities() {
    activities.addAll([
      {'title': 'Ahmad just cancelled his...', 'time': 'Just now',"backColor" : kPrimaryColor,},
      {'title': 'John updated the crime report...', 'time': '5 minutes ago',"backColor" : kOrangeColor,},
      {'title': 'Jane resolved a case', 'time': '10 minutes ago',"backColor" : kLightBlue,},
      {'title': 'System generated report', 'time': '1 hour ago',"backColor" : kGrey,},
    ]);
  }

  @override
  onInit(){
    super.onInit();
    getPolicies();
    fetchNotifications();
    fetchActivities();
    quillController.addListener(() {
      tempText = quillController.document.toDelta().toJson().first["insert"].toString().replaceAll('\n', "");
      log("===========>$tempText");
      enabledUpdate.value = tempText.isNotEmpty && termsText.value!=tempText;
      enabledDiscardChange.value = tempText.isNotEmpty && termsText.value!=tempText;
    });
  }

  @override
  void dispose() {
    quillController.removeListener((){});
    quillController.dispose();
    super.dispose();
  }

}