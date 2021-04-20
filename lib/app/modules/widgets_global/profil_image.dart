import 'package:book_app/app/utils/constant/constant.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfileImage extends InkWell {

  ProfileImage({double size: 20.0, @required String urlString, @required VoidCallback onPressed}) : super (
    onTap: onPressed,
    child: CircleAvatar(
      radius: size,
      backgroundImage: (urlString != null && urlString != "") ? CachedNetworkImageProvider(urlString) : Constant.logoImage,
      backgroundColor: ConstantColor.white,
    ),
  );



}