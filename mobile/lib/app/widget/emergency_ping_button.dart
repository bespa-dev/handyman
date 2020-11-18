import 'package:auto_route/auto_route.dart';
import 'package:contact_picker/contact_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/size_config.dart';
import "package:meta/meta.dart";
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class EmergencyPingButton extends StatefulWidget {
  final Widget child;

  const EmergencyPingButton({Key key, @required this.child}) : super(key: key);

  @override
  _EmergencyPingButtonState createState() => _EmergencyPingButtonState();
}

class _EmergencyPingButtonState extends State<EmergencyPingButton> {
  bool _isCalling = false;
  final ContactPicker _contactPicker = ContactPicker();
  ThemeData _themeData;

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);

    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
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
            width: SizeConfig.screenWidth,
            child: _buildEmergencyButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyButton() {
    final backgroundColor = !_isCalling
        ? _themeData.colorScheme.error
        : _themeData.disabledColor.withOpacity(kOpacityX14);
    final onBackgroundColor =
        !_isCalling ? _themeData.colorScheme.onError : _themeData.disabledColor;

    return Consumer<PrefsProvider>(
      builder: (_, provider, __) => GestureDetector(
        onTap: () => _contactEmergencyService(provider),
        child: AnimatedContainer(
          duration: kScaleDuration,
          alignment: Alignment.center,
          height: getProportionateScreenHeight(kToolbarHeight),
          width: SizeConfig.screenWidth,
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
                style: _themeData.textTheme.button.copyWith(
                  color: onBackgroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _contactEmergencyService(PrefsProvider provider) async {
    if (provider.emergencyContactNumber == null ||
        provider.emergencyContactNumber.isEmpty) {
      await showSlidingBottomSheet(context, builder: (context) {
        return SlidingSheetDialog(
          elevation: 8,
          cornerRadius: kSpacingX16,
          snapSpec: const SnapSpec(
            snap: true,
            snappings: [0.4, 0.7, 1.0],
            positioning: SnapPositioning.relativeToAvailableSpace,
          ),
          headerBuilder: (context, state) {
            return Container(
              height: kToolbarHeight,
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(
                'Emergency contact',
                style: _themeData.textTheme.headline6,
              ),
            );
          },
          footerBuilder: (context, state) {
            return GestureDetector(
              onTap: () {
                print("Emergency contact saved");
              },
              child: Container(
                height: kToolbarHeight,
                width: double.infinity,
                color: _themeData.colorScheme.secondary,
                alignment: Alignment.center,
                child: Text(
                  'This is the footer',
                  style: _themeData.textTheme.button,
                ),
              ),
            );
          },
          builder: (context, state) {
            return Container(
              height: SizeConfig.screenHeight * 0.3,
              child: Center(
                child: Material(
                  child: InkWell(
                    onTap: () => Navigator.pop(context, 'This is the result.'),
                    child: Padding(
                      padding: const EdgeInsets.all(kSpacingX16),
                      child: Text(
                        'This is the content of the sheet',
                        style: _themeData.textTheme.bodyText1,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      });
    } else {
      setState(() {
        _isCalling = !_isCalling;
      });
      print("Emergency service...");
      await Future.delayed(kTestDuration);
      setState(() {
        _isCalling = !_isCalling;
      });
    }
  }
}

/*
* ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              "Add an emergency contact in your profile settings page",
              style: TextStyle(
                color: themeData.colorScheme.onError,
              ),
            ),
            backgroundColor: themeData.colorScheme.error,
            behavior: SnackBarBehavior.floating,
            action: SnackBarAction(
              label: "Change".toUpperCase(),
              onPressed: () => context.navigator.push(Routes.profilePage),
            ),
          ),
        );
* */
