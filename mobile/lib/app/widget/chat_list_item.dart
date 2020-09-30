import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/local_database.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';

class ChatListItem extends StatefulWidget {
  final Conversation conversation;

  const ChatListItem({Key key, @required this.conversation}) : super(key: key);

  @override
  _ChatListItemState createState() => _ChatListItemState();
}

class _ChatListItemState extends State<ChatListItem> {
  double _kHeight, _kWidth;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final size = MediaQuery.of(context).size;
    _kWidth = size.width;
    _kHeight = size.height;

    return Consumer<PrefsProvider>(
      builder: (_, provider, __) {
        final isMe = widget.conversation.author == provider.userId;
        final conversation = widget.conversation;
        final color = isMe ? themeData.disabledColor : themeData.accentColor;

        return ConstrainedBox(
          constraints: BoxConstraints(
            // height: kToolbarHeight,
            // width: 120,
            maxWidth: _kWidth * 0.4,
            minHeight: kToolbarHeight,
            minWidth: _kWidth * 0.2,
          ),
          child: Container(
            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(kSpacingX24),
              vertical: getProportionateScreenHeight(kSpacingX16),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(kSpacingX24),
                topRight: Radius.circular(kSpacingX24),
                bottomLeft: isMe ? Radius.circular(kSpacingX24) : Radius.zero,
                bottomRight: isMe ? Radius.zero : Radius.circular(kSpacingX24),
              ),
              color: color,
            ),
            child: Text(conversation.content),
          ),
        );
      },
    );
  }
}

class ChatMessages extends StatefulWidget {
  final Stream<List<Conversation>> messages;
  final Function(int) onTap;

  const ChatMessages({Key key, @required this.messages, this.onTap})
      : super(key: key);

  @override
  _ChatMessagesState createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  @override
  Widget build(BuildContext context) => StreamBuilder<List<Conversation>>(
      stream: widget.messages,
      builder: (context, snapshot) {
        // FIXME: Add swipe action for instant reply
        return snapshot.hasData
            ? AnimationLimiter(
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  reverse: true,
                  physics: kScrollPhysics,
                  clipBehavior: Clip.hardEdge,
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  separatorBuilder: (_, __) => SizedBox(
                      height: getProportionateScreenHeight(kSpacingX8)),
                  itemBuilder: (_, index) {
                    final conversation = snapshot.data[index];
                    return AnimationConfiguration.staggeredList(
                      duration: kScaleDuration,
                      position: index,
                      child: SlideAnimation(
                        verticalOffset: kSlideOffset,
                        child: FadeInAnimation(
                          child: GestureDetector(
                            onTap: () => widget.onTap(index) ?? null,
                            behavior: HitTestBehavior.translucent,
                            child: ChatListItem(conversation: conversation),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: snapshot.data.length,
                ),
              )
            : Container();
      });
}
