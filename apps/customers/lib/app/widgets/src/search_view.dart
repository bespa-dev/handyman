/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */
import 'package:flutter/material.dart';
import 'package:lite/shared/shared.dart';

class SearchView extends StatefulWidget {
  final Function(String) onQueryComplete;
  final Function(String) onQueryChange;
  final FocusNode focusNode;
  final String hint;

  const SearchView({
    Key key,
    @required this.onQueryComplete,
    @required this.onQueryChange,
    @required this.focusNode,
    this.hint = "\tWhat do you want to do?",
  }) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final _controller = TextEditingController();
  bool _isTyping = false;

  @override
  Widget build(BuildContext context) {
    final kTheme = Theme.of(context);

    return Align(
      alignment: Alignment.center,
      child: AnimatedContainer(
        duration: kScaleDuration,
        height: kSpacingX48,
        width: SizeConfig.screenWidth * 0.9,
        margin: EdgeInsets.symmetric(
          vertical: kSpacingX12,
          horizontal: kSpacingX16,
        ),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: kTheme.cardColor,
          borderRadius: BorderRadius.circular(kSpacingX4),
        ),
        padding: EdgeInsets.symmetric(horizontal: kSpacingX24),
        child: Material(
          type: MaterialType.card,
          borderRadius: BorderRadius.circular(kSpacingX4),
          child: GestureDetector(
            onTap: _isTyping
                ? null
                : () {
                    _isTyping = !_isTyping;
                    setState(() {});
                  },
            child: _isTyping
                ? Container(
                    child: TextField(
                      controller: _controller,
                      style: kTheme.textTheme.headline6.copyWith(
                        color: kTheme.colorScheme.onBackground
                            .withOpacity(kEmphasisHigh),
                        fontSize: kSpacingX16,
                      ),
                      autofocus: true,
                      cursorColor: kTheme.colorScheme.onBackground,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: widget.hint,
                        contentPadding: EdgeInsets.zero,
                        hintStyle: kTheme.textTheme.headline6.copyWith(
                          color: kTheme.colorScheme.onBackground
                              .withOpacity(kEmphasisLow),
                          fontSize: kSpacingX16,
                        ),
                      ),
                      textInputAction: TextInputAction.search,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      onSubmitted: (text) {
                        _isTyping = !_isTyping;
                        setState(() {});
                        if (text.isNotEmpty) widget.onQueryComplete(text);
                      },
                      onChanged: (text) {
                        widget.onQueryChange(text);
                      },
                      focusNode: widget.focusNode,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        kSearchIcon,
                        size: kSpacingX16,
                        color: kTheme.colorScheme.onBackground
                            .withOpacity(kEmphasisLow),
                      ),
                      SizedBox(width: kSpacingX12),
                      Text(
                        widget.hint,
                        style: kTheme.textTheme.headline6.copyWith(
                          color: kTheme.colorScheme.onBackground
                              .withOpacity(kEmphasisLow),
                          fontSize: kSpacingX16,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
