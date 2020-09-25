import 'package:flutter/material.dart';
import 'package:handyman/core/size_config.dart';

class ButtonOutlined extends StatelessWidget {
  const ButtonOutlined({
    Key key,
    @required this.width,
    @required this.themeData,
    @required this.onTap,
    @required this.label,
    this.icon,
  }) : super(key: key);

  final String label;
  final double width;
  final IconData icon;
  final ThemeData themeData;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(getProportionateScreenWidth(32)),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        width: width,
        height: kMinInteractiveDimension,
        decoration: BoxDecoration(
          color: themeData.scaffoldBackgroundColor,
          border: Border.all(
            color: themeData.scaffoldBackgroundColor,
          ),
          borderRadius: BorderRadius.circular(getProportionateScreenWidth(32)),
        ),
        child: Row(
          mainAxisAlignment: icon == null
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceAround,
          children: [
            Text(
              label.toUpperCase(),
              style: themeData.textTheme.button,
            ),
            icon == null
                ? SizedBox.shrink()
                : Icon(
                    icon,
                    color: themeData.textTheme.button.color,
                  ),
          ],
        ),
      ),
    );
  }
}

class ButtonIconOnly extends StatelessWidget {
  final IconData icon;
  final Function onPressed;
  final Color color;
  final Color iconColor;

  const ButtonIconOnly(
      {Key key,
      @required this.icon,
      @required this.onPressed,
      this.color,
      this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(kToolbarHeight),
      child: Container(
        height: kToolbarHeight,
        width: kToolbarHeight,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(color: color ?? themeData.accentColor),
          borderRadius: BorderRadius.circular(kToolbarHeight),
        ),
        alignment: Alignment.center,
        clipBehavior: Clip.hardEdge,
        child: Icon(icon, color: iconColor ?? themeData.accentColor),
      ),
    );
  }
}

class ButtonPrimary extends StatelessWidget {
  const ButtonPrimary({
    Key key,
    @required this.width,
    @required this.themeData,
    @required this.onTap,
    @required this.label,
    this.color,
    this.icon,
    this.textColor,
  }) : super(key: key);

  final String label;
  final Color color;
  final Color textColor;
  final double width;
  final IconData icon;
  final ThemeData themeData;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(getProportionateScreenWidth(32)),
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        width: width,
        height: kMinInteractiveDimension,
        decoration: BoxDecoration(
          color: color ?? themeData.primaryColor,
          borderRadius: BorderRadius.circular(getProportionateScreenWidth(32)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label.toUpperCase(),
              style: themeData.textTheme.button.copyWith(
                color: textColor ?? Colors.white,
              ),
            ),
            icon == null
                ? SizedBox.shrink()
                : Padding(
              padding: const EdgeInsets.only(
                left: 24,
              ),
              child: Icon(
                icon,
                color: textColor ?? Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonClear extends FlatButton {
  ButtonClear({
    @required String text,
    @required Function onPressed,
    @required ThemeData themeData,
    bool enabled = true,
    Color textColor,
  }) : super(
          child: Text(
            text.toUpperCase(),
            style: themeData.textTheme.button.copyWith(
              color: textColor == null || !enabled
                  ? themeData.accentColor
                  : textColor ?? themeData.disabledColor,
            ),
          ),
          onPressed: enabled ? onPressed : null,
          color: enabled
              ? themeData.accentColor.withOpacity(0)
              : themeData.disabledColor,
          disabledColor: themeData.accentColor.withOpacity(0),
          disabledTextColor: themeData.disabledColor,
        );
}
