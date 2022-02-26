import 'package:get/get.dart';

class FavoriteController extends GetxController {
  var isFavorite = false.obs;

  toggle (){
    isFavorite.value = !isFavorite.value;
  }
}