import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/base/custome_appbar.dart';
import 'package:shopping_app/data/controllers/auth_controller.dart';
import 'package:shopping_app/data/controllers/order_controller.dart';
import 'package:shopping_app/helper/dependencies.dart';
import 'package:shopping_app/screens/order/view_order.dart';
import 'package:shopping_app/utils/colors.dart';
import 'package:shopping_app/utils/dimensions.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  late TabController _tabController;
  late bool _isLoggedIn;

  @override
  void initState() {
    super.initState();
    _isLoggedIn = Get.find<AuthController>().userLoggenIn();
    if (_isLoggedIn) {
      _tabController = TabController(length: 2, vsync: this);
      Get.find<OrderController>().getOrderList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomerAppBar(
        title: "My order",
        backButtonExist: false,
      ),
      body: Column(
        children: [
          SizedBox(
            width: Dimensions.screenWidth,
            child: TabBar(
              indicatorColor: Theme.of(context).primaryColor,
              labelColor: Theme.of(context).primaryColor,
              indicatorWeight: 4,
              unselectedLabelColor: Theme.of(context).disabledColor,
              controller: _tabController,
              tabs: const [
                Tab(text: "Current"),
                Tab(text: "History"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: const [
              ViewOrder(isCurrect: true),
              ViewOrder(isCurrect: false),
            ]),
          )
        ],
      ),
    );
  }
}
