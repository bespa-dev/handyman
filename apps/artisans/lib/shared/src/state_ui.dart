import 'package:flutter/material.dart';
import 'package:handyman/shared/shared.dart';
import 'package:uuid/uuid.dart';

/// shows an empty state UI
Widget emptyStateUI(BuildContext context,
    {String message = "No content found", IconData icon = kEmptyIcon}) {
  logger.d("${Uuid().v4()} => ${DateTime.now().toIso8601String()}");
  final kTheme = Theme.of(context);
  return Container(
    width: SizeConfig.screenWidth,
    height: SizeConfig.screenHeight * 0.3,
    padding:
        EdgeInsets.symmetric(horizontal: kSpacingX24, vertical: kSpacingX36),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: kSpacingX48,
          color: kTheme.colorScheme.onBackground,
        ),
        SizedBox(height: kSpacingX24),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "$message\n"),
              TextSpan(
                text: "Try again later",
                style: kTheme.textTheme.bodyText1,
              ),
            ],
            style: kTheme.textTheme.headline5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
