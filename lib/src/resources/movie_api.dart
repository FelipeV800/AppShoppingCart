import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../model/MoviesModel.dart';
import '../model/const.dart';

class MoviesProvider {

  static final _instance = MoviesProvider._internal();

  MoviesProvider._internal();

  factory MoviesProvider(){
    return _instance;
  }

  Future<MoviesModel> getMovieList() async {
    try {
      Response response = await http.get(Uri.parse(Constants.apiUrl + Constants.apiPopular + "?api_key=" + Constants.apiKey + "&language=en-ES&page=1"));
      MoviesModel _moviesModel = MoviesModel.fromJson(jsonDecode(response.body));
      _moviesModel.results = _moviesModel.results?.map((e){
        e.price = Random().nextInt(80000).toDouble();
        return e;
      }).toList();
      return _moviesModel;
    } catch (e) {
      print(e.toString());
      throw "error";
    }
  }

}