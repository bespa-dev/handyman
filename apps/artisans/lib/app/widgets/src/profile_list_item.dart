import 'package:flutter/material.dart';
import 'package:handyman/shared/shared.dart';

class ProfileListItem extends StatelessWidget {
  const ProfileListItem({
    Key key,
    @required this.icon,
    @required this.text,
    this.hasNavigation = true,
    this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final bool hasNavigation;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    var kTheme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
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
          color: kTheme.cardColor,
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
      ),
    );
  }
}
