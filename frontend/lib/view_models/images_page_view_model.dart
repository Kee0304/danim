import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ImagesPageViewModel extends ChangeNotifier {
  List<String>? imagesUrl;
  List<XFile>? xFileList;
  final imageList = <Widget>[];
  final controller = PageController(initialPage: 0);

  ImagesPageViewModel({this.imagesUrl, this.xFileList}) {
    if (imagesUrl != null && xFileList == null) {
      for (var imageUrl in imagesUrl!) {
        imageList.add(CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder: (_, __) =>
              Image.asset('assets/images/default_image.png'),
          fit: BoxFit.cover,
        ));
      }
    } else if (imagesUrl == null && xFileList != null) {
      for (var xFile in xFileList!) {
        imageList.add(Image.file(
          File(xFile.path),
          fit: BoxFit.cover,
        ));
      }
    }
  }
}
