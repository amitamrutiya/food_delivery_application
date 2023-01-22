import 'package:flutter/material.dart';
import 'package:shopping_app/data/controllers/cart_controller.dart';
import 'package:shopping_app/data/repository/popular_product_repo.dart';
import 'package:shopping_app/models/cart_model.dart';
import 'package:shopping_app/models/popular_product.dart';
import 'package:shopping_app/utils/colors.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      Connection:
      "Keep-Alive";
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      if ((_inCartItems + _quantity) < 20) {
        _quantity++;
      } else {
        Get.snackbar("Item count", "You can't add more !",
            backgroundColor: AppColors.mainColor, colorText: Colors.white);
      }
    } else {
      if ((_inCartItems + _quantity) > 0) {
        _quantity--;
      } else {
        Get.snackbar("Item count", "You can't reduce more !",
            backgroundColor: AppColors.mainColor, colorText: Colors.white);
        if (_inCartItems > 0) {
          _quantity = _inCartItems;
        }
      }
    }
    update();
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);
    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }

    //if exist
    //get from storage _inCartitems
  }

  void addItem(ProductModel product) {
    _cart.addItem(product, _quantity);
    // if (_quantity > 0) {
    // _quantity = 0;
    // _inCartItems = _cart.getQuantity(product);
    update();
    // } else {

    // }
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
