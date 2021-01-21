/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */
import 'package:flutter/material.dart';
import 'package:lite/domain/models/models.dart';
import 'package:lite/shared/shared.dart';

class ChatListItem extends StatefulWidget {
  const ChatListItem({
    Key key,
    @required this.recipient,
    @required this.message,
  }) : super(key: key);

  final BaseArtisan recipient;
  final BaseConversation message;

  @override
  _ChatListItemState createState() => _ChatListItemState();
}

class _ChatListItemState extends State<ChatListItem> {
  bool _isAuthor = false;

  @override
  void initState() {
    super.initState();

    if (mounted) {
      _isAuthor = widget.recipient.id == widget.message.recipient;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var kTheme = Theme.of(context);

    return Container(
      margin: EdgeInsets.only(
        top: kSpacingX8,
        left: _isAuthor ? kSpacingNone : kSpacingX12,
        right: _isAuthor ? kSpacingX12 : kSpacingNone,
      ),
      width: SizeConfig.screenWidth,
      child: Column(
        crossAxisAlignment:
            _isAuthor ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: SizeConfig.screenWidth * 0.7),
            clipBehavior: Clip.hardEdge,
            padding: EdgeInsets.all(kSpacingX20),
            decoration: BoxDecoration(
              color: _isAuthor ? kTheme.colorScheme.primary : kTheme.cardColor,
              borderRadius: BorderRadius.only(
                bottomLeft:
                    Radius.circular(_isAuthor ? kSpacingX36 : kSpacingNone),
                bottomRight:
                    Radius.circular(_isAuthor ? kSpacingNone : kSpacingX36),
                topRight: Radius.circular(kSpacingX36),
                topLeft: Radius.circular(kSpacingX36),
              ),
            ),
            alignment: _isAuthor ? Alignment.centerLeft : Alignment.centerRight,
            child: Text(
              widget.message.body,
              style: kTheme.textTheme.bodyText1.copyWith(
                color: _isAuthor
                    ? kTheme.colorScheme.onPrimary
                    : kTheme.colorScheme.onBackground,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
