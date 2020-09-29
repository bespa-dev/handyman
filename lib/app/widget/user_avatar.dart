import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

class UserAvatar extends StatelessWidget {
  final String url;
  final Function onTap;
  final double radius;

  const UserAvatar({
    Key key,
    @required this.url,
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
            border: Border.all(color: themeData.accentColor, width: 4),
          ),
          child: Image.network(
            url ?? "",
            fit: BoxFit.cover,
            width: radius,
            height: radius,
            alignment: Alignment.center,
            errorBuilder: (_, __, chunk) => Container(
              height: radius,
              width: radius,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: themeData.errorColor.withOpacity(0.14),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
