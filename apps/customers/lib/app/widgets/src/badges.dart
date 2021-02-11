import 'package:flutter/material.dart';
import 'package:lite/shared/shared.dart';

class BadgedIconButton extends StatefulWidget {
  const BadgedIconButton({
    Key key,
    @required this.icon,
    @required this.onPressed,
    this.color,
    this.badgeColor,
    this.onBadgeColor,
    this.count = 0,
    this.isAlert = false,
    this.size = kToolbarHeight,
  }) : super(key: key);

  final Icon icon;
  final Function onPressed;
  final Color color;
  final Color badgeColor;
  final Color onBadgeColor;
  final int count;
  final double size;
  final bool isAlert;

  @override
  _BadgedIconButtonState createState() => _BadgedIconButtonState();
}

class _BadgedIconButtonState extends State<BadgedIconButton> {
  var _showBadge = false;

  @override
  void initState() {
    super.initState();

    if (mounted) {
      _showBadge = widget.isAlert || widget.count > 0;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var kTheme = Theme.of(context);

    return InkWell(
      splashColor: kTheme.splashColor,
      borderRadius: BorderRadius.circular(widget.size / 2),
      onTap: () {
        _showBadge = false;
        setState(() {});
        widget.onPressed();
      },
      child: Container(
        width: kToolbarHeight,
        height: kToolbarHeight,
        padding: EdgeInsets.all(widget.size * 0.25),
        child: Stack(
          clipBehavior: Clip.none,
          overflow: Overflow.visible,
          children: [
            /// icon
            Positioned.fill(
              child: Icon(
                widget.icon.icon,
                color: widget.color ?? kTheme.iconTheme.color,
                size: widget.size / 2,
              ),
            ),

            /// badge
            if (_showBadge) ...{
              if (widget.count > 0) ...{
                Positioned(
                  top: -kSpacingX4,
                  right: -kSpacingX12,
                  child: Container(
                    padding: EdgeInsets.all(kSpacingX2),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: widget.count < 100
                          ? BoxShape.circle
                          : BoxShape.rectangle,
                      color: widget.badgeColor ?? kTheme.colorScheme.secondary,
                      borderRadius: widget.count < 100
                          ? null
                          : BorderRadius.circular(kSpacingX4),
                    ),
                    child: Text(
                      '${widget.count < 100 ? widget.count : '99+'}',
                      style: kTheme.textTheme.caption.copyWith(
                        color: widget.onBadgeColor ??
                            kTheme.colorScheme.onSecondary,
                        fontWeight: kTheme.textTheme.button.fontWeight,
                      ),
                    ),
                  ),
                ),
              } else if (widget.isAlert) ...{
                Positioned(
                  top: -kSpacingX4,
                  right: -kSpacingX6,
                  child: Container(
                    height: kSpacingX8,
                    width: kSpacingX8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.badgeColor ?? kTheme.colorScheme.secondary,
                    ),
                  ),
                ),
              }
            }
          ],
        ),
      ),
    );
  }
}
