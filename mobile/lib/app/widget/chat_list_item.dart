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
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Consumer<PrefsProvider>(
      builder: (_, provider, __) {
        final isMe = widget.conversation.author == provider.userId;

        return Container(
          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
          height: kToolbarHeight,
          width: getProportionateScreenWidth(kSpacingX250),
          padding: EdgeInsets.symmetric(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(kSpacingX24),
              topRight: Radius.circular(kSpacingX24),
              bottomLeft: isMe ? Radius.circular(kSpacingX24) : Radius.zero,
              bottomRight: isMe ? Radius.zero : Radius.circular(kSpacingX24),
            ),
            color: themeData.primaryColor,
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
