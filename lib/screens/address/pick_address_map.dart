import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shopping_app/base/cutom_button.dart';
import 'package:shopping_app/data/controllers/location_controller.dart';
import 'package:shopping_app/routes/route_helper.dart';
import 'package:shopping_app/screens/address/widgets/search_location_dialogue_page.dart';
import 'package:shopping_app/utils/colors.dart';
import 'package:shopping_app/utils/dimensions.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignUp;
  final bool fromAddress;
  final GoogleMapController? googleMapController;
  const PickAddressMap(
      {Key? key,
      required this.fromSignUp,
      required this.fromAddress,
      this.googleMapController})
      : super(key: key);

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initalPostion;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Get.find<LocationController>().addressList.isEmpty) {
      _initalPostion = const LatLng(22.5645, 72.9289);
      _cameraPosition = CameraPosition(target: _initalPostion, zoom: 15);
    } else {
      _initalPostion = LatLng(
        double.parse(Get.find<LocationController>().getAddress['latitude']),
        double.parse(Get.find<LocationController>().getAddress['longitude']),
      );
      _cameraPosition = CameraPosition(target: _initalPostion, zoom: 15);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      builder: (locationController) {
        return Scaffold(
          body: SafeArea(
              child: Center(
            child: SizedBox(
              width: double.infinity,
              child: Stack(children: [
                GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: _initalPostion, zoom: 15),
                  zoomControlsEnabled: false,
                  onCameraMove: (CameraPosition cameraPosition) {
                    _cameraPosition = cameraPosition;
                  },
                  onCameraIdle: () {
                    locationController.updatePosition(_cameraPosition, false);
                  },
                  onMapCreated: (GoogleMapController mapContoller) {
                    _mapController = mapContoller;
                  },
                ),
                Center(
                  child: !locationController.loading
                      ? Image.asset(
                          "assets/images/pick_marker.png",
                          height: Dimensions.height10 * 6,
                          width: Dimensions.width10 * 6,
                        )
                      : const CircularProgressIndicator(
                          color: AppColors.mainColor),
                ),
                //showing and selecting address
                Positioned(
                  top: Dimensions.height45,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  child: InkWell(
                    onTap: () => Get.dialog(
                        LocationDialogue(mapController: _mapController)),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: Dimensions.width10),
                      height: Dimensions.height10 * 5,
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20 / 2),
                      ),
                      child: Row(children: [
                        const Icon(
                          Icons.location_on,
                          size: 25,
                          color: AppColors.yellowColor,
                        ),
                        SizedBox(width: Dimensions.width10 / 2),
                        Expanded(
                          child: Text(
                            locationController.pickPlacemart.name ?? "",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimensions.font16),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: Dimensions.width10),
                        const Icon(Icons.search,
                            size: 25, color: AppColors.yellowColor)
                      ]),
                    ),
                  ),
                ),
                Positioned(
                  bottom: Dimensions.height20 * 4,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  child: locationController.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.mainColor,
                          ),
                        )
                      : CustomButton(
                          buttonText: locationController.inZone
                              ? widget.fromAddress
                                  ? "Pick Address"
                                  : "Pick Location"
                              : "Service is not avilable in your area",
                          onPressed: locationController.loading ||
                                  locationController.buttonDisabled
                              ? null
                              : () {
                                  if (locationController
                                              .pickPosition.latitude !=
                                          0 &&
                                      locationController.pickPlacemart.name !=
                                          null) {
                                    if (widget.fromAddress) {
                                      if (widget.googleMapController != null) {
                                        print("Now you can cllicked on this");
                                        widget.googleMapController!.moveCamera(
                                          CameraUpdate.newCameraPosition(
                                            CameraPosition(
                                              target: LatLng(
                                                locationController
                                                    .pickPosition.latitude,
                                                locationController
                                                    .pickPosition.longitude,
                                              ),
                                            ),
                                          ),
                                        );
                                        locationController.setAddAddressData();
                                      }
                                      Get.toNamed(RouteHelper.getAddressPage());
                                    }
                                  }
                                },
                        ),
                )
              ]),
            ),
          )),
        );
      },
    );
  }
}
