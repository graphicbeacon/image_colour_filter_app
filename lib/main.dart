import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: ImageApp(),
    ),
  ));
}

class ImageApp extends StatefulWidget {
  @override
  _ImageAppState createState() => _ImageAppState();
}

class _ImageAppState extends State<ImageApp> {
  final double handleWidth = 30;
  final imgUrl = 'https://picsum.photos/id/10';

  double leftStart;
  double containerWidth = 100;

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;

    final networkImageUrl = '$imgUrl/${screenW.toInt()}/${screenH.toInt()}';

    return Stack(
      children: <Widget>[
        Container(
            width: screenW,
            height: screenH,
            color: Colors.yellow,
            child: Image.network(
              networkImageUrl,
              width: screenW,
              height: screenH,
            )),
        Container(
            width: containerWidth,
            height: screenH,
            color: Colors.purple,
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: 0,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.green,
                      BlendMode.overlay,
                    ),
                    child: Image.network(
                      networkImageUrl,
                      width: screenW,
                      height: screenH,
                      fit: BoxFit.none,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onHorizontalDragStart: (details) {
                      setState(() {
                        leftStart = details.localPosition.dx;
                      });
                    },
                    onHorizontalDragUpdate: (details) {
                      var offsetWidth = details.globalPosition.dx + leftStart;

                      setState(() {
                        if (offsetWidth < handleWidth) {
                          containerWidth = handleWidth;
                        } else {
                          containerWidth = offsetWidth;
                        }
                      });
                    },
                    child: Container(
                      width: handleWidth,
                      height: screenH,
                      color: Colors.grey,
                      child: Icon(Icons.drag_handle),
                    ),
                  ),
                )
              ],
            )),
      ],
    );
  }
}
