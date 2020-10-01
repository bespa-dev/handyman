import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/widget/artisan_card.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/service_locator.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/provider/artisan_api_provider.dart';
import 'package:handyman/domain/models/user.dart';
import 'package:provider/provider.dart';

class SearchPage extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) => <Widget>[
        IconButton(
          icon: Icon(Feather.x),
          onPressed: () {
            query = "";
            showSuggestions(context);
          },
        )
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: Icon(Icons.keyboard_backspace),
        onPressed: () => this.close(context, []),
      );

  @override
  Widget buildResults(BuildContext context) {
    final themeData = Theme.of(context);

    return FutureBuilder<List<BaseUser>>(
        future: sl.get<ApiProviderService>().searchFor(value: query.trim()),
        initialData: <BaseUser>[],
        builder: (context, snapshot) {
          final artisans = snapshot.data;
          if (snapshot.hasError || artisans.isEmpty)
            return Center(
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "No results found for\n",
                        style: themeData.textTheme.bodyText1,
                      ),
                      TextSpan(
                        text: "\"$query\"",
                        style: themeData.textTheme.headline6.copyWith(
                          color: themeData.primaryColor,
                          fontFamily: themeData.textTheme.bodyText1.fontFamily,
                        ),
                      ),
                    ],
                  )),
            );
          else {
            return ListView.separated(
              clipBehavior: Clip.hardEdge,
              physics: kScrollPhysics,
              itemBuilder: (_, index) => AnimationConfiguration.staggeredList(
                position: index,
                duration: kScaleDuration,
                child: SlideAnimation(
                  verticalOffset: kSlideOffset,
                  child: FadeInAnimation(
                    child: ListArtisanCardItem(
                      artisan: artisans[index],
                    ),
                  ),
                ),
              ),
              separatorBuilder: (_, __) =>
                  SizedBox(height: getProportionateScreenHeight(kSpacingX2)),
              itemCount: artisans.length ?? 0,
            );
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) => SizedBox.shrink();

  @override
  ThemeData appBarTheme(BuildContext context) {
    final bool isLightTheme = Provider.of<PrefsProvider>(context).isLightTheme;
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: theme.primaryColor,
      primaryIconTheme:
          theme.primaryIconTheme.copyWith(color: theme.colorScheme.onPrimary),
      primaryColorBrightness: theme.brightness,
      primaryTextTheme: theme.textTheme,
    );
  }
}
