import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'add_crime_controller.dart';

class LocationPickerController extends GetxController {
  final searchController = TextEditingController();
  final selectedAddress = ''.obs;
  final isLocationLoaded = false.obs;
  final isLoadingAddress = false.obs;
  LatLng currentLocation = LatLng(37.4219983, -122.084);
  final mapController = Completer<GoogleMapController>();
  MarkerId markerId = MarkerId("currentLocation");
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

  // Future<void> _getCurrentLocation() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   double? longitude = prefs.getDouble('longitude');
  //   double? latitude = prefs.getDouble('latitude');
  //
  //   if (longitude != null && latitude != null) {
  //     currentLocation = LatLng(latitude, longitude);
  //   } else {
  //     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //     currentLocation = LatLng(position.latitude, position.longitude);
  //   }
  //
  //   await _getAddressFromLatLng(currentLocation);
  //   isLocationLoaded.value = true;
  //
  //   _updateMarker(currentLocation);
  // }

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

    // Fetch stored location if available
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? longitude = prefs.getDouble('longitude');
    double? latitude = prefs.getDouble('latitude');

    // Use stored location or fetch a new one
    if (longitude != null && latitude != null) {
      currentLocation = LatLng(latitude, longitude);
    } else {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      currentLocation = LatLng(position.latitude, position.longitude);
    }

    await _getAddressFromLatLng(currentLocation);
    isLocationLoaded.value = true;

    _updateMarker(currentLocation);
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    isLoadingAddress.value = true;
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      isLoadingAddress.value = false;

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        selectedAddress.value = "${place.street}, ${place.locality}, ${place.country}";
      } else {
        selectedAddress.value = "No address available for this location.";
      }
    } catch (e) {
      isLoadingAddress.value = false;
      selectedAddress.value = "Failed to fetch address. Error: $e";
      debugPrint("Error in _getAddressFromLatLng: $e");
    }
  }

  void searchLocation(String query) async {
    try {
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        LatLng position = LatLng(locations[0].latitude, locations[0].longitude);
        updateLocationFromSearch(position);
      }
    } catch (e) {
      print("Error in searchLocation: $e");
    }
  }

  void updateLocationFromSearch(LatLng position) async {
    currentLocation = position;
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(
      CameraUpdate.newLatLngZoom(currentLocation, 14),
    );
    await _getAddressFromLatLng(currentLocation); 
    _updateMarker(currentLocation); 
  }

  void onMapCameraMove(CameraPosition cameraPosition) {
    currentLocation = cameraPosition.target;
  }

  Future<void> onMapCameraIdle() async {
    await _getAddressFromLatLng(currentLocation);
    _updateMarker(currentLocation);
  }

  void onMarkerDragEnd(LatLng position) async {
    currentLocation = position;
    await _getAddressFromLatLng(currentLocation); 
    _updateMarker(currentLocation);
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
    Get.find<AddCrimeController>().pickLocation.value = selectedAddress.value;
    Get.back();
  }

}
