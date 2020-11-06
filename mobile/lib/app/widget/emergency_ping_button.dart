import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/size_config.dart';
import "package:meta/meta.dart";

class EmergencyPingButton extends StatefulWidget {
  final Widget child;

  const EmergencyPingButton({Key key, @required this.child}) : super(key: key);

  @override
  _EmergencyPingButtonState createState() => _EmergencyPingButtonState();
}

class _EmergencyPingButtonState extends State<EmergencyPingButton> {
  bool _isCalling = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: EdgeInsets.only(
              bottom: getProportionateScreenHeight(kSpacingX64),
            ),
            child: widget.child,
          ),
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom,
            width: size.width,
            child: _buildEmergencyButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyButton() {
    final size = MediaQuery.of(context).size;
    final themeData = Theme.of(context);
    final backgroundColor = !_isCalling
        ? themeData.colorScheme.error
        : themeData.disabledColor.withOpacity(kOpacityX14);
    final onBackgroundColor =
        !_isCalling ? themeData.colorScheme.onError : themeData.disabledColor;

    return GestureDetector(
      onTap: _contactEmergencyService,
      child: AnimatedContainer(
        duration: kScaleDuration,
        alignment: Alignment.center,
        height: getProportionateScreenHeight(kToolbarHeight),
        width: size.width,
        decoration: BoxDecoration(
          color: backgroundColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _isCalling ? Feather.phone_call : Feather.phone,
              color: onBackgroundColor,
            ),
            SizedBox(
              width: getProportionateScreenWidth(kSpacingX16),
            ),
            Text(
              _isCalling ? "Calling..." : "In trouble? Call for help now",
              style: themeData.textTheme.button.copyWith(
                color: onBackgroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _contactEmergencyService() async {
    setState(() {
      _isCalling = !_isCalling;
    });
    print("Emergency service...");
    // TODO: Send a notification to emergency service
    await Future.delayed(kTestDuration);
    setState(() {
      _isCalling = !_isCalling;
    });
  }
}