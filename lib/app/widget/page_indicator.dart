import 'package:flutter/material.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/size_config.dart';
import 'package:meta/meta.dart';

import 'buttons.dart';

/// Page indicator
class PageIndicator extends StatefulWidget {
  final int pages; // Number of pages
  final String skipLabel; // Text for skip button
  final Function onSkipTap; // Skip button click action
  final int currentPage;
  final bool showSkip;

  const PageIndicator(
      {@required this.pages,
      this.skipLabel = "Skip",
      this.onSkipTap,
      @required this.currentPage,
      this.showSkip = true});

  @override
  _PageIndicatorState createState() => _PageIndicatorState();
}

class _PageIndicatorState extends State<PageIndicator> {
  ThemeData _themeData;

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding:
              EdgeInsets.only(left: getProportionateScreenWidth(kSpacingX24)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildPageIndicator(),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          child: widget.showSkip
              ? ButtonOutlined(
                  width: MediaQuery.of(context).size.width * 0.35,
                  label: widget.skipLabel,
                  onTap: () => widget.onSkipTap ?? null,
                  themeData: _themeData)
              : SizedBox(),
        ),
      ],
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < widget.pages; i++) {
      list.add(i == widget.currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) => AnimatedContainer(
        duration: kScaleDuration,
        margin: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(kSpacingX4),
        ),
        height: getProportionateScreenHeight(kSpacingX8),
        width: isActive
            ? getProportionateScreenWidth(kSpacingX24)
            : getProportionateScreenWidth(kSpacingX16),
        decoration: BoxDecoration(
          color: isActive ? _themeData.primaryColor : _themeData.disabledColor,
          borderRadius: BorderRadius.all(
            Radius.circular(getProportionateScreenWidth(kSpacingX12)),
          ),
        ),
      );
}
