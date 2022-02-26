import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:pruebakubo/src/controllers/cart_controller.dart';
import '../../controllers/home_page_controller.dart';
import '../../model/MoviesModel.dart';
import '../../model/const.dart';
import '../widgets.dart';
import 'movie_details.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  var homePageController = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      homePageController.loadMovies("");
    });

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton.small(
              onPressed: () {},
              backgroundColor: Color(Constants.paletteColors["accent"]!),
              child: Icon(
                Icons.widgets,
                color: Color(Constants.paletteColors["complementaryLight"]!),
              ),
            ),
            Text("Bienvenido a RePelis.net", style: TextStyle(fontSize: 20, color: Color(Constants.paletteColors["primary"]!), fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis)
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 15, bottom: 20),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
                child: TextField(
                  onChanged: (value){
                    homePageController.loadMovies(value);
                  },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  hintText: "Buscar",
                  filled: true,
                  fillColor: Color(Constants.paletteColors["white"]!)),
            )),
            FloatingActionButton.small(
              onPressed: () {},
              child: Icon(
                Icons.settings_rounded,
                color: Color(Constants.paletteColors["complementaryLight"]!),
              ),
              backgroundColor: Color(Constants.paletteColors["accent"]!),
            )
          ]),
        ),
        Expanded(
          child: GetBuilder<HomePageController>(builder: (controller) {
            if (controller.error.value) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.warning_amber_outlined,
                    color: Colors.deepOrange,
                  ),
                  Text("Error, intentalo de nuevo")
                ],
              );
            }
            if (controller.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(
                  color: Color(Constants.paletteColors["accent"]!),
                ),
              );
            }
            return Obx(()=>(homePageController.model.value.results!.isNotEmpty)?GridView.builder(
                padding: EdgeInsets.zero,
                itemCount: homePageController.model.value.results?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  var item = homePageController.model.value.results?[index];
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return MovieDetails(
                            movie: item ?? Movie(),
                          );
                        }));
                      },
                      child: Widgets.movieCards(
                          title: item?.originalTitle ?? "",
                          imageURL: item?.posterPath ?? "",
                          price: item?.price??0,
                          onAdded: () {
                            Get.find<CartController>().add(item);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(
                              content: Text(
                                  "Se ha agregado la pelicula al carrito"),
                            ));
                          }));
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: 10),
              ):
              Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.warning_amber_outlined,
                        color: Colors.deepOrange,
                        size: 90,
                      ),
                      Text("No hay resultados relacionados", style: TextStyle(fontSize: 20),)
                    ],
                  )
              ),
            );
          }),
        ),
      ]),
    );
  }
}
