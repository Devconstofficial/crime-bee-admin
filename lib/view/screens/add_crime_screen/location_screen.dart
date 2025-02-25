import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import 'controller/location_controller.dart';

class LocationPickerScreen extends GetView<LocationPickerController> {
  const LocationPickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (canPop,result) {

      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Pick Location',
            style: AppStyles.headingTextStyle(),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Obx(() {
                    if (!controller.isLocationLoaded.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: controller.currentLocation!,
                        zoom: 14,
                      ),
                      onMapCreated: (GoogleMapController mapController) {
                        controller.mapController = mapController;
                      },
                      onCameraMove: controller.onMapCameraMove,
                      onCameraIdle: controller.onMapCameraIdle,
                      markers: Set<Marker>.of(controller.markers),
                      onTap: controller.onMapTap,
                    );
                  }),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0.w,
                      vertical: 20.h,
                    ),
                    child: TextField(
                      controller: controller.searchController,
                      decoration: InputDecoration(
                        hintText: 'Search location',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 15.w,
                          vertical: 5.h,
                        ),
                        fillColor: kWhiteColor,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            controller.searchLocation(controller.searchController.text);
                          },
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 50.h),
                      padding: EdgeInsets.all(16.0.sp),
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Obx(() {
                            if (controller.isLoadingAddress.value) {
                              return const CircularProgressIndicator();
                            }
                            return Text(
                              controller.selectedAddress.value.isNotEmpty
                                  ? controller.selectedAddress.value
                                  : "Select a location",
                              style: AppStyles.workSansTextStyle().copyWith(
                                color: kWhiteColor,
                              ),
                            );
                          }),
                          Padding(
                            padding: EdgeInsets.only(top: 10.0.h),
                            child: ElevatedButton(
                              onPressed: controller.pickLocation,
                              child: const Text(
                                'Pick Location',
                                style: TextStyle(
                                  color: kBlackColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
