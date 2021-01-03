/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:auto_route/auto_route.dart';
import 'package:contact_picker/contact_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:handyman/domain/repositories/repositories.dart';
import 'package:handyman/shared/shared.dart';
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
  final _sheetController = SheetController();

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

    return Consumer<BasePreferenceRepository>(
      builder: (_, provider, __) => GestureDetector(
        onTap: () => _contactEmergencyService(provider),
        child: AnimatedContainer(
          duration: kScaleDuration,
          alignment: Alignment.center,
          height: getProportionateScreenHeight(kToolbarHeight),
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(color: backgroundColor),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Feather.phone,
                color: onBackgroundColor,
              ),
              SizedBox(
                width: getProportionateScreenWidth(kSpacingX16),
              ),
              Text(
                "In trouble? Call for help now".toUpperCase(),
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

  void _contactEmergencyService(BasePreferenceRepository provider) async {
    final backgroundColor = !_isCalling
        ? _themeData.colorScheme.error
        : _themeData.disabledColor.withOpacity(kOpacityX14);
    final onBackgroundColor =
        !_isCalling ? _themeData.colorScheme.onError : _themeData.disabledColor;

    await showSlidingBottomSheet(context, builder: (context) {
      return SlidingSheetDialog(
        elevation: kSpacingX8,
        controller: _sheetController,
        cornerRadius: kSpacingX16,
        snapSpec: const SnapSpec(
          snap: true,
          snappings: [0.4, 0.7, 1.0],
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        headerBuilder: (context, state) {
          return Container(
            height: kToolbarHeight,
            width: SizeConfig.screenWidth,
            alignment: Alignment.center,
            child: Text(
              'Your Emergency Contact Info',
              style: _themeData.textTheme.headline6,
            ),
          );
        },
        footerBuilder: (context, state) {
          return GestureDetector(
            onTap: () async {
              if (provider.emergencyContactNumber != null) {
                // TODO: Add emergency calling API here
                // _isCalling = !_isCalling;
                // _sheetController.rebuild();
                // await Future.delayed(kScaleDuration);
                launchUrl(url: "tel:${provider.emergencyContactNumber}");
                // _isCalling = !_isCalling;
              }
            },
            child: Container(
              height: kToolbarHeight,
              width: SizeConfig.screenWidth,
              decoration: BoxDecoration(color: backgroundColor),
              alignment: Alignment.center,
              child: Text(
                "Call now".toUpperCase(),
                style: _themeData.textTheme.button
                    .copyWith(color: onBackgroundColor),
              ),
            ),
          );
        },
        builder: (context, state) {
          return Material(
            child: Container(
              width: SizeConfig.screenWidth,
              padding: EdgeInsets.all(kSpacingX16),
              child: ListTile(
                onTap: () async {
                  Contact contact = await _contactPicker.selectContact();
                  provider.emergencyContactNumber = contact.phoneNumber.number;
                  _sheetController.rebuild();
                },
                title: Text("Emergency Contact"),
                subtitle: Text(provider.emergencyContactNumber ??
                    "Select an emergency contact"),
                leading: Icon(Feather.users),
              ),
            ),
          );
        },
      );
    });
  }
}
