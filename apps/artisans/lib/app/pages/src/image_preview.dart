import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:handyman/app/widgets/widgets.dart';
import 'package:handyman/shared/shared.dart';

class ImagePreviewPage extends StatelessWidget {
  final String url;

  const ImagePreviewPage({Key key, @required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final kTheme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: ImageView(
              imageUrl: url,
              fit: BoxFit.contain,
              height: SizeConfig.screenHeight,
              width: SizeConfig.screenWidth,
              isInteractive: true,
            ),
          ),

          /// back button
          Positioned(
            top: kSpacingX36,
            left: kSpacingX16,
            child: IconButton(
              icon: Icon(kBackIcon),
              onPressed: () => context.navigator.pop(),
            ),
          ),
        ],
      ),
    );
  }
}
