import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:handyman/app/widgets/widgets.dart';
import 'package:handyman/shared/shared.dart';

class ImagePreviewPage extends StatelessWidget {
  final String url;

  const ImagePreviewPage({Key key, @required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      body: Stack(
        children: [

          /// image
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
            top: kSpacingX4,
            left: kSpacingX16,
            child: SafeArea(
              child: IconButton(
                icon: Icon(kBackIcon),
                color: kWhiteColor,
                onPressed: () => context.navigator.pop(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
