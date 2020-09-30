import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:handyman/app/widget/buttons.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/size_config.dart';
import 'package:meta/meta.dart';

enum InputSelector { NONE, MAP, DM, EMOJI, PHONE, PICTURE }

enum EmojiStickerSelector { EMOJI, STICKER }

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
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        top: getProportionateScreenHeight(kSpacingX4),
      ),
      child: Column(
        children: [
          Divider(),
          _UserInputText(
            textFieldValue: textController.text,
            onTextChanged: (text) {
              textController.text = text;
              setState(() {});
            },
            keyboardShown: !dismissKeyboard,
            onTextFieldFocused: (focused) {
              // TODO: onTextFieldFocused
            },
            focusState: false,
          ),
          _UserInputSelector(
            onSelectorChange: (selector) {
              currentInputSelector = selector;
              setState(() {});
            },
            sendMessageEnabled: textController.text.isNotEmpty,
            onMessageSent: () {
              widget.onMessageSent(textController.text.trim());
              textController.clear();
            },
            currentInputSelector: currentInputSelector,
          ),
          _SelectorExpanded(
            onCloseRequested: dismissKeyboard,
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
}

class _UserInputText extends StatefulWidget {
  final String textFieldValue;
  final Function(String) onTextChanged;
  final bool keyboardShown;
  final Function(bool) onTextFieldFocused;
  final bool focusState;

  const _UserInputText(
      {Key key,
      @required this.textFieldValue,
      @required this.onTextChanged,
      @required this.keyboardShown,
      @required this.onTextFieldFocused,
      @required this.focusState})
      : super(key: key);

  @override
  __UserInputTextState createState() => __UserInputTextState();
}

class __UserInputTextState extends State<_UserInputText> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

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
      color: selected ? themeData.primaryColor : themeData.disabledColor,
    );
  }
}

class _SelectorExpanded extends StatelessWidget {
  final bool onCloseRequested;
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
    return Container(
      child: currentSelector == InputSelector.EMOJI
          ? _buildEmojiSelector()
          : _buildFunctionalityNotAvailablePanel(context),
    );
  }

  Widget _buildEmojiSelector() => Container(
        height: kSpacingX320,
        child: Column(
          children: [],
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
            Text(
              "Grab a beverage and check back later!",
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
}
