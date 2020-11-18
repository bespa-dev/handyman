import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:handyman/core/size_config.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_icons/flutter_icons.dart';

/// Shows a preview of an image using the [imageUrl] data
class PhotoPreviewPage extends StatefulWidget {
  final String imageUrl;

  const PhotoPreviewPage({Key key, this.imageUrl}) : super(key: key);

  @override
  _PhotoPreviewPageState createState() => _PhotoPreviewPageState();
}

class _PhotoPreviewPageState extends State<PhotoPreviewPage> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          tooltip: "Back",
          icon: Icon(Feather.x),
          onPressed: () => context.navigator.pop(),
        ),
      ),
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: InteractiveViewer(
          child: CachedNetworkImage(
            imageUrl: widget.imageUrl,
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            fit: BoxFit.contain,
            placeholder: (_, __) => Container(),
            // progress indicator
            errorWidget: (_, __, ___) => Center(
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation<Color>(
                  themeData.colorScheme.secondary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
