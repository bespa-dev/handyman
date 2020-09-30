import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/local_database.dart';
import 'package:meta/meta.dart';

class ChatHeader extends StatelessWidget {
  final Artisan artisan;

  const ChatHeader({Key key, @required this.artisan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Material(
      elevation: kSpacingX4,
      // shadowColor: kTransparent,
      type: MaterialType.card,
      child: Container(
        alignment: Alignment.bottomCenter,
        height: kSpacingX64,
        width: double.infinity,
        decoration: BoxDecoration(
          color: themeData.scaffoldBackgroundColor,
        ),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Feather.x),
              onPressed: () => context.navigator.pop(),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(kSpacingX8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      artisan?.name ?? "No name",
                      style: themeData.textTheme.headline6,
                    ),
                    SizedBox(height: getProportionateScreenHeight(kSpacingX4)),
                    Text(
                      artisan?.business ?? artisan?.email ?? "#unregistered",
                      style: themeData.textTheme.caption,
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: Icon(Entypo.dots_three_horizontal),
              onPressed: () {
                // TODO: Add action here
              },
            ),
          ],
        ),
      ),
    );
  }
}
