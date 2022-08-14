import 'package:get/get.dart';
import 'package:shopping_app/data/repository/order_repo.dart';
import 'package:shopping_app/models/order_model.dart';
import 'package:shopping_app/models/place_order.dart';

class OrderController extends GetxController implements GetxService {
  OrderRepo orderRepo;
  OrderController({required this.orderRepo});
  late List<OrderModel> _currentOrderList;
  late List<OrderModel> _historyOrderList;
  bool _isLoading = false;
  List<OrderModel> get historyOrderList => _historyOrderList;
  List<OrderModel> get currentOrderList => _currentOrderList;
  bool get isLoading => _isLoading;

  int _paymentIndex = 0;
  int get paymentIndex => _paymentIndex;

  String _orderType = 'delivery';
  String get orderType => _orderType;

  String _foodNote = " ";
  String get foodNote => _foodNote;
  Future<void> placeOrder(PlaceOrderBody placeOrder, Function callback) async {
    _isLoading = true;
    Response response = await orderRepo.placeOrder(placeOrder);
    if (response.statusCode == 200) {
      _isLoading = false;
      String message = response.body['message'];
      String orderID = response.body['order_id'].toString();
      callback(true, message, orderID);
    } else {
      callback(false, response.statusText!, '-1');
    }
  }

  Future<void> getOrderList() async {
    _isLoading = true;
    Response response = await orderRepo.getOrderList();
    if (response.statusCode == 200) {
      _historyOrderList = [];
      _currentOrderList = [];
      response.body.forEach((order) {
        OrderModel orderModel = OrderModel.fromJson(order);
        if (orderModel.orderStatus == 'panding' ||
            orderModel.orderStatus == 'accepted' ||
            orderModel.orderStatus == 'processing' ||
            orderModel.orderStatus == 'handover') {
          _currentOrderList.add(orderModel);
        } else {
          _historyOrderList.add(orderModel);
        }
      });
    } else {
      _historyOrderList = [];
      _currentOrderList = [];
    }
    _isLoading = false;
    update();
  }

  void setPaymentIndex(int index) {
    _paymentIndex = index;
    update();
  }

  void setDeliveryType(String type) {
    _orderType = type;
    update();
  }

  void setFoodNote(String note) {
    _foodNote = note;
  }
}
