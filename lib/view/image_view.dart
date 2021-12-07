import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallpaper/wallpaper.dart';

class ImageView extends StatefulWidget {
  final String imgPath;

  ImageView({@required this.imgPath});

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  var filePath;

  bool isFavorite = false;

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String home = "Home Screen",
      lock = "Lock Screen",
      both = "Both Screen",
      system = "System";

  Stream<String> progressString;
  String res;
  bool downloading = false;

  var result = "Waiting to set wallpaper";
  bool _isDisable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Hero(
            tag: widget.imgPath,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: kIsWeb
                  ? Image.network(widget.imgPath, fit: BoxFit.cover)
                  : CachedNetworkImage(
                      imageUrl: widget.imgPath,
                      placeholder: (context, url) => Container(
                        color: Color(0xfff5f8fd),
                      ),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      print("test");
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_outline,
                        color: isFavorite ? Colors.red : Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      if (kIsWeb) {
                        _launchURL(widget.imgPath);
                        //js.context.callMethod('downloadUrl',[widget.imgPath]);
                        //response = await dio.download(widget.imgPath, "./xx.html");
                      } else {
                        _save();
                      }
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Icon(
                        Icons.download,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                      onTap: () {
                        //Navigator.pop(context);
                        //dowloadImage(context).then((x) {});
                        showCupertinoModalBottomSheet(
                          context: context,
                          expand: false,
                          backgroundColor: Colors.transparent,
                          builder: (context) => Container(
                            height: 250,
                            child: Material(
                              color: Colors.white,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      dowloadImage(context, 0).then((x) {});
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 50,
                                      child: Center(child: Text("Home Screen")),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      dowloadImage(context, 0).then((x) {});
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 50,
                                      child: Center(child: Text("Lock Screen")),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      dowloadImage(context, 0).then((x) {});
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 50,
                                      child: Center(child: Text("Both")),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 50,
                                      child: Center(
                                          child: Text(
                                        "Cancel",
                                        style: TextStyle(color: Colors.red),
                                      )),
                                    ),
                                  ),
                                  SizedBox()
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      child: Stack(
                        children: <Widget>[
                          Container(
                              width: MediaQuery.of(context).size.width / 2 - 30,
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Colors.purple),
                              child: Text(
                                "Apply",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              )),
                        ],
                      )),
                ],
              ),
            ),
          ),
          Container(
            height: 200,
            child: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              iconTheme: IconThemeData(color: Colors.black),
              actionsIconTheme: IconThemeData(color: Colors.black),
              leading: Padding(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _save() async {
    await _askPermission();
    var response = await Dio().get(widget.imgPath,
        options: Options(responseType: ResponseType.bytes));
    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Image Saved")));
    Navigator.pop(context);
  }

  _askPermission() async {
    if (Platform.isIOS) {
      /*Map<PermissionGroup, PermissionStatus> permissions =
          */
      await Permission.photos;
    } else {
      /* PermissionStatus permission = */ await Permission.storage;
    }
  }

  Future<void> dowloadImage(BuildContext context, int type) async {
    progressString = Wallpaper.imageDownloadProgress(widget.imgPath);
    progressString.listen((data) {
      setState(() {
        res = data;
        downloading = true;
      });
      print("DataReceived: " + data);
    }, onDone: () async {
      setState(() {
        downloading = false;
        _isDisable = false;
      });
      print("Task Done");

      if (type == 0) {
        await Wallpaper.homeScreen();
      } else if (type == 0) {
        await Wallpaper.lockScreen();
      } else {
        await Wallpaper.bothScreen();
      }

      setState(() {
        downloading = false;
        both = both;
      });
      print("Set");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Image Set as background")));
    }, onError: (error) {
      setState(() {
        downloading = false;
        _isDisable = true;
      });
      print("Some Error");
    });
  }

  Widget imageDownloadDialog() {
    return Container(
      height: 120.0,
      width: 200.0,
      child: Card(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 20.0),
            Text(
              "Downloading File : $res",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
