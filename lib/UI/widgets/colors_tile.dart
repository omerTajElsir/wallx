import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../pages/categorie_screen.dart';
import '../pages/colored_screen.dart';

class ColorsTile extends StatelessWidget {
  final String name;
  final Color color;

  ColorsTile({@required this.color, @required this.name});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ColoredScreen(
              color: name,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 8),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                    colors: [color, color.withOpacity(0.65)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 7.0,
                    offset: Offset(0, 5),
                    spreadRadius: 0.5,
                  ),
                ],
              ),
              width: 100,
              height: 50,
            ),
            SizedBox(
              height: 4,
            ),
          ],
        ),
      ),
    );
  }
}
