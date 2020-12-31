import 'package:flutter/material.dart';
import 'package:lite/shared/shared.dart';


enum ButtonIconGravity { NONE, END, START }

class ButtonOutlined extends StatelessWidget {
  final String label;
  final double width;
  final double height;
  final IconData icon;
  final ThemeData themeData;
  final Function onTap;
  final bool enabled;
  final ButtonIconGravity gravity;

  const ButtonOutlined({
    Key key,
    @required this.width,
    @required this.themeData,
    @required this.onTap,
    @required this.label,
    this.height,
    this.icon,
    this.enabled = true,
    this.gravity = ButtonIconGravity.NONE,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: themeData.splashColor,
      onTap: enabled ? onTap : null,
      borderRadius:
          BorderRadius.circular(getProportionateScreenWidth(kSpacingX36)),
      child: AnimatedContainer(
        duration: kScaleDuration,
        curve: Curves.fastOutSlowIn,
        width: width,
        height: height ?? kMinInteractiveDimension,
        decoration: BoxDecoration(
          color: themeData.scaffoldBackgroundColor,
          border: Border.all(
            color: enabled
                ? themeData.colorScheme.primary
                : themeData.disabledColor,
          ),
          borderRadius:
              BorderRadius.circular(getProportionateScreenWidth(kSpacingX36)),
        ),
        child: Row(
          mainAxisAlignment: icon == null || gravity != ButtonIconGravity.NONE
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceBetween,
          children: [
            icon != null && gravity == ButtonIconGravity.START
                ? _buildIcon(icon)
                : SizedBox.shrink(),
            Text(
              label.toUpperCase(),
              style: themeData.textTheme.button.copyWith(
                color: enabled
                    ? themeData.colorScheme.primary
                    : themeData.disabledColor,
              ),
            ),
            icon != null && gravity == ButtonIconGravity.END
                ? _buildIcon(icon)
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(icon) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(kSpacingX8),
        ),
        child: Icon(
          icon,
          color:
              enabled ? themeData.colorScheme.primary : themeData.disabledColor,
        ),
      );
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
      splashColor: themeData.splashColor,
      onTap: onPressed,
      borderRadius: BorderRadius.circular(kToolbarHeight),
      child: Container(
        height: kToolbarHeight,
        width: kToolbarHeight,
        padding: const EdgeInsets.all(kSpacingX4),
        decoration: BoxDecoration(
          border: Border.all(color: color ?? themeData.colorScheme.primary),
          borderRadius: BorderRadius.circular(kToolbarHeight),
        ),
        alignment: Alignment.center,
        clipBehavior: Clip.hardEdge,
        child: Icon(icon, color: iconColor ?? themeData.colorScheme.primary),
      ),
    );
  }
}

class ButtonPrimary extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;
  final double width;
  final IconData icon;
  final ThemeData themeData;
  final Function onTap;
  final bool enabled;
  final ButtonIconGravity gravity;

  const ButtonPrimary({
    Key key,
    @required this.width,
    @required this.themeData,
    @required this.onTap,
    @required this.label,
    this.gravity = ButtonIconGravity.NONE,
    this.color,
    this.icon,
    this.textColor,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: themeData.splashColor,
      borderRadius:
          BorderRadius.circular(getProportionateScreenWidth(kSpacingX36)),
      onTap: enabled ? onTap : null,
      child: AnimatedContainer(
        duration: kScaleDuration,
        curve: Curves.fastOutSlowIn,
        width: width,
        height: kMinInteractiveDimension,
        decoration: BoxDecoration(
          color: enabled
              ? color ?? themeData.colorScheme.primary
              : themeData.disabledColor,
          borderRadius:
              BorderRadius.circular(getProportionateScreenWidth(kSpacingX36)),
        ),
        child: Row(
          mainAxisAlignment: icon == null || gravity != ButtonIconGravity.NONE
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceAround,
          children: [
            icon != null && gravity == ButtonIconGravity.START
                ? _buildIcon(icon)
                : SizedBox.shrink(),
            Text(
              label.toUpperCase(),
              style: themeData.textTheme.button.copyWith(
                color: textColor ?? themeData.colorScheme.onPrimary,
              ),
            ),
            icon != null && gravity == ButtonIconGravity.END
                ? _buildIcon(icon)
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(icon) => Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(kSpacingX16)),
        child: Icon(
          icon,
          color: textColor ?? themeData.colorScheme.onPrimary,
        ),
      );
}

class ButtonClear extends FlatButton {
  ButtonClear({
    @required String text,
    @required Function onPressed,
    @required ThemeData themeData,
    bool enabled = true,
    Color textColor,
    double preferredHeight,
    Color backgroundColor,
  }) : super(
          splashColor: themeData.splashColor,
          highlightColor: kTransparent,
          textColor: textColor,
          clipBehavior: Clip.hardEdge,
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: backgroundColor == null
                  ? null
                  : BorderRadius.circular(kSpacingX16),
            ),
            alignment: Alignment.center,
            height:
                preferredHeight ?? getProportionateScreenHeight(kSpacingX36),
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(kSpacingX8),
                vertical: getProportionateScreenHeight(kSpacingX8)),
            child: Text(
              text.toUpperCase(),
              style: themeData.textTheme.button.copyWith(
                color: textColor == null || !enabled
                    ? themeData.colorScheme.primary
                    : textColor ?? themeData.disabledColor,
              ),
            ),
          ),
          onPressed: enabled ? onPressed : null,
          color: enabled
              ? themeData.colorScheme.primary.withOpacity(kSpacingNone)
              : themeData.disabledColor,
          disabledColor:
              themeData.colorScheme.primary.withOpacity(kSpacingNone),
          disabledTextColor: themeData.disabledColor,
        );
}
