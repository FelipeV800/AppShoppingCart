import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pruebakubo/src/controllers/cart_controller.dart';
import 'package:pruebakubo/src/model/const.dart';
import 'package:pruebakubo/src/view/pages/home_page.dart';
import 'package:pruebakubo/src/view/pages/shoping_car.dart';
import '../../controllers/main_controller.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  PageController pageController = PageController();
  MainController mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    Get.put(CartController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(Constants.paletteColors["complementaryLight"]!),
        body: _createBody(),
        bottomNavigationBar: Obx(() {
          return BottomNavigationBar(
            currentIndex: mainController.pageIndex.value,
            onTap: (index) {
              pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut).then((value) => {
                    mainController.setPageIndex(index)
              });
            },
            unselectedItemColor:
                Color(Constants.paletteColors["complementaryDark"]!),
            backgroundColor: Color(Constants.paletteColors["primary"]!),
            selectedItemColor:
                Color(Constants.paletteColors["complementaryLight"]!),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Peliculas'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart_rounded), label: 'Carrito')
            ],
          );
        }),
      ),
    );
  }

  Widget _createBody() {
    return PageView.builder(
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return HomePage();
          case 1:
            return const ShoppingCart();
          default:
            return HomePage();
        }
      },
      physics: NeverScrollableScrollPhysics(),
      itemCount: 2,
      controller: pageController,
    );
  }
}
