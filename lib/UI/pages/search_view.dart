import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../data/data.dart';
import '../../models/photos_model.dart';
import '../widgets/common.dart';

class SearchView extends StatefulWidget {
  final String search;

  SearchView({@required this.search});

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<PhotosModel> photos = new List();
  TextEditingController searchController = new TextEditingController();

  getSearchWallpaper(String searchQuery) async {
    setState(() {
      photos = [];
    });
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$searchQuery&per_page=60&page=1&size=large"),
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

  @override
  void initState() {
    getSearchWallpaper(widget.search);
    searchController.text = widget.search;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        actionsIconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: photos.length == 0
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        color: Colors.purple,
                      ),
                    ),
                  ),
                )
              : Column(
                  children: <Widget>[
                    SizedBox(
                      height: 16,
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
                            decoration: InputDecoration(
                                hintText: "search wallpapers",
                                border: InputBorder.none),
                          )),
                          InkWell(
                              onTap: () {
                                getSearchWallpaper(searchController.text);
                              },
                              child: Container(child: Icon(Icons.search)))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    wallPaper(photos, context),
                  ],
                ),
        ),
      ),
    );
  }
}
