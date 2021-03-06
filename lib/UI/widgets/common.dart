import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../models/photos_model.dart';
import '../pages/image_view.dart';

Widget wallPaper(List<PhotosModel> listPhotos, BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(4.0),
        mainAxisSpacing: 6.0,
        crossAxisSpacing: 6.0,
        children: listPhotos.map((PhotosModel photoModel) {
          return GridTile(
              child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ImageView(
                            imgPath: photoModel.src.portrait,
                            photographer: photoModel.photographer,
                            photographerURL: photoModel.photographerUrl,
                          )));
            },
            child: Hero(
              tag: photoModel.src.portrait,
              child: Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: kIsWeb
                        ? Image.network(
                            photoModel.src.portrait,
                            height: 50,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        : CachedNetworkImage(
                            imageUrl: photoModel.src.portrait,
                            placeholder: (context, url) => Shimmer(
                                  period: Duration(seconds: 3), //Default value
                                  loop: 5,
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.grey.shade600,
                                      Colors.grey.shade400
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ), //Default value
                                  enabled: true, //Default value
                                  child: Container(
                                    color: Colors.deepPurple,
                                  ),
                                ),
                            fit: BoxFit.cover)),
              ),
            ),
          ));
        }).toList()),
  );
}

Widget brandName() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Text(
        "Wall",
        style: TextStyle(color: Colors.black87, fontFamily: 'Overpass'),
      ),
      Text(
        "X",
        style: TextStyle(
            color: Colors.purple,
            fontFamily: 'Overpass',
            fontWeight: FontWeight.bold),
      )
    ],
  );
}
