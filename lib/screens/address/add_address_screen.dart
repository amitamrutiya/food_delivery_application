// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shopping_app/base/custome_appbar.dart';
import 'package:shopping_app/base/show_custom_snakbar.dart';
import 'package:shopping_app/data/controllers/auth_controller.dart';
import 'package:shopping_app/data/controllers/location_controller.dart';
import 'package:shopping_app/data/controllers/user_controller.dart';
import 'package:shopping_app/models/address_model.dart';
import 'package:shopping_app/routes/route_helper.dart';
import 'package:shopping_app/screens/address/pick_address_map.dart';
import 'package:shopping_app/utils/colors.dart';
import 'package:shopping_app/utils/dimensions.dart';
import 'package:shopping_app/widgets/app_text_field.dart';
import 'package:shopping_app/widgets/big_text.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLoagged;
  CameraPosition _cameraPosition =
      const CameraPosition(target: LatLng(22.5645, 72.9289), zoom: 15);
  LatLng _initialPostion = const LatLng(22.5645, 72.9289);

  @override
  void initState() {
    super.initState();
    _isLoagged = Get.find<AuthController>().userLoggenIn();
    if (_isLoagged && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      print("amit");
      if (Get.find<LocationController>().getUserAddressFromLocalStorage() ==
          "") {
        Get.find<LocationController>()
            .saveUserAddress(Get.find<LocationController>().addressList.last);
      }

      Get.find<LocationController>().getUserAddress();
      _cameraPosition = CameraPosition(
        target: LatLng(
          double.parse(Get.find<LocationController>().getAddress['latitude']),
          double.parse(Get.find<LocationController>().getAddress['longitude']),
        ),
      );
      _initialPostion = LatLng(
        double.parse(Get.find<LocationController>().getAddress['latitude']),
        double.parse(Get.find<LocationController>().getAddress['longitude']),
      );
    }
    print("amit2");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomerAppBar(
          title: "Address",
        ),
        body: GetBuilder<UserController>(
          builder: (userController) {
            if (userController.userModel != null &&
                _contactPersonName.text.isEmpty) {
              _contactPersonName.text = userController.userModel.name;
              _contactPersonNumber.text = userController.userModel.phone;
              if (Get.find<LocationController>().addressList.isNotEmpty) {
                _addressController.text =
                    Get.find<LocationController>().getUserAddress().address;
              }
            }
            return GetBuilder<LocationController>(
              builder: (locationController) {
                _addressController.text =
                    "${locationController.placemark.name ?? ''}"
                    "${locationController.placemark.locality ?? ''}"
                    "${locationController.placemark.postalCode ?? ''}"
                    "${locationController.placemark.country ?? ''}";
                print("address in my view is now ${_addressController.text}");
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: Dimensions.height30 * 6,
                        margin:
                            const EdgeInsets.only(left: 5, right: 5, top: 5),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 2,
                            color: AppColors.mainColor,
                          ),
                        ),
                        child: Stack(children: [
                          GoogleMap(
                            onTap: (latlang) {
                              Get.toNamed(RouteHelper.getPickAddressPage(),
                                  arguments: PickAddressMap(
                                    fromSignUp: false,
                                    fromAddress: true,
                                    googleMapController:
                                        locationController.mapController,
                                  ));
                            },
                            initialCameraPosition: CameraPosition(
                                target: _initialPostion, zoom: 15),
                            zoomControlsEnabled: false,
                            compassEnabled: false,
                            indoorViewEnabled: true,
                            mapToolbarEnabled: false,
                            myLocationEnabled: true,
                            onCameraIdle: () {
                              locationController.updatePosition(
                                  _cameraPosition, true);
                            },
                            onCameraMove: ((position) {
                              _cameraPosition = position;
                            }),
                            onMapCreated: ((GoogleMapController controller) {
                              locationController.setMapContoller(controller);
                            }),
                          ),
                        ]),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: Dimensions.width20, top: Dimensions.height20),
                        child: SizedBox(
                          height: Dimensions.height10 * 5,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  locationController.addressTypeList.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () => locationController
                                      .setAddressTypeIndex(index),
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        right: Dimensions.width10),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Dimensions.width20,
                                        vertical: Dimensions.height10),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius20 / 4),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey[200]!,
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                        )
                                      ],
                                    ),
                                    child: Icon(
                                      index == 0
                                          ? Icons.home_filled
                                          : index == 1
                                              ? Icons.work
                                              : Icons.location_on,
                                      color:
                                          locationController.addressTypeIndex ==
                                                  index
                                              ? AppColors.mainColor
                                              : Theme.of(context).disabledColor,
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                      SizedBox(height: Dimensions.height10),
                      Padding(
                          padding: EdgeInsets.only(left: Dimensions.width20),
                          child: BigText(text: "Delivery Addreess")),
                      SizedBox(height: Dimensions.height10),
                      AppTextField(
                        textController: _addressController,
                        hintText: "Your Address",
                        icon: Icons.map,
                      ),
                      SizedBox(height: Dimensions.height20),
                      Padding(
                          padding: EdgeInsets.only(left: Dimensions.width20),
                          child: BigText(text: "Contact Name")),
                      SizedBox(height: Dimensions.height10),
                      AppTextField(
                        textController: _contactPersonName,
                        hintText: "Your Name",
                        icon: Icons.person,
                      ),
                      SizedBox(height: Dimensions.height20),
                      Padding(
                          padding: EdgeInsets.only(left: Dimensions.width20),
                          child: BigText(text: "Your Number")),
                      SizedBox(height: Dimensions.height10),
                      AppTextField(
                          textController: _contactPersonNumber,
                          hintText: "Your Number",
                          icon: Icons.phone),
                    ],
                  ),
                );
              },
            );
          },
        ),
        bottomNavigationBar: GetBuilder<LocationController>(
          builder: (locationController) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: Dimensions.height20 * 7,
                  padding: EdgeInsets.only(
                    top: Dimensions.height30,
                    bottom: Dimensions.height30,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(
                        Dimensions.radius20,
                      ),
                    ),
                    color: AppColors.buttonBackgroundColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          AddressModel addressModel = AddressModel(
                            addressType: locationController.addressTypeList[
                                locationController.addressTypeIndex],
                            contactPersonName: _contactPersonName.text,
                            contactPersonNumber: _contactPersonNumber.text,
                            address: _addressController.text,
                            latitude:
                                locationController.position.latitude.toString(),
                            longitude: locationController.position.longitude
                                .toString(),
                          );
                          locationController
                              .addAddress(addressModel)
                              .then((response) {
                            if (response.isSuccess) {
                              Get.toNamed(RouteHelper.getInitial());
                              Get.snackbar("Address", "Added Successfully");
                            } else {
                              showCustomSnakBar("Couldn't save address",
                                  title: "Address");
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              top: Dimensions.height20,
                              bottom: Dimensions.height20,
                              left: Dimensions.width20,
                              right: Dimensions.width20),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              color: AppColors.mainColor),
                          child: BigText(
                            size: Dimensions.font26,
                            text: "Save Address",
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }
}
