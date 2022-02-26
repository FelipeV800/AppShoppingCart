import 'package:get/get.dart';
import 'package:pruebakubo/src/model/MoviesModel.dart';
import 'package:pruebakubo/src/resources/movie_api.dart';

class HomePageController extends GetxController {
  var model = MoviesModel().obs;
  RxBool isLoading = true.obs;
  RxBool error = false.obs;

  loadMovies(String filter) async {
    try{
      isLoading.value = true;
      var temp = await MoviesProvider().getMovieList();
      if(filter.isEmpty){
        model.value = temp;
      }
      else{
        var temp2 = temp.results?.where((element) => (element.title??"").toLowerCase().startsWith(filter.toLowerCase())).toList();
        model.value.results = temp2;
      }
      isLoading.value = false;
    }
    catch(e){
      error.value = true;
    }
    update();
  }

}