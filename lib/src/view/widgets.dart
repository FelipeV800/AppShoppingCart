import 'package:flutter/material.dart';
import 'package:pruebakubo/src/model/const.dart';

class Widgets {
  static movieCards(
      {required String title,
      required String imageURL,
      required Function onAdded,
      required double price}) {
    return Card(
      shadowColor: Color(Constants.paletteColors["primary"]!),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      color: Color(Constants.paletteColors["white"]!),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.network(
              "https://image.tmdb.org/t/p/w500$imageURL",
              fit: BoxFit.cover,
              height: 170,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          title,
                          style: TextStyle(
                              color: Color(Constants.paletteColors["black"]!)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                    Text("\$ ${price.toString()}",
                        style: TextStyle(
                          fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(Constants.paletteColors["grey"]!))),
                  ],
                ),
              ),
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: FloatingActionButton.small(
                          onPressed: () {
                            onAdded();
                          },
                          child: Icon(Icons.add,
                              color: Color(Constants
                                  .paletteColors["complementaryLight"]!)),
                          backgroundColor:
                              Color(Constants.paletteColors["accent"]!),
                        )),
                  ))
            ]),
          )
        ],
      ),
    );
  }

  static shoppingCard(
      {required String title,
      required String imageURL,
      required Function onRemove,
      required Function onAdded,
      required int quantity,
      required double price}) {
    return Card(
      shadowColor: Color(Constants.paletteColors["primary"]!),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Padding(
              padding: const EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network("https://image.tmdb.org/t/p/w500$imageURL",
                    fit: BoxFit.cover, height: 100, width: 100),
              )),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      overflow: TextOverflow.ellipsis, maxLines: 2),
                  Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Text("\$ $price"))
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 15, left: 10),
            child: Row(
              children: [
                Container(
                    height: 25,
                    width: 25,
                    child: FloatingActionButton.small(
                        elevation: 3,
                        onPressed: () {
                          onRemove();
                        },
                        child: Icon(
                          Icons.remove,
                          size: 20,
                          color: Color(Constants.paletteColors["white"]!),
                        ),
                        backgroundColor:
                            Color(Constants.paletteColors["accent"]!))),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(quantity.toString())),
                Container(
                    height: 25,
                    width: 25,
                    child: FloatingActionButton.small(
                        elevation: 3,
                        onPressed: () {
                          onAdded();
                        },
                        child: Icon(
                          Icons.add,
                          size: 20,
                          color: Color(Constants.paletteColors["white"]!),
                        ),
                        backgroundColor:
                            Color(Constants.paletteColors["accent"]!))),
              ],
            ),
          )
        ],
      ),
    );
  }

  static generateButton(BuildContext context, Function function,
      {String? text,
      Color? colorBtn,
      BorderRadius? borderRadius,
      Color? colorBorder,
      Color? colorText,
      String? fontFamily,
      double? fontSize,
      TextAlign? textAlign,
      double? marginHorizontal,
      bool? loading}) {
    return Material(
      color: colorBtn ?? Color(Constants.paletteColors["primary"]!),
      borderRadius: borderRadius,
      child: InkWell(
        onTap: () {
          function();
        },
        splashColor: Colors.grey,
        borderRadius: borderRadius,
        child: Container(
          padding: EdgeInsets.only(
              left: marginHorizontal ?? 0,
              right: marginHorizontal ?? 0,
              top: 10,
              bottom: 10),
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                  color: colorBorder ?? Colors.transparent, width: 1),
              borderRadius: borderRadius),
          child: loading ?? false
              ? const CircularProgressIndicator()
              : Text(
                  text ?? "",
                  textAlign: textAlign ?? TextAlign.center,
                  maxLines: 1,
                  style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: fontSize,
                      color: colorText ??
                          Color(
                              Constants.paletteColors["complementaryLight"]!)),
                ),
        ),
      ),
    );
  }
}
