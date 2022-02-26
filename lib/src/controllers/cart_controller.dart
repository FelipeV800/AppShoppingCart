import 'dart:collection';

import 'package:get/get.dart';

import '../model/MoviesModel.dart';

class CartController extends GetxController {
  final List<Movie> items = [];

  double get totalPrice {
    double total = 0;
    for (var element in items) {
      total+=(element.price??0);
    }
    return total;
  }

  void add(Movie? item) {
    if (item != null) {
      var movie = items.firstWhere((element) => element.id == item.id,
          orElse: () => Movie());
      if (movie.id == null) {
        items.add(item);
      } else {
        var temp = items.map((e) {
          if (e.id == item.id) {
            e.quantity++;
          }
          return e;
        }).toList();
        items.clear();
        items.addAll(temp);
      }
      update();
    }
  }

  void remove(Movie? item) {
    if (item != null) {
      var movie = items.firstWhere((element) => element.id == item.id,
          orElse: () => Movie());
      if (movie.id == null) {
        //_items.remove(item);
      } else {
        if(movie.quantity<=1){
          items.remove(movie);
        }
        else{
          var temp = items.map((e) {
            if (e.id == item.id) {
              e.quantity--;
            }
            return e;
          }).toList();
          items.clear();
          items.addAll(temp);
        }
      }
      update();
    }
  }

  void removeAll() {
    items.clear();
    update();
  }
}
