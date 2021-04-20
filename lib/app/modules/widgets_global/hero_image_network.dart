import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_circular_progress.dart';

class HeroImageNetwork extends StatelessWidget {
  final String tag, imageUrl;
  final BorderRadius borderRadius;
  final bool borderEnabled, justImage;
  final double width;
  final EdgeInsetsGeometry margin;

  HeroImageNetwork(
      {Key key,
      @required this.tag,
      @required this.imageUrl,
      this.width: 85,
      this.margin: const EdgeInsets.all(7),
      this.borderEnabled: true,
      this.justImage: false,
      this.borderRadius})
      : assert(tag != null),
        assert(imageUrl != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (justImage) return _buildJustImage();
    return _buildImageContainer();
  }

  Widget _buildJustImage() {
    return Hero(
      tag: tag,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        useOldImageOnUrlChange: true,
        placeholder: (context, url) => CustomCircularProgress(radius: 20),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  Widget _buildImageContainer() {
    return Container(
      margin: margin,
      width: width,
      height: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(
        borderRadius: borderEnabled
            ? (borderRadius != null)
                ? borderRadius
                : BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))
            : BorderRadius.zero,
        child: _buildJustImage(),
      ),
    );
  }
}
