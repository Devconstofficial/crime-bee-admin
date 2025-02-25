import 'dart:async';
import 'package:crime_bee_admin/web_services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../models/get_location_model.dart';

class LocationPickerController extends GetxController {
  final LocationService _locationService = LocationService();
  final searchController = TextEditingController();
  GoogleMapController? mapController;
  RxString selectedAddress = ''.obs;
  RxBool isLocationLoaded = false.obs,isLoadingAddress = false.obs;
  LatLng? currentLocation;
  MarkerId markerId = const MarkerId("currentLocation");
  RxSet<Marker> markers = <Marker>{}.obs;

  @override
  void onInit() async {
    super.onInit();
    await _getCurrentLocation();
    searchController.addListener(() {
      if (searchController.text.isNotEmpty) {
        searchLocation(searchController.text);
      }
    });
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint("Location services are disabled.");
      return;
    }

    // Check and request permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint("Location permission denied.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint("Location permission denied forever. Cannot request permissions.");
      return;
    }
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );
    currentLocation = LatLng(position.latitude, position.longitude);
    await _getAddressFromLatLng(currentLocation!);
    isLocationLoaded.value = true;

    _updateMarker(currentLocation!);
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    isLoadingAddress.value = true;
    String placeMarks = await _locationService.getPlaceUsingLATLNG(
      lat: position.latitude,
      lng: position.longitude,
    );
    isLoadingAddress.value = false;

    if (placeMarks.isNotEmpty && placeMarks.startsWith("Success:")) {
      selectedAddress.value = placeMarks.substring(8);
    } else {
      selectedAddress.value = "Address not found";
    }
  }

  void searchLocation(String query) async {
    try {
      LatLng position = await _locationService.searchPlaceApi(
        address: query,
      );
      updateLocationFromSearch(position);
    } catch (e) {
      print("Error in searchLocation: $e");
    }
  }

  void updateLocationFromSearch(LatLng position) async {
    if(mapController==null) return;
    currentLocation = position;
    mapController!.animateCamera(
      CameraUpdate.newLatLngZoom(currentLocation!, 14),
    );
    await _getAddressFromLatLng(currentLocation!);
    _updateMarker(currentLocation!);
  }

  void onMapCameraMove(CameraPosition cameraPosition) {
    currentLocation = cameraPosition.target;
  }

  Future<void> onMapCameraIdle() async {
    if(currentLocation==null) {
      return;
    }
    await _getAddressFromLatLng(currentLocation!);
    _updateMarker(currentLocation!);
  }

  void onMarkerDragEnd(LatLng position) async {
    currentLocation = position;
    await _getAddressFromLatLng(currentLocation!);
    _updateMarker(currentLocation!);
  }

  void onMapTap(LatLng position) async {
    currentLocation = position;
    await _getAddressFromLatLng(position);
    _updateMarker(position);
  }

  void _updateMarker(LatLng newPosition) {
    markers.clear();
    markers.add(Marker(
      markerId: markerId,
      position: newPosition,
      draggable: true,
      onDragEnd: onMarkerDragEnd,
    ));
  }

  void pickLocation() {
    if(currentLocation==null) {
      return;
    }
    GetLocationModel locationModel = GetLocationModel.empty();
    locationModel.lat = currentLocation!.latitude;
    locationModel.lng = currentLocation!.longitude;
    locationModel.location = selectedAddress.value;
    Get.back(result: locationModel,);
  }

}
