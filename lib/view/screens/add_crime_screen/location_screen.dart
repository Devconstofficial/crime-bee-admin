import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import 'controller/location_controller.dart';

class LocationPickerScreen extends GetView<LocationPickerController> {
  const LocationPickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller.searchController,
              decoration: InputDecoration(
                hintText: 'Search location',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    controller.searchLocation(controller.searchController.text);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Obx(() {
                  if (!controller.isLocationLoaded.value) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: controller.currentLocation,
                      zoom: 14,
                    ),
                    onMapCreated: (GoogleMapController mapController) {
                      controller.mapController.complete(mapController);
                    },
                    onCameraMove: controller.onMapCameraMove,
                    onCameraIdle: controller.onMapCameraIdle,
                    markers: Set<Marker>.of(controller.markers), 
                    onTap: controller.onMapTap,
                  );
                }),
                Obx(() {
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 90),
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(16)
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          controller.isLoadingAddress.value
                              ? const CircularProgressIndicator()
                              : Text(controller.selectedAddress.value.isNotEmpty
                                  ? controller.selectedAddress.value
                                  : "Select a location", style: AppStyles.workSansTextStyle().copyWith(color: kWhiteColor,),),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: controller.pickLocation,
                            child: Text('Pick Location'),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
