import 'package:flutter/material.dart';
import 'package:lite/app/widgets/widgets.dart';
import 'package:lite/shared/shared.dart';

/// shows an empty state UI
Widget emptyStateUI(
  BuildContext context, {
  String message = 'No content found',
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
          style: kTheme.textTheme.headline5,
          textAlign: TextAlign.center,
        ),
        if (onTap != null) ...{
          SizedBox(height: kSpacingX28),
          ButtonOutlined(
            width: SizeConfig.screenWidth * 0.4,
            onTap: onTap,
            label: 'Retry',
          ),
        }
      ],
    ),
  );
}
