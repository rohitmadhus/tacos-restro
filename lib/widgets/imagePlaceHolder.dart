import 'package:flutter/material.dart';
import 'package:restro/widgets/custom_text.dart';
import 'package:transparent_image/transparent_image.dart';

class ImagePlaceHolderWidget extends StatelessWidget {
  final bool hasImage;
  final String url;

  const ImagePlaceHolderWidget({Key key, this.hasImage, this.url})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return hasImage
        ? FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: url,
            height: 160,
            fit: BoxFit.fill,
            width: double.infinity,
          )
        : Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.camera_alt,
                      size: 40,
                    ),
                  ],
                ),
                CustomText(text: "No Photo")
              ],
            ),
            height: 160,
          );
  }
}
