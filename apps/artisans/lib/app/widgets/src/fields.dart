/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:handyman/shared/shared.dart';

class TextFormInput extends TextFormField {
  TextFormInput({
    @required String labelText,
    String hintText = '',
    String helperText = '',
    TextInputType keyboardType = TextInputType.text,
    TextCapitalization textCapitalization = TextCapitalization.none,
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
    Color cursorColor,
  }) : super(
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          controller: controller,
          enabled: enabled,
          validator: validator,
          obscureText: obscureText,
          textCapitalization: textCapitalization,
          cursorColor: cursorColor,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            helperText: helperText,
            suffixIcon: suffixIcon,
            enabled: enabled,
          ),
          focusNode: focusNode,
          onFieldSubmitted: onFieldSubmitted,
          autofocus: autofocus,
          maxLines: maxLines,
        );
}

class PasswordInput extends StatefulWidget {
  final String labelText;
  final String hintText;
  final String helperText;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final bool enabled;
  final Color iconColor;
  final Color color;
  final Color cursorColor;
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
    this.iconColor,
    this.cursorColor,
    this.color,
  });

  @override
  State<PasswordInput> createState() => _PasswordInputState();
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
      maxLines: 1,
      cursorColor: widget.cursorColor,
      color: widget.color,
      suffixIcon: IconButton(
        icon: Icon(
          _obscure ? Feather.eye : Feather.eye_off,
          size: kSpacingX24,
          color: widget.iconColor ?? themeData.iconTheme.color,
        ),
        onPressed: () => setState(() => _obscure = !_obscure),
      ),
      focusNode: widget.focusNode,
      onFieldSubmitted: widget.onFieldSubmitted,
    );
  }
}
