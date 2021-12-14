import 'package:flutter/material.dart';

import '../models/categorie_model.dart';
import '../models/colors_model.dart';

/// Login to https://www.pexels.com and create your free API key
String apiKEY = "YOUR API KEY HERE";

List<CategorieModel> getCategories() {
  List<CategorieModel> categories = new List();
  CategorieModel categorieModel = new CategorieModel();

  //
  categorieModel.imgUrl =
      "https://images.pexels.com/photos/545008/pexels-photo-545008.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categorieModel.categorieName = "Street Art";
  categories.add(categorieModel);
  categorieModel = new CategorieModel();

  //
  categorieModel.imgUrl =
      "https://images.pexels.com/photos/704320/pexels-photo-704320.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categorieModel.categorieName = "Wild Life";
  categories.add(categorieModel);
  categorieModel = new CategorieModel();

  //
  categorieModel.imgUrl =
      "https://images.pexels.com/photos/34950/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categorieModel.categorieName = "Nature";
  categories.add(categorieModel);
  categorieModel = new CategorieModel();

  //
  categorieModel.imgUrl =
      "https://images.pexels.com/photos/466685/pexels-photo-466685.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categorieModel.categorieName = "City";
  categories.add(categorieModel);
  categorieModel = new CategorieModel();

  //
  categorieModel.imgUrl =
      "https://images.pexels.com/photos/1434819/pexels-photo-1434819.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260";
  categorieModel.categorieName = "Motivation";

  categories.add(categorieModel);
  categorieModel = new CategorieModel();

  //
  categorieModel.imgUrl =
      "https://images.pexels.com/photos/2116475/pexels-photo-2116475.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categorieModel.categorieName = "Bikes";
  categories.add(categorieModel);
  categorieModel = new CategorieModel();

  //
  categorieModel.imgUrl =
      "https://images.pexels.com/photos/1149137/pexels-photo-1149137.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categorieModel.categorieName = "Cars";
  categories.add(categorieModel);
  categorieModel = new CategorieModel();

  return categories;
}

List<ColorsModel> getColors() {
  List<ColorsModel> colors = new List();
  ColorsModel colorsModel = new ColorsModel();

  //
  colorsModel.name = "turquoise";
  colorsModel.color = Colors.teal;
  colors.add(colorsModel);
  colorsModel = new ColorsModel();

  //
  colorsModel.name = "orange";
  colorsModel.color = Colors.orange;
  colors.add(colorsModel);
  colorsModel = new ColorsModel();

  //
  colorsModel.name = "gray";
  colorsModel.color = Colors.grey;
  colors.add(colorsModel);
  colorsModel = new ColorsModel();

  //
  colorsModel.name = "violet";
  colorsModel.color = Colors.deepPurpleAccent;
  colors.add(colorsModel);
  colorsModel = new ColorsModel();

  //
  colorsModel.name = "white";
  colorsModel.color = Colors.white;
  colors.add(colorsModel);
  colorsModel = new ColorsModel();

  //
  colorsModel.name = "black";
  colorsModel.color = Colors.black;
  colors.add(colorsModel);
  colorsModel = new ColorsModel();

  //
  colorsModel.name = "green";
  colorsModel.color = Colors.green;
  colors.add(colorsModel);
  colorsModel = new ColorsModel();

  //
  colorsModel.name = "yellow";
  colorsModel.color = Colors.yellow;
  colors.add(colorsModel);
  colorsModel = new ColorsModel();

  //
  colorsModel.name = "red";
  colorsModel.color = Colors.red;

  colors.add(colorsModel);
  colorsModel = new ColorsModel();

  //
  colorsModel.name = "blue";
  colorsModel.color = Colors.blue;
  colors.add(colorsModel);
  colorsModel = new ColorsModel();

  //
  colorsModel.name = "pink";
  colorsModel.color = Colors.pink;
  colors.add(colorsModel);
  colorsModel = new ColorsModel();

  //
  colorsModel.name = "brown";
  colorsModel.color = Colors.brown;
  colors.add(colorsModel);
  colorsModel = new ColorsModel();

  return colors;
}
