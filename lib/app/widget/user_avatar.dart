import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

class UserAvatar extends StatelessWidget {
  final String url;
  final Function onTap;
  final double radius;
  final Color ringColor;

  const UserAvatar({
    Key key,
    @required this.url,
    @required this.ringColor,
    this.onTap,
    this.radius = 48.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return GestureDetector(
      onTap: () => onTap ?? null,
      child: Hero(
        tag: url != null && url.isNotEmpty ? url : Uuid().v4(),
        child: Container(
          height: radius,
          width: radius,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: themeData.scaffoldBackgroundColor,
            border: Border.all(
              color: ringColor,
              width: 4,
            ),
          ),
          child: Image.network(
            url ?? "",
            fit: BoxFit.cover,
            width: radius,
            height: radius,
            alignment: Alignment.center,
            errorBuilder: (_, __, chunk) => Container(
              alignment: Alignment.center,
              height: radius,
              width: radius,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: themeData.primaryColor.withOpacity(0.14),
                shape: BoxShape.circle,
              ),
              child: Icon(Feather.user, size: radius / 2.5, color: ringColor),
            ),
          ),
        ),
      ),
    );
  }
}
