import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../data/data.dart';
import '../../models/photos_model.dart';
import '../widgets/common.dart';

class ColoredScreen extends StatefulWidget {
  final String color;

  ColoredScreen({@required this.color});

  @override
  _ColoredScreenState createState() => _ColoredScreenState();
}

class _ColoredScreenState extends State<ColoredScreen> {
  List<PhotosModel> photos = new List();

  getCategorieWallpaper() async {
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=${widget.color}&per_page=60&page=1&size=large"),
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
    getCategorieWallpaper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        actionsIconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25, top: 20, bottom: 20),
              child: Text(
                widget.color,
                style: TextStyle(
                    color: Colors.black87,
                    fontFamily: 'Overpass',
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            photos.length == 0
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
                : wallPaper(photos, context),
          ],
        )),
      ),
    );
  }
}
