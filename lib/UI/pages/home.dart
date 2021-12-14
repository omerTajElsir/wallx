import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:wallx/UI/pages/search_view.dart';
import 'dart:convert';

import '../../data/data.dart';
import '../../models/categorie_model.dart';
import '../../models/colors_model.dart';
import '../../models/photos_model.dart';
import '../widgets/categories_tile.dart';
import '../widgets/colors_tile.dart';
import '../widgets/common.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategorieModel> categories = new List();
  List<ColorsModel> colors = new List();

  int noOfImageToLoad = 30;
  List<PhotosModel> photos = new List();

  getTrendingWallpaper() async {
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/curated?per_page=$noOfImageToLoad&page=1&size=large"),
        headers: {"Authorization": apiKEY}).then((value) {
      //print(value.body);

      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        //print(element);
        PhotosModel photosModel = new PhotosModel();
        photosModel = PhotosModel.fromMap(element);
        photos.add(photosModel);
        //print(photosModel.toString()+ "  "+ photosModel.src.portrait);
      });

      setState(() {});
    });
  }

  TextEditingController searchController = new TextEditingController();

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    //getWallpaper();
    getTrendingWallpaper();
    categories = getCategories();
    colors = getColors();
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        noOfImageToLoad = noOfImageToLoad + 30;
        getTrendingWallpaper();
      }
    });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: brandName(),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        actionsIconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onSubmitted: (value) {
                          if (searchController.text != "") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchView(
                                  search: searchController.text,
                                ),
                              ),
                            );
                            //searchController.clear();
                          }
                        },
                        decoration: InputDecoration(
                            hintText: "search wallpapers",
                            border: InputBorder.none),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          if (searchController.text != "") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchView(
                                  search: searchController.text,
                                ),
                              ),
                            );
                            //searchController.clear();
                          }
                        },
                        child: Container(child: Icon(Icons.search)))
                  ],
                ),
              ),

              /// Color scroll
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  "Color Filter",
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: 'Overpass',
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    itemCount: colors.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      /// Create List Item tile
                      return ColorsTile(
                        name: colors[index].name,
                        color: colors[index].color,
                      );
                    }),
              ),

              /// Categories Scroll

              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  "Categories",
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: 'Overpass',
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),

              Container(
                height: 70,
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      /// Create List Item tile
                      return CategoriesTile(
                        imgUrls: categories[index].imgUrl,
                        categorie: categories[index].categorieName,
                      );
                    }),
              ),

              ///Trending Scroll

              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  "Trending Now",
                  style: TextStyle(
                      color: Colors.black87,
                      fontFamily: 'Overpass',
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              photos.length > 0
                  ? wallPaper(photos, context)
                  : Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(
                            color: Colors.purple,
                          ),
                        ),
                      ),
                    ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Photos provided By ",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                        fontFamily: 'Overpass'),
                  ),
                  GestureDetector(
                    onTap: () {
                      _launchURL("https://www.pexels.com/");
                    },
                    child: Container(
                        child: Text(
                      "Pexels",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                          fontFamily: 'Overpass'),
                    )),
                  )
                ],
              ),
              SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
