/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */
import 'package:flutter/material.dart';
import 'package:lite/app/bloc/bloc.dart';
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
  bool _isAuthor = true;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      PrefsBloc(repo: Injection.get())
        ..add(PrefsEvent.getUserIdEvent())
        ..listen((state) {
          if (state is SuccessState<String>) {
            _isAuthor = state.data == widget.message.author;
            if (mounted) setState(() {});
            logger.d('is author -> $_isAuthor');
          }
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    var kTheme = Theme.of(context);

    return Align(
      alignment: _isAuthor
          ? FractionalOffset.centerRight
          : FractionalOffset.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          top: kSpacingX8,
          left: _isAuthor ? kSpacingNone : kSpacingX12,
          right: _isAuthor ? kSpacingX12 : kSpacingNone,
        ),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: SizeConfig.screenWidth * 0.7,
            minWidth: kSpacingX24,
          ),
          clipBehavior: Clip.hardEdge,
          padding: EdgeInsets.symmetric(
            horizontal: kSpacingX20,
            vertical: kSpacingX12,
          ),
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
          alignment: _isAuthor ? Alignment.centerRight : Alignment.centerLeft,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                _isAuthor ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                widget.message.body,
                softWrap: true,
                style: kTheme.textTheme.bodyText1.copyWith(
                  color: _isAuthor
                      ? kTheme.colorScheme.onPrimary
                      : kTheme.colorScheme.onBackground,
                ),
              ),
              SizedBox(height: kSpacingX4),
              Text(
                parseFromTimestamp(
                  widget.message.createdAt,
                  isChatFormat: true,
                ),
                textAlign: TextAlign.end,
                style: kTheme.textTheme.caption.copyWith(
                  color: _isAuthor
                      ? kTheme.colorScheme.onPrimary
                          .withOpacity(kEmphasisMedium)
                      : kTheme.colorScheme.onBackground
                          .withOpacity(kEmphasisMedium),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
