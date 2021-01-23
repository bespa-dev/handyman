/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */
import 'package:flutter/material.dart';
import 'package:handyman/app/bloc/bloc.dart';
import 'package:handyman/app/widgets/widgets.dart';
import 'package:handyman/domain/models/models.dart';
import 'package:handyman/shared/shared.dart';

class ChatListItem extends StatefulWidget {
  const ChatListItem({
    Key key,
    @required this.recipient,
    @required this.message,
    this.top = true,
    this.middle = false,
    this.bottom = false,
  }) : super(key: key);

  final BaseUser recipient;
  final BaseConversation message;
  final bool top;
  final bool middle;
  final bool bottom;

  @override
  _ChatListItemState createState() => _ChatListItemState();
}

class _ChatListItemState extends State<ChatListItem> {
  bool _isAuthor = true, _showTimestampDetails = false;
  ThemeData kTheme;

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
          }
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    kTheme = Theme.of(context);

    return Container(
      margin: EdgeInsets.only(
        top: kSpacingX8,
        left: kSpacingX20,
        right: kSpacingX20,
      ),
      child: _buildChatWidget(),
    );
  }

  Widget _buildChatWidget() {
    var top = widget.top;
    // var middle = widget.middle;
    var bottom = widget.bottom;
    return _isAuthor
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// timestamp
              AnimatedContainer(
                duration: kScaleDuration,
                constraints:
                    BoxConstraints(maxWidth: SizeConfig.screenWidth * 0.2),
                child: Text(
                  parseFromTimestamp(
                    widget.message.createdAt,
                    isChatFormat: !_showTimestampDetails,
                    isDetailedFormat: _showTimestampDetails,
                  ),
                  textAlign: TextAlign.end,
                  style: kTheme.textTheme.caption.copyWith(
                    color: kTheme.colorScheme.onBackground
                        .withOpacity(kEmphasisLow),
                  ),
                ),
              ),

              /// message body
              InkWell(
                onTap: () => setState(
                    () => _showTimestampDetails = !_showTimestampDetails),
                splashColor: kTheme.splashColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(kSpacingX32),
                  bottomRight: Radius.circular(top ? kSpacingX6 : kSpacingX32),
                  topRight: Radius.circular(bottom ? kSpacingX6 : kSpacingX32),
                  topLeft: Radius.circular(kSpacingX32),
                ),
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  padding: EdgeInsets.symmetric(
                    horizontal: kSpacingX20,
                    vertical: kSpacingX12,
                  ),
                  decoration: BoxDecoration(
                    color:
                        kTheme.colorScheme.primary.withOpacity(kEmphasisHigh),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(kSpacingX32),
                      bottomRight:
                          Radius.circular(top ? kSpacingX6 : kSpacingX32),
                      topRight:
                          Radius.circular(bottom ? kSpacingX6 : kSpacingX32),
                      topLeft: Radius.circular(kSpacingX32),
                    ),
                  ),
                  alignment: Alignment.centerRight,
                  child: LimitedBox(
                    maxWidth: SizeConfig.screenWidth * 0.6,
                    child: Text(
                      widget.message.body,
                      softWrap: true,
                      style: kTheme.textTheme.bodyText1.copyWith(
                        color: kTheme.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// message body
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  UserAvatar(
                    url: widget.recipient.avatar,
                    radius: kSpacingX28,
                    isCircular: true,
                  ),
                  SizedBox(width: kSpacingX8),
                  InkWell(
                    onTap: () => setState(
                        () => _showTimestampDetails = !_showTimestampDetails),
                    splashColor: kTheme.splashColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft:
                          Radius.circular(top ? kSpacingX6 : kSpacingX32),
                      bottomRight: Radius.circular(kSpacingX32),
                      topRight: Radius.circular(kSpacingX32),
                      topLeft:
                          Radius.circular(bottom ? kSpacingX6 : kSpacingX32),
                    ),
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      padding: EdgeInsets.symmetric(
                        horizontal: kSpacingX20,
                        vertical: kSpacingX12,
                      ),
                      decoration: BoxDecoration(
                        color: kTheme.cardColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft:
                              Radius.circular(top ? kSpacingX6 : kSpacingX32),
                          bottomRight: Radius.circular(kSpacingX32),
                          topRight: Radius.circular(kSpacingX32),
                          topLeft: Radius.circular(
                              bottom ? kSpacingX6 : kSpacingX32),
                        ),
                      ),
                      alignment: Alignment.centerLeft,
                      child: LimitedBox(
                        maxWidth: SizeConfig.screenWidth * 0.5,
                        child: Text(
                          widget.message.body,
                          softWrap: true,
                          style: kTheme.textTheme.bodyText1.copyWith(
                            color: kTheme.colorScheme.onBackground,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              /// timestamp
              Text(
                parseFromTimestamp(
                  widget.message.createdAt,
                  isChatFormat: !_showTimestampDetails,
                  isDetailedFormat: _showTimestampDetails,
                ),
                textAlign: TextAlign.end,
                style: kTheme.textTheme.caption.copyWith(
                  color:
                      kTheme.colorScheme.onBackground.withOpacity(kEmphasisLow),
                ),
              ),
            ],
          );
  }
}
