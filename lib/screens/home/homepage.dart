import 'package:flutter/material.dart';
import 'package:shopping_app/screens/account/account_screen.dart';
import 'package:shopping_app/screens/cart/cart_history.dart';
import 'package:shopping_app/screens/home/main_food_page.dart';
import 'package:shopping_app/screens/order/order_page.dart';
import 'package:shopping_app/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List pages = [
    const MainFoodPage(),
    OrderPage(),
    const CartHistory(),
    const AccountScreen(),
  ];

  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColors.mainColor,
          unselectedItemColor: Colors.amberAccent,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          currentIndex: _selectedIndex,
          onTap: onTapNav,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'home'),
            BottomNavigationBarItem(icon: Icon(Icons.history), label: 'order'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_checkout), label: 'cart'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ]),
    );
  }
}
