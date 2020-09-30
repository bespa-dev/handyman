import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/model/theme_provider.dart';
import 'package:handyman/app/widget/user_avatar.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/local_database.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';
import 'package:random_color/random_color.dart';

class ChatListItem extends StatefulWidget {
  final Conversation conversation;
  final Artisan artisan;
  final Customer customer;

  const ChatListItem(
      {Key key,
      @required this.conversation,
      @required this.artisan,
      @required this.customer})
      : super(key: key);

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
      builder: (_, provider, __) => Consumer<ThemeProvider>(
        builder: (_, theme, __) {
          final isMe = widget.conversation.author == provider.userId;
          final conversation = widget.conversation;
          final color =
              theme.isLightTheme ? kChatBackgroundLight : kChatBackgroundDark;
          final textAlignment = isMe ? TextAlign.end : TextAlign.start;

          return Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              isMe
                  ? SizedBox.shrink()
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        UserAvatar(
                          url: widget.artisan.avatar,
                          radius: kSpacingX42,
                          ringColor: RandomColor(1).randomColor(
                              colorBrightness: ColorBrightness.dark),
                        ),
                        SizedBox(
                          width: getProportionateScreenWidth(kSpacingX8),
                        ),
                      ],
                    ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(kSpacingX24),
                  vertical: getProportionateScreenHeight(kSpacingX16),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(kSpacingX24),
                    topRight: Radius.circular(kSpacingX24),
                    bottomLeft:
                        isMe ? Radius.circular(kSpacingX24) : Radius.zero,
                    bottomRight:
                        isMe ? Radius.zero : Radius.circular(kSpacingX24),
                  ),
                  color: color,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    // TODO: Add support for images
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: _kWidth * 0.6,
                      ),
                      child: Text(
                        conversation.content,
                        textAlign: textAlignment,
                      ),
                    ),
                  ],
                ),
              ),
              isMe
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: getProportionateScreenWidth(kSpacingX8),
                        ),
                        UserAvatar(
                          url: widget.customer.avatar,
                          radius: kSpacingX42,
                          ringColor: RandomColor(14).randomColor(
                            colorBrightness: ColorBrightness.dark,
                          ),
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
            ],
          );
        },
      ),
    );
  }
}

class ChatMessages extends StatefulWidget {
  final Stream<List<Conversation>> messages;
  final Artisan artisan;
  final Customer customer;
  final Function(int) onTap;

  const ChatMessages(
      {Key key,
      @required this.messages,
      this.onTap,
      @required this.artisan,
      @required this.customer})
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
                  padding: EdgeInsets.only(
                      bottom: getProportionateScreenHeight(kSpacingX8)),
                  scrollDirection: Axis.vertical,
                  reverse: true,
                  physics: kScrollPhysics,
                  clipBehavior: Clip.hardEdge,
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
                            child: ChatListItem(
                              conversation: conversation,
                              customer: widget.customer,
                              artisan: widget.artisan,
                            ),
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
