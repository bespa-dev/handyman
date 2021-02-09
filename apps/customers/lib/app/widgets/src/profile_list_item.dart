import 'package:flutter/material.dart';
import 'package:lite/shared/shared.dart';

class ProfileListItem extends StatelessWidget {
  const ProfileListItem({
    Key key,
    this.icon,
    this.text,
    this.hasNavigation = true,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final bool hasNavigation;

  @override
  Widget build(BuildContext context) {
    var kTheme = Theme.of(context);

    return Container(
      height: kSpacingX56,
      margin: EdgeInsets.symmetric(
        horizontal: kSpacingX36,
      ).copyWith(
        bottom: kSpacingX20,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: kSpacingX20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kSpacingX28),
        color: Theme.of(context).backgroundColor,
      ),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: kSpacingX24,
          ),
          SizedBox(width: kSpacingX16),
          Text(
            text,
            style: kTheme.textTheme.button.copyWith(
              color: kTheme.colorScheme.onBackground,
            ),
          ),
          Spacer(),
          if (hasNavigation) Icon(kArrowIcon, size: kSpacingX24),
        ],
      ),
    );
  }
}
