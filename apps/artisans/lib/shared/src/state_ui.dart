import 'package:flutter/material.dart';
import 'package:handyman/app/widgets/widgets.dart';
import 'package:handyman/shared/shared.dart';

/// shows an empty state UI
Widget emptyStateUI(
  BuildContext context, {
  String message = 'No content found',
  String buttonText = 'Retry',
  IconData icon = kEmptyIcon,
  Function onTap,
}) {
  final kTheme = Theme.of(context);
  return Container(
    width: SizeConfig.screenWidth,
    padding:
        EdgeInsets.symmetric(horizontal: kSpacingX24, vertical: kSpacingX36),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: kSpacingX64,
          color: kTheme.colorScheme.onBackground,
        ),
        SizedBox(height: kSpacingX24),
        Text(
          message,
          style: kTheme.textTheme.headline6,
          textAlign: TextAlign.center,
        ),
        if (onTap != null) ...{
          SizedBox(height: kSpacingX28),
          ButtonOutlined(
            width: SizeConfig.screenWidth * 0.3,
            onTap: onTap,
            label: buttonText,
          ),
        }
      ],
    ),
  );
}
