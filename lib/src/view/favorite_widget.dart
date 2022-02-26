import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pruebakubo/src/controllers/favorite_controller.dart';
import '../model/const.dart';

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget ({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<FavoriteWidget> {
  FavoriteController favoriteController = FavoriteController();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
        backgroundColor:
        Color(Constants.paletteColors["accent"]!),
    onPressed: () {
          favoriteController.toggle();
    },
    child: Obx(() => Icon(favoriteController.isFavorite.value ? Icons.favorite : Icons.favorite_border_outlined ,
        color: Color(Constants.paletteColors[
        "complementaryLight"]!))));
  }
}
