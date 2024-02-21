import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manadeeb/presentation/resources/styles_manager.dart';
import 'package:manadeeb/presentation/screens/add_order/widgets/add_order_screen.dart';
import 'package:manadeeb/presentation/screens/home/current_orders/widgets/current_orders_screen.dart';
import 'package:manadeeb/presentation/screens/home/delivered_orders/widgets/delivered_orders_screen.dart';
import 'package:manadeeb/presentation/screens/home/new_orders/widgets/new_orders_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../core/check_version.dart';
import '../resources/color_manager.dart';
import '../resources/constants_manager.dart';
import '../resources/strings_manager.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    try {
      versionCheck(context);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  List<Widget> _buildScreens() {
    return [
      const Padding(
        padding: EdgeInsets.only(bottom: 18.0),
        child: NewOrdersScreen(),
      ),
      const Padding(
        padding: EdgeInsets.only(bottom: 18.0),
        child: CurrentOrderScreen(),
      ),
      const Padding(
        padding: EdgeInsets.only(bottom: 18.0),
        child: DeliveredOrdersScreen(),
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        onPressed: (BuildContext? context) {
          setState(() {
            _selectedIndex = 0;
            _controller.index = 0;
          });
        },
        icon: Text(AppStrings.bottomBarNewOrders, style: getLargeStyle(color: _selectedIndex == 0 ? ColorManager.secondary : ColorManager.grey),),
        activeColorPrimary: ColorManager.white,
      ),
      PersistentBottomNavBarItem(
        onPressed: (BuildContext? context) {
          setState(() {
            _selectedIndex = 1;
            _controller.index = 1;
          });
        },
        icon: Text(AppStrings.bottomBarCurrentOrders, style: getLargeStyle(color: _selectedIndex == 1 ? ColorManager.secondary : ColorManager.grey),),
        activeColorPrimary: ColorManager.white,
      ),
      PersistentBottomNavBarItem(
        onPressed: (BuildContext? context) {
          setState(() {
            _selectedIndex = 2;
            _controller.index = 2;
          });
        },
        icon: Text(AppStrings.bottomBarCompletedOrders, style: getLargeStyle(color: _selectedIndex == 2 ? ColorManager.secondary : ColorManager.grey),),
        activeColorPrimary: ColorManager.white,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: FloatingActionButton(
          backgroundColor: ColorManager.secondary,
          onPressed: () => Get.to(() => const AddOrderScreen()),
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            color: ColorManager.white,
          ),
        ),
      ),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        decoration: const NavBarDecoration(
          colorBehindNavBar: ColorManager.white,
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 1),
          ],
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: AppConstants.sliderAnimationTime),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: AppConstants.sliderAnimationTime),
        ),
        navBarStyle: NavBarStyle.style13, // Choose the nav bar style with this property.
      ),
    );
  }
}
