import 'package:flutter/material.dart';
import 'package:handyman/shared/shared.dart';

/// Google play store style notification header
class NotificationContainer extends StatefulWidget {
  const NotificationContainer({
    @required this.title,
    @required this.description,
    this.icon = kNotificationIcon,
    this.background,
    this.border,
    this.buttonText = 'Dismiss',
    this.onTap,
    this.buttonTextColor,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color background;
  final Color border;
  final Color buttonTextColor;
  final String buttonText;
  final Function onTap;

  @override
  _NotificationContainerState createState() => _NotificationContainerState();
}

class _NotificationContainerState extends State<NotificationContainer> {
  @override
  Widget build(BuildContext context) {
    var kTheme = Theme.of(context);

    return Container(
      width: SizeConfig.screenWidth,
      margin: EdgeInsets.only(
        bottom: kSpacingX12,
        left: kSpacingX12,
        right: kSpacingX12,
      ),
      decoration: BoxDecoration(
        color: widget.background ?? kTheme.colorScheme.background,
        borderRadius: BorderRadius.circular(kSpacingX8),
        border: Border.all(
          color: widget.border ?? kTheme.colorScheme.onBackground,
        ),
      ),
      padding:
          EdgeInsets.symmetric(vertical: kSpacingX12, horizontal: kSpacingX16),
      child: Column(
        children: [
          /// title & icon
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// icon
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kSpacingX4),
                  color: kTheme.colorScheme.secondary.withOpacity(kEmphasisLow),
                ),
                padding: EdgeInsets.all(kSpacingX12),
                margin: EdgeInsets.only(right: kSpacingX12),
                child: Icon(
                  widget.icon,
                  size: kSpacingX20,
                  color: kTheme.colorScheme.onSecondary,
                ),
              ),

              /// title
              Expanded(
                child: Text(
                  widget.title,
                  style: kTheme.textTheme.headline6
                      .copyWith(fontSize: kSpacingX16),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: kSpacingX12, bottom: kSpacingX12),
            child: Text(
              widget.description,
              style: kTheme.textTheme.subtitle2,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              splashColor: kTheme.splashColor,
              borderRadius: BorderRadius.circular(kSpacingX4),
              onTap: widget.onTap,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kSpacingX4),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: kSpacingX8,
                  horizontal: kSpacingX12,
                ),
                child: Text(
                  widget.buttonText,
                  style: kTheme.textTheme.button.copyWith(
                    color: widget.buttonTextColor ??
                        kTheme.colorScheme.secondary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
