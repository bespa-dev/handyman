import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:handyman/app/widget/buttons.dart';
import 'package:handyman/core/size_config.dart';

class UserProfileCard extends StatefulWidget {
  final Function(bool, int) hasSelection;
  final List<String> profiles;
  final List<String> description;

  const UserProfileCard(
      {Key key, this.profiles, this.description, this.hasSelection})
      : super(key: key);

  @override
  _UserProfileCardState createState() => _UserProfileCardState();
}

class _UserProfileCardState extends State<UserProfileCard> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final kWidth = size.width;
    final kHeight = size.height;

    return Container(
      width: kWidth,
      child: CarouselSlider.builder(
        itemCount: widget.profiles.length,
        itemBuilder: (_, index) {
          return InkWell(
            onTap: () {
              widget.hasSelection(true, index);
            },
            borderRadius: BorderRadius.circular(24),
            child: Container(
              clipBehavior: Clip.hardEdge,
              height: kHeight * 0.3,
              width: kWidth,
              margin: EdgeInsets.only(right: getProportionateScreenWidth(24)),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: themeData.cardColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    padding:
                        EdgeInsets.only(top: getProportionateScreenHeight(36)),
                    color: themeData.accentColor.withOpacity(0.35),
                    child: Icon(
                      index == 0 ? Feather.user : Icons.handyman_outlined,
                      size: kHeight * 0.1,
                    ),
                  ),
                  Positioned(
                    top: kHeight * 0.18,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      color: themeData.scaffoldBackgroundColor.withOpacity(0.7),
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(24)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.profiles[index],
                            style: themeData.textTheme.headline5.copyWith(
                              fontFamily:
                                  themeData.textTheme.bodyText1.fontFamily,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: getProportionateScreenHeight(4)),
                          Text(
                            widget.description[index],
                            style: themeData.textTheme.bodyText1,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: getProportionateScreenHeight(12)),
                          ButtonOutlined(
                            width: kWidth * 0.3,
                            themeData: themeData,
                            onTap: () =>
                                _showLearnMoreFor(widget.profiles[index]),
                            label: "Learn more",
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        options: CarouselOptions(
          initialPage: 0,
          autoPlay: false,
          enableInfiniteScroll: false,
          height: kHeight * 0.35,
          aspectRatio: 16 / 9,
          onPageChanged: (index, _) => widget.hasSelection(false, index),
        ),
      ),
    );
  }

  void _showLearnMoreFor(String profile) async {
    // TODO: Show bottom sheet with information for current profile
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text("Feature unavailable"),
        behavior: SnackBarBehavior.floating,
      ));
  }
}
