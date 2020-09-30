import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:handyman/app/widget/buttons.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/core/utils.dart';
import 'package:meta/meta.dart';

enum InputSelector { NONE, MAP, DM, EMOJI, PHONE, PICTURE }

enum EmojiStickerSelector { EMOJI, STICKER }

/// User message input area with options
class UserInput extends StatefulWidget {
  final Function(String) onMessageSent;

  const UserInput({Key key, @required this.onMessageSent}) : super(key: key);

  @override
  _UserInputState createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  var currentInputSelector = InputSelector.NONE;
  bool dismissKeyboard = false;
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        child: Column(
          children: [
            Divider(
              height: kSpacingNone,
              color: Theme.of(context).disabledColor.withOpacity(kOpacityX70),
            ),
            _UserInputText(
              textController: textController,
              keyboardShown: !dismissKeyboard,
              onTextFieldFocused: (focused) {
                dismissKeyboard = !focused;
                currentInputSelector = InputSelector.NONE;
                setState(() {});
                // TODO: Show or hide keyboard here
              },
              focusState: !dismissKeyboard,
            ),
            _UserInputSelector(
              onSelectorChange: (selector) {
                currentInputSelector = selector;
                dismissKeyboard = true;
                setState(() {});
                // TODO: Show keyboard here
              },
              sendMessageEnabled: textController.text.isNotEmpty,
              onMessageSent: () {
                widget.onMessageSent(textController.text.trim());
                textController.clear();
                setState(() {});
              },
              currentInputSelector: currentInputSelector,
            ),
            _SelectorExpanded(
              onCloseRequested: (requestClose) {
                if (requestClose) currentInputSelector = InputSelector.NONE;
                setState(() {});
                // TODO: Hide keyboard here
              },
              onTextAdded: (text) {
                textController.text += text;
                setState(() {});
              },
              currentSelector: currentInputSelector,
            ),
          ],
        ),
      );
}

/// Input box for user messages
class _UserInputText extends StatefulWidget {
  final TextInputType keyboardType;
  final bool keyboardShown;
  final Function(bool) onTextFieldFocused;
  final bool focusState;
  final TextEditingController textController;

  const _UserInputText(
      {Key key,
      @required this.keyboardShown,
      @required this.onTextFieldFocused,
      @required this.focusState,
      this.keyboardType = TextInputType.text,
      this.textController})
      : super(key: key);

  @override
  __UserInputTextState createState() => __UserInputTextState();
}

class __UserInputTextState extends State<_UserInputText> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: getProportionateScreenWidth(kSpacingX16)),
      height: getProportionateScreenHeight(kSpacingX48),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Say something...",
          hintStyle: TextStyle(color: themeData.disabledColor),
        ),
        textAlign: TextAlign.start,
        keyboardType: widget.keyboardType,
        onFieldSubmitted: (value) {},
        onChanged: (_) {
          widget.onTextFieldFocused(_.isNotEmpty);
        },
        controller: widget.textController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        autocorrect: true,
        textInputAction: TextInputAction.send,
        onTap: () => widget.onTextFieldFocused(true),
      ),
    );
  }
}

/// User [InputSelector] (Emoji, Map, Image, Direct Message (email), Phone)
class _UserInputSelector extends StatelessWidget {
  final Function(InputSelector) onSelectorChange;
  final bool sendMessageEnabled;
  final Function onMessageSent;
  final InputSelector currentInputSelector;

  const _UserInputSelector(
      {Key key,
      @required this.onSelectorChange,
      @required this.sendMessageEnabled,
      @required this.onMessageSent,
      @required this.currentInputSelector})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      height: kToolbarHeight,
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(kSpacingX4)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _InputSelectorButton(
            onClick: () => onSelectorChange(InputSelector.EMOJI),
            icon: Icons.mood_outlined,
            selected: currentInputSelector == InputSelector.EMOJI,
          ),
          _InputSelectorButton(
            onClick: () => onSelectorChange(InputSelector.DM),
            icon: Feather.at_sign,
            selected: currentInputSelector == InputSelector.DM,
          ),
          _InputSelectorButton(
            onClick: () => onSelectorChange(InputSelector.PICTURE),
            icon: Feather.image,
            selected: currentInputSelector == InputSelector.PICTURE,
          ),
          _InputSelectorButton(
            onClick: () => onSelectorChange(InputSelector.MAP),
            icon: Icons.place_outlined,
            selected: currentInputSelector == InputSelector.MAP,
          ),
          _InputSelectorButton(
            onClick: () => onSelectorChange(InputSelector.PHONE),
            icon: Feather.phone,
            selected: currentInputSelector == InputSelector.PHONE,
          ),
          sendMessageEnabled ? SizedBox.shrink() : Divider(),
          Spacer(flex: 1),
          ButtonOutlined(
            width: getProportionateScreenWidth(kSpacingX96),
            themeData: themeData,
            onTap: onMessageSent,
            height: getProportionateScreenHeight(kSpacingX36),
            enabled: sendMessageEnabled,
            label: "Send",
          ),
        ],
      ),
    );
  }
}

class _InputSelectorButton extends StatelessWidget {
  final Function onClick;
  final IconData icon;
  final bool selected;
  final String tooltip;

  const _InputSelectorButton(
      {Key key,
      @required this.onClick,
      @required this.icon,
      @required this.selected,
      this.tooltip = "input button option"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return IconButton(
      icon: Icon(icon),
      onPressed: onClick,
      tooltip: tooltip,
      iconSize: kSpacingX20,
      color: selected ? themeData.primaryColor : themeData.disabledColor,
    );
  }
}

/// Area when [InputSelector] is picked
class _SelectorExpanded extends StatelessWidget {
  final Function(bool) onCloseRequested;
  final Function(String) onTextAdded;
  final InputSelector currentSelector;

  const _SelectorExpanded(
      {Key key,
      @required this.onCloseRequested,
      @required this.onTextAdded,
      @required this.currentSelector})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        currentSelector == InputSelector.EMOJI
            ? _buildEmojiSelector(context)
            : currentSelector == InputSelector.MAP
                ? _buildMapPanel()
                : currentSelector == InputSelector.NONE
                    ? SizedBox.shrink()
                    : _buildFunctionalityNotAvailablePanel(context),
        _buildHideUIPanel(context),
      ],
    );
  }

  Widget _buildHideUIPanel(BuildContext context) => Container(
        alignment: Alignment.center,
        child: currentSelector != InputSelector.NONE
            ? IconButton(
                icon: Icon(Feather.chevron_down),
                onPressed: () => onCloseRequested(true))
            : SizedBox.shrink(),
      );

  Widget _buildEmojiSelector(context) => Container(
        height: kSpacingX320,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ExtendedSelectorInnerButton(
                  text: "Emoji",
                  onClick: () {
                    // TODO: Show emojis
                  },
                  selected: true,
                ),
                _ExtendedSelectorInnerButton(
                  text: "Stickers",
                  onClick: () => Scaffold.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text("This feature is unavailable"),
                        behavior: SnackBarBehavior.floating,
                      ),
                    ),
                  selected: false,
                ),
              ],
            ),
            Container(
              width: double.infinity,
              child: _EmojiTable(
                onTextAdded: (text) {
                  onTextAdded(text);
                },
              ),
            ),
          ],
        ),
      );

  Widget _buildMapPanel() => Container(
        height: kSpacingX320,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(5.11, -0.12),
            zoom: 18.0,
          ),
          onTap: (address) {
            debugPrint("tapped on -> ${address.toString()}");
          },
        ),
      );

  Widget _buildFunctionalityNotAvailablePanel(BuildContext context) =>
      Container(
        height: kSpacingX320,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Functionality currently not available",
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: getProportionateScreenHeight(kSpacingX12)),
            Text(
              "Grab a beverage and check back later!",
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
}

/// Inner button for [EmojiStickerSelector]
class _ExtendedSelectorInnerButton extends StatelessWidget {
  final String text;
  final Function onClick;
  final bool selected;

  const _ExtendedSelectorInnerButton(
      {Key key,
      @required this.text,
      @required this.onClick,
      @required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final backgroundColor = selected
        ? themeData.colorScheme.secondary.withOpacity(kOpacityX70)
        : kTransparent;
    final color = selected
        ? themeData.colorScheme.onSecondary
        : themeData.colorScheme.onSurface.withOpacity(kOpacityX35);

    return Container(
      child: ButtonClear(
        text: text,
        onPressed: onClick,
        themeData: themeData,
        textColor: color,
        backgroundColor: backgroundColor,
      ),
    );
  }
}

class _EmojiTable extends StatelessWidget {
  final Function(String) onTextAdded;

  const _EmojiTable({Key key, @required this.onTextAdded}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: getProportionateScreenHeight(kSpacingX230),
      padding: EdgeInsets.all(kSpacingX8),
      child: GridView.custom(
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: EMOJI_COLUMNS,
          crossAxisSpacing: getProportionateScreenWidth(kSpacingX4),
        ),
        childrenDelegate: SliverChildListDelegate.fixed(
          [
            ...emojis.map((emoji) => GestureDetector(
                  onTap: () => onTextAdded(emoji),
                  child: Container(
                    width: getProportionateScreenWidth(kSpacingX42),
                    height: getProportionateScreenHeight(kSpacingX42),
                    child: Text(
                      emoji,
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.headline6.fontSize,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
