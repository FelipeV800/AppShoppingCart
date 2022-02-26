import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pruebakubo/src/controllers/cart_controller.dart';
import 'package:pruebakubo/src/model/const.dart';

import '../../model/MoviesModel.dart';
import '../widgets.dart';
import 'movie_details.dart';

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartController = Get.find<CartController>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(Constants.paletteColors["complementaryLight"]!),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            Row(
              children: [
                FloatingActionButton.small(
                  onPressed: () {},
                  backgroundColor: Color(Constants.paletteColors["accent"]!),
                  child: Icon(
                    Icons.widgets,
                    color:
                        Color(Constants.paletteColors["complementaryLight"]!),
                  ),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 30),
                child: GetBuilder<CartController>(builder: (controller) {
                  if(controller.items.isEmpty){
                   return Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: const [
                       Icon(
                         Icons.shopping_basket_outlined,
                         size: 90,
                         color: Colors.deepOrange,
                       ),
                       SizedBox(height: 20,),
                       Text("El carrito se encuentra vacio",style: TextStyle(
                         fontSize: 20
                       ),)
                     ],
                   );
                  }
                  return ListView.builder(
                    itemCount: cartController.items.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return MovieDetails(
                                    movie: cartController.items[index],
                                  );
                                }));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Widgets.shoppingCard(
                                title: cartController.items[index].title ?? "",
                                imageURL:
                                cartController.items[index].posterPath ??
                                    "",
                                onAdded: () {
                                  cartController
                                      .add(cartController.items[index]);
                                },
                                onRemove: () {
                                  cartController
                                      .remove(cartController.items[index]);
                                },
                                quantity: cartController.items[index].quantity,
                            price:  cartController.items[index].price??0.0),
                          ));
                    },
                  );
                }),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15, left: 20, right: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text("Total",
                            style: TextStyle(
                                color: Color(Constants.paletteColors["grey"]!),
                                fontSize: 19)),
                      ),
                      Text("\$${cartController.totalPrice}",
                          style: TextStyle(
                              color: Color(Constants.paletteColors["black"]!),
                              fontSize: 20))
                    ],
                  ),
                  Widgets.generateButton(context, () {},
                      text: "Realizar Pago",
                      colorBtn: Color(Constants.paletteColors["primary"]!),
                      fontSize: 20,
                      colorText:
                          Color(Constants.paletteColors["complementaryLight"]!),
                      borderRadius: BorderRadius.circular(15),
                      marginHorizontal: 20)
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
