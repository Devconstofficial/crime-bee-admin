import 'package:crime_bee_admin/utils/crime_category_enums.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../models/crime_model.dart';

class CustomHotspotMapWidget extends StatelessWidget {
  final CrimeModel hotSpotModel;
  final Function(GoogleMapController)? onMapCreated;
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;

  const CustomHotspotMapWidget({
    super.key,
    required this.hotSpotModel,
    this.onMapCreated,
    this.padding,
    this.width,
    this.height,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.only(right: 20.w),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: height ?? 406.h,
          decoration: BoxDecoration(
            borderRadius: AppStyles.customBorderAll,
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: AppStyles.customBorderAll,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(hotSpotModel.locationModel.lat, hotSpotModel.locationModel.lng),
                    zoom: 14.0,
                  ),
                  myLocationButtonEnabled: false,
                  zoomGesturesEnabled: false,
                  scrollGesturesEnabled: false,
                  onTap: (latLng) {
                    if(onTap!=null) {
                      onTap!();
                    }
                  },
                  circles: {
                    Circle(
                      circleId: const CircleId("theft-circle"),
                      center: LatLng(hotSpotModel.locationModel.lat, hotSpotModel.locationModel.lng,),
                      strokeWidth: 2,
                      strokeColor: kPrimaryColor.withOpacity(0.5),
                      fillColor: kPrimaryColor.withOpacity(0.2),
                      radius: 300,
                    ),
                  },
                  markers: {
                    Marker(
                      markerId: MarkerId(hotSpotModel.description),
                      position: LatLng(hotSpotModel.locationModel.lat, hotSpotModel.locationModel.lng,),
                      icon: hotSpotModel.pinIcon ?? BitmapDescriptor.defaultMarker,
                    ),
                  },
                  zoomControlsEnabled: false,
                  buildingsEnabled: true,
                  onMapCreated: onMapCreated,
                ),
              ),
              SizedBox(
                height: height ?? 400.h,
                child: Padding(
                  padding: EdgeInsets.all(26.sp),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: kDarkGrey.withOpacity(0.4),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 16.w,
                            right: 16.w,
                            bottom: 16.h,
                            top: 11.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                hotSpotModel.crimeType.convertToString(),
                                style: AppStyles.robotoTextStyle().copyWith(
                                  color: kWhiteColor,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on_outlined),
                                      SizedBox(
                                        width: 12.w,
                                      ),
                                      Text(
                                        hotSpotModel.locationModel.type,
                                        style: AppStyles.robotoTextStyle()
                                            .copyWith(
                                          color: kWhiteColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
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
      ),
    );
  }
}
