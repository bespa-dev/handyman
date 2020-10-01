import 'package:flutter/material.dart';
import 'package:handyman/core/constants.dart';

class TextFormInput extends TextFormField {
  TextFormInput({
    @required String labelText,
    String hintText = '',
    String helperText = '',
    TextInputType keyboardType = TextInputType.text,
    TextInputAction textInputAction,
    TextEditingController controller,
    bool enabled,
    FormFieldValidator<String> validator,
    IconButton suffixIcon,
    bool obscureText = false,
    FocusNode focusNode,
    Function onFieldSubmitted,
    bool autofocus = false,
    int maxLines = 1,
    Color color,
  }) : super(
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          controller: controller,
          enabled: enabled,
          validator: validator,
          obscureText: obscureText,
          cursorWidth: 1,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            helperText: helperText,
            suffixIcon: suffixIcon,
            // border: InputBorder.none,
          ),
          focusNode: focusNode,
          onFieldSubmitted: onFieldSubmitted ?? (_) {},
          autofocus: autofocus,
          maxLines: maxLines,
          style: TextStyle(color: color ?? kPrimaryColor),
        );
}

class PasswordInput extends StatefulWidget {
  final String labelText;
  final String hintText;
  final String helperText;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final bool enabled;
  final FormFieldValidator<String> validator;
  final FocusNode focusNode;
  final Function onFieldSubmitted;

  PasswordInput({
    @required this.labelText,
    this.hintText,
    this.helperText,
    this.textInputAction,
    this.controller,
    this.enabled,
    this.validator,
    this.focusNode,
    this.onFieldSubmitted,
  });

  @override
  State<StatefulWidget> createState() {
    return _PasswordInputState();
  }
}

class _PasswordInputState extends State<PasswordInput> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return TextFormInput(
      labelText: widget.labelText,
      hintText: widget.hintText ?? '',
      helperText: widget.helperText ?? '',
      textInputAction: widget.textInputAction,
      controller: widget.controller,
      enabled: widget.enabled,
      validator: widget.validator,
      obscureText: _obscure,
      color: themeData.textTheme.bodyText1.color,
      maxLines: 1,
      suffixIcon: IconButton(
        icon: Icon(
          _obscure ? Icons.visibility : Icons.visibility_off,
          size: kSpacingX24,
          color: themeData.iconTheme.color,
        ),
        onPressed: () => setState(() => _obscure = !_obscure),
      ),
      focusNode: widget.focusNode,
      onFieldSubmitted: widget.onFieldSubmitted,
    );
  }
}
