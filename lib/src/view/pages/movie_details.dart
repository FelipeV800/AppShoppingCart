import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:pruebakubo/src/controllers/cart_controller.dart';
import 'package:pruebakubo/src/model/const.dart';
import 'package:pruebakubo/src/view/favorite_widget.dart';
import '../../model/MoviesModel.dart';
import '../widgets.dart';

class MovieDetails extends StatefulWidget {
  final Movie movie;

  const MovieDetails({Key? key, required this.movie}) : super(key: key);

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _animationControllerScale;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    //_animationController.addListener(() { setState(() {});});
    // _animationControllerScale.addListener(() { setState(() {});});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(Constants.paletteColors["complementaryLight"]!),
      body: SafeArea(
        child: FutureBuilder(
            future: Future.delayed(const Duration(milliseconds: 1500)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                  _animationController.reset();
                  _animationController.forward();
                });
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        (snapshot.connectionState != ConnectionState.done)
                            ? const Positioned.fill(
                                child:
                                    Center(child: CircularProgressIndicator()))
                            : Container(),
                        GestureDetector(
                          child: ScaleTransition(
                            scale: Tween<double>(begin: 0, end: 1).animate(
                                CurvedAnimation(
                                    parent: _animationController,
                                    curve: Curves.easeInOut)),
                            child: Material(
                              elevation: 20,
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(25),
                                  bottomRight: Radius.circular(25)),
                              child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(25),
                                      bottomRight: Radius.circular(25)),
                                  child: Image.network(
                                    "https://image.tmdb.org/t/p/w500${widget.movie.backdropPath ?? ""}",
                                    height: 350,
                                    width: double.infinity,
                                    fit: BoxFit.fitHeight,
                                  )),
                            ),
                          ),
                        ),
                        SlideTransition(
                          position: Tween<Offset>(
                                  begin: const Offset(-1, 0),
                                  end: const Offset(0, 0))
                              .animate(CurvedAnimation(
                                  parent: _animationController,
                                  curve: Curves.easeInOut)),
                          child: FloatingActionButton.small(
                              backgroundColor:
                                  Color(Constants.paletteColors["accent"]!),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.arrow_back_rounded,
                                  color: Color(Constants
                                      .paletteColors["complementaryLight"]!))),
                        ),
                        Align(
                            alignment: Alignment.topRight,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                      begin: const Offset(1, 0),
                                      end: const Offset(0, 0))
                                  .animate(CurvedAnimation(
                                      parent: _animationController,
                                      curve: Curves.easeInOut)),
                              child: const FavoriteWidget(),
                            ))
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                            top: 45, left: 30, right: 30, bottom: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Flexible(
                                    child: Text(widget.movie.title ?? "",
                                        style: TextStyle(
                                            color: Color(Constants
                                                .paletteColors["black"]!),
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold))),
                                Text("\$ ${widget.movie.price}",
                                    style: TextStyle(
                                        color: Color(
                                            Constants.paletteColors["black"]!),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold))
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 20),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: RatingBar.builder(
                                    itemSize: 25,
                                    direction: Axis.horizontal,
                                    wrapAlignment: WrapAlignment.start,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    ignoreGestures: true,
                                    initialRating:
                                        (widget.movie.voteAverage ?? 0) / 2,
                                    itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    }),
                              ),
                            ),
                            Text(widget.movie.overview ?? ""),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Fecha de lanzamiento:"),
                                  Text(widget.movie.releaseDate ?? "",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                            Widgets.generateButton(context, () {
                              Get.find<CartController>().add(widget.movie);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    "Se ha agregado la pelicula al carrito"),
                              ));
                            },
                                text: "Agregar al carrito",
                                borderRadius: BorderRadius.circular(15),
                                colorText: Color(Constants
                                    .paletteColors["complementaryLight"]!),
                                colorBtn:
                                    Color(Constants.paletteColors["accent"]!),
                                marginHorizontal: 10,
                                fontSize: 18),
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Widgets.generateButton(context, () {
                                Get.find<CartController>().remove(widget.movie);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                      "Se ha eliminado la pelicula al carrito"),
                                ));
                              },
                                  text: "Eliminar del carrito",
                                  borderRadius: BorderRadius.circular(15),
                                  colorText: Color(Constants
                                      .paletteColors["complementaryLight"]!),
                                  colorBtn:
                                      Color(Constants.paletteColors["accent"]!),
                                  marginHorizontal: 7,
                                  fontSize: 18),
                            )
                          ],
                        ))
                  ],
                ),
              );
            }),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationControllerScale.dispose();
    super.dispose();
  }
}
