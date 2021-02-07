import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lite/app/widgets/widgets.dart';
import 'package:lite/shared/shared.dart';

/// width of dialogs
final _kDialogWidth = SizeConfig.screenWidth * 0.8;
final _kDialogMaxHeight = SizeConfig.screenHeight * 0.3;

/// 1. basic dialog with [title] & [message]
class BasicDialog extends StatelessWidget {
  final String title;
  final String message;
  final String positiveButtonText;
  final String negativeButtonText;
  final Function onComplete;

  const BasicDialog({
    Key key,
    @required this.message,
    @required this.onComplete,
    this.title = "Confirm action",
    this.positiveButtonText = "Confirm",
    this.negativeButtonText = "Cancel",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final kTheme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: kSpacingX20),
          child: Text(
            title,
            style: kTheme.textTheme.headline6,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: kSpacingX36),
          child: Text(
            message,
            style: kTheme.textTheme.bodyText1,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _CustomDialogButton(
              label: negativeButtonText,
              onTap: () => context.navigator.pop(false),
              isPrimary: false,
            ),
            _CustomDialogButton(
              label: positiveButtonText,
              onTap: () {
                onComplete();
                context.navigator.pop(true);
              },
              isPrimary: true,
            ),
          ],
        )
      ],
    );
  }
}

/// 2. info dialog with [title] & [message]
class InfoDialog extends StatelessWidget {
  final String title;
  final Widget message;
  final String buttonText;

  const InfoDialog({
    Key key,
    @required this.title,
    @required this.message,
    this.buttonText = "Got it",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final kTheme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: kSpacingX20),
          child: Text(
            title,
            style: kTheme.textTheme.headline6,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: kSpacingX36),
          child: message,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _CustomDialogButton(
              label: buttonText,
              onTap: () {
                context.navigator.pop(true);
              },
              isPrimary: true,
            ),
          ],
        )
      ],
    );
  }
}

/// 2. dialog with [controller] for editing text
class ReplyMessageDialog extends StatelessWidget {
  final String title;
  final String hintText;
  final int maxLines;
  final TextEditingController controller;

  const ReplyMessageDialog({
    Key key,
    @required this.title,
    @required this.controller,
    this.hintText = "What\'s on your mind?",
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final kTheme = Theme.of(context);
    return Container(
      constraints: BoxConstraints(maxHeight: _kDialogMaxHeight),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: kSpacingX20),
            child: Text(
              title,
              style: kTheme.textTheme.headline6,
            ),
          ),
          Form(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: kSpacingX16,
              ),
              decoration: BoxDecoration(
                color: kTheme.disabledColor,
                borderRadius: BorderRadius.circular(kSpacingX12),
              ),
              clipBehavior: Clip.hardEdge,
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                  fillColor: kTheme.disabledColor,
                  filled: true,
                ),
              ),
            ),
          ),
          SizedBox(height: kSpacingX36),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _CustomDialogButton(
                label: "Cancel",
                onTap: () => context.navigator.pop(),
                isPrimary: false,
              ),
              _CustomDialogButton(
                label: "Confirm",
                onTap: () => context.navigator.pop(controller.text?.trim()),
                isPrimary: true,
              ),
            ],
          )
        ],
      ),
    );
  }
}

/// 3a. picker menu item
class PickerMenuItem {
  final String title;
  final IconData icon;
  final Key key;

  const PickerMenuItem({
    this.key,
    @required this.title,
    @required this.icon,
  }) : super();

  @override
  String toString() => "{title : $title}";
}

/// 3b. menu item selection enabled dialog using [PickerMenuItem]
class MenuItemPickerDialog extends StatefulWidget {
  final String title;
  final String message;
  final Function(PickerMenuItem) onComplete;
  final List<PickerMenuItem> items;

  const MenuItemPickerDialog({
    Key key,
    @required this.title,
    @required this.onComplete,
    @required this.items,
    this.message = "",
  })  : assert(items is List<PickerMenuItem>),
        super(key: key);

  @override
  _MenuItemPickerDialogState createState() => _MenuItemPickerDialogState();
}

class _MenuItemPickerDialogState extends State<MenuItemPickerDialog> {
  PickerMenuItem _selectedItem;

  @override
  void initState() {
    super.initState();
    if (mounted) _selectedItem = widget.items.first;
  }

  @override
  Widget build(BuildContext context) {
    final kTheme = Theme.of(context);
    final items = widget.items;

    return Container(
      constraints: BoxConstraints(maxHeight: _kDialogMaxHeight),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: kSpacingX20),
            child: Text(
              widget.title,
              style: kTheme.textTheme.headline6,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: kSpacingX16),
            child: Text(
              widget.message,
              style: kTheme.textTheme.bodyText1,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: kSpacingX16,
            ),
            constraints: BoxConstraints.tightFor(width: _kDialogWidth),
            decoration: BoxDecoration(
              color: kTheme.disabledColor,
              borderRadius: BorderRadius.circular(kSpacingX12),
            ),
            clipBehavior: Clip.hardEdge,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(_selectedItem.icon),
                      SizedBox(width: kSpacingX24),
                      Text(_selectedItem.title),
                    ],
                  ),
                ),
                PopupMenuButton(
                  icon: Icon(Icons.arrow_drop_down),
                  itemBuilder: (_) => [
                    for (int index = 0; index < items.length; index++) ...{
                      PopupMenuItem(
                        child: Text(items[index].title),
                        value: items[index],
                      )
                    },
                  ],
                  onSelected: (item) {
                    _selectedItem = item;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: kSpacingX36),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _CustomDialogButton(
                label: "Cancel",
                onTap: () => context.navigator.pop(),
                isPrimary: false,
              ),
              _CustomDialogButton(
                label: "Confirm",
                onTap: () {
                  widget.onComplete(_selectedItem);
                  context.navigator.pop();
                },
                isPrimary: true,
              ),
            ],
          )
        ],
      ),
    );
  }
}

/// 4. dialog with checked button
class CheckableBasicDialog extends StatefulWidget {
  final String title;
  final String message;
  final Function(bool) onComplete;

  const CheckableBasicDialog({
    Key key,
    @required this.message,
    @required this.onComplete,
    this.title = "Confirm action",
  }) : super(key: key);

  @override
  _CheckableBasicDialogState createState() => _CheckableBasicDialogState();
}

class _CheckableBasicDialogState extends State<CheckableBasicDialog> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    final kTheme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: kSpacingX20),
          child: Text(
            widget.title,
            style: kTheme.textTheme.headline6,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: kSpacingX16),
          child: Text(
            widget.message,
            style: kTheme.textTheme.bodyText1,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: kSpacingX36),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                value: _isChecked,
                onChanged: (checked) {
                  _isChecked = checked;
                  setState(() {});
                },
              ),
              SizedBox(width: kSpacingX4),
              Text(
                "Do not show it anymore",
                style: kTheme.textTheme.headline6.copyWith(
                  fontSize: kTheme.textTheme.bodyText1.fontSize,
                  fontWeight: kTheme.textTheme.button.fontWeight,
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _CustomDialogButton(
              label: "Cancel",
              onTap: () => context.navigator.pop(),
              isPrimary: false,
            ),
            _CustomDialogButton(
              label: "Confirm",
              onTap: () {
                widget.onComplete(_isChecked);
                context.navigator.pop();
              },
              isPrimary: true,
            ),
          ],
        )
      ],
    );
  }
}

/// 5. dialog with image (e.g. for tutorials)
class ImageViewDialog extends StatelessWidget {
  final String title;
  final String message;
  final String imageUrl;
  final bool isAssetImage;
  final Function onComplete;

  const ImageViewDialog({
    Key key,
    @required this.message,
    @required this.onComplete,
    @required this.imageUrl,
    this.title = "Confirm action",
    this.isAssetImage = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final kTheme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            maxHeight: _kDialogMaxHeight,
          ),
          padding: EdgeInsets.only(bottom: kSpacingX2),
          child: isAssetImage
              ? Image.asset(
                  imageUrl,
                  width: _kDialogWidth,
                  fit: BoxFit.contain,
                )
              : ImageView(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
            kSpacingX16,
            kSpacingX24,
            kSpacingX16,
            kSpacingX20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: kSpacingX20),
                child: Text(
                  title,
                  style: kTheme.textTheme.headline6,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: kSpacingX36),
                child: Text(
                  message,
                  style: kTheme.textTheme.bodyText1,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _CustomDialogButton(
                    label: "Cancel",
                    onTap: () => context.navigator.pop(),
                    isPrimary: false,
                  ),
                  _CustomDialogButton(
                    label: "Confirm",
                    onTap: () {
                      onComplete();
                      context.navigator.pop();
                    },
                    isPrimary: true,
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _CustomDialogButton extends StatelessWidget {
  final String label;
  final Function onTap;
  final bool isPrimary;

  const _CustomDialogButton({
    Key key,
    @required this.label,
    @required this.onTap,
    @required this.isPrimary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final kTheme = Theme.of(context);

    return GestureDetector(
      child: Container(
        clipBehavior: Clip.hardEdge,
        padding: EdgeInsets.symmetric(
          horizontal: kSpacingX24,
          vertical: kSpacingX12,
        ),
        width: SizeConfig.screenWidth * 0.35,
        decoration: BoxDecoration(
          color: isPrimary ? kTheme.colorScheme.secondary : kTheme.cardColor,
          borderRadius: BorderRadius.circular(kSpacingX8),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: kTheme.textTheme.headline6.copyWith(
            fontSize: kTheme.textTheme.button.fontSize,
            color: isPrimary
                ? kTheme.colorScheme.onSecondary
                : kTheme.iconTheme.color,
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}

/// call this method to show a custom dialog
///
/// must provide [isImageDialog] when dialog child is [ImageViewDialog]
Future<T> showCustomDialog<T>({
  @required BuildContext context,
  @required WidgetBuilder builder,
  RouteSettings routeSettings,
  bool isImageDialog = false,
  bool shouldDismissOnBarrierTap = false,
}) {
  // final CapturedThemes themes = InheritedTheme.capture(
  //     from: context, to: Navigator.of(context, rootNavigator: true).context);
  return showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      final kTheme = Theme.of(context);
      final Widget pageChild = Builder(builder: builder);
      Widget dialog = Builder(
          builder: (BuildContext context) {
            return kTheme != null
                ? Theme(data: kTheme, child: pageChild)
                : pageChild;
          }
      );
      final contentPadding = EdgeInsets.fromLTRB(
        kSpacingX16,
        kSpacingX24,
        kSpacingX16,
        kSpacingX20,
      );
      dialog = Stack(
        children: <Widget>[
          // 1. blurred background
          GestureDetector(
            onTap: shouldDismissOnBarrierTap
                ? () => context.navigator.pop()
                : null,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: kBlurSigma, sigmaY: kBlurSigma),
              child: Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight,
                decoration: BoxDecoration(
                  color:
                      kTheme.colorScheme.background.withOpacity(kEmphasisLow),
                ),
              ),
            ),
          ),
          // 2. dialog builder
          Positioned(
            top: SizeConfig.screenHeight * 0.2,
            left: SizeConfig.screenWidth * 0.1,
            right: SizeConfig.screenWidth * 0.1,
            child: Material(
              clipBehavior: Clip.hardEdge,
              type: MaterialType.card,
              elevation: kSpacingX2,
              borderRadius: BorderRadius.circular(kSpacingX16),
              child: Container(
                padding: isImageDialog ? EdgeInsets.zero : contentPadding,
                clipBehavior: Clip.hardEdge,
                width: _kDialogWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kSpacingX16),
                  color: kTheme.cardColor,
                ),
                child: dialog,
              ),
            ),
          ),
        ],
      );
      return dialog;
    },
    barrierDismissible: false,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor:
        Theme.of(context).colorScheme.background.withOpacity(kOpacityX14),
    transitionDuration: kDialogTransitionDuration,
    transitionBuilder: _buildMaterialDialogTransitions,
    useRootNavigator: true,
    routeSettings: routeSettings,
  );
}

Widget _buildMaterialDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return FadeTransition(
    opacity: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: child,
  );
}
