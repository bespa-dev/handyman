/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handyman/app/bloc/bloc.dart';
import 'package:handyman/app/widgets/widgets.dart';
import 'package:handyman/domain/models/models.dart';
import 'package:handyman/shared/shared.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage({
    Key key,
    @required this.recipientId,
    this.recipient,
  }) : super(key: key);

  final String recipientId;
  final BaseUser recipient;

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  /// blocs
  final _prefsBloc = PrefsBloc(repo: Injection.get());
  final _userBloc = UserBloc(repo: Injection.get());
  final _messageBloc = ConversationBloc(repo: Injection.get());
  final _sendMessageBloc = ConversationBloc(repo: Injection.get());

  /// UI
  ThemeData kTheme;
  String _sender;
  BaseUser _recipient;
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _prefsBloc.close();
    _messageBloc.close();
    _sendMessageBloc.close();
    _userBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      /// get artisan's info
      _userBloc
        ..add(UserEvent.getCustomerByIdEvent(
            id: widget.recipientId ?? widget.recipient.id))
        ..listen((state) {
          if (state is SuccessState<BaseUser>) {
            _recipient = state.data;
            if (mounted) setState(() {});
          }
        });

      /// user id
      _prefsBloc
        ..add(PrefsEvent.getUserIdEvent())
        ..listen((state) {
          if (state is SuccessState<String>) {
            _sender = state.data;
            if (mounted) setState(() {});

            /// fetch all messages
            _messageBloc.add(
              ConversationEvent.getMessages(
                  sender: state.data,
                  recipient: widget.recipientId ?? widget.recipient?.id),
            );
          }
        });

      /// observe scroll position
      // _scrollController.animateTo(
      //   100.0,
      //   duration: kScaleDuration,
      //   curve: Curves.easeIn,
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    kTheme = Theme.of(context);

    return BlocBuilder<ConversationBloc, BlocState>(
      cubit: _messageBloc,
      builder: (_, state) => StreamBuilder<List<BaseConversation>>(
          stream: state is SuccessState<Stream<List<BaseConversation>>>
              ? state.data
              : Stream.empty(),
          initialData: [],
          builder: (_, msgSnapshot) {
            var messages = msgSnapshot.data;

            return BlocBuilder<UserBloc, BlocState>(
              cubit: _userBloc,
              builder: (_, state) => state is SuccessState<BaseUser>
                  ? Scaffold(
                      extendBody: true,
                      appBar: AppBar(
                        // shape: ,
                        toolbarHeight: kSpacingX64,
                        automaticallyImplyLeading: false,
                        leading: IconButton(
                          icon: Icon(kCloseIcon),
                          onPressed: () => context.navigator.pop(),
                          tooltip: 'Back',
                          color: kTheme.colorScheme.onPrimary,
                        ),
                        brightness: Brightness.dark,
                        actions: [
                          if (state.data.phone != null) ...{
                            IconButton(
                              icon: Icon(kCallIcon),
                              iconSize: kSpacingX20,
                              color: kTheme.colorScheme.onPrimary,
                              tooltip: 'Voice call',
                              onPressed: () =>
                                  launchUrl(url: 'tel:${state.data.phone}'),
                            )
                          }
                        ],
                        centerTitle: false,
                        title: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.data.name,
                              style: kTheme.textTheme.headline6.copyWith(
                                color: kTheme.colorScheme.onPrimary,
                              ),
                            ),
                            SizedBox(height: kSpacingX4),
                            Text(
                              'Joined ${parseFromTimestamp(state.data.createdAt, fromNow: true)}',
                              style: kTheme.textTheme.caption.copyWith(
                                color: kTheme.colorScheme.onPrimary,
                              ),
                            ),
                          ],
                        ),
                        backgroundColor: kTheme.colorScheme.primary,
                        primary: true,
                      ),
                      body: Stack(
                        fit: StackFit.expand,
                        children: [
                          _buildPageContent(messages),
                          _buildMessagePanel(),
                        ],
                      ))
                  : Loading(),
            );
          }),
    );
  }

  /// page content
  Widget _buildPageContent(List<BaseConversation> messages) => CustomScrollView(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        clipBehavior: Clip.hardEdge,
        slivers: [
          /// messages list
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                /// messages
                ...messages
                    .map(
                      (message) => ChatListItem(
                        message: message,
                        recipient: _recipient,
                      ),
                    )
                    .toList(),

                /// spacing at the bottom
                SizedBox(height: SizeConfig.screenHeight * 0.09),
              ],
            ),
          ),
        ],
      );

  /// message composing panel
  Widget _buildMessagePanel() => Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: SizeConfig.screenHeight * 0.07,
          alignment: Alignment.center,
          color: kTheme.colorScheme.background,
          child: Container(
            height: SizeConfig.screenHeight * 0.06,
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kSpacingX24),
              color: kTheme.cardColor,
            ),
            clipBehavior: Clip.hardEdge,
            margin: EdgeInsets.symmetric(horizontal: kSpacingX16),
            padding: EdgeInsets.only(left: kSpacingX16, right: kSpacingX8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type your message',
                      hintStyle: TextStyle(
                        color: kTheme.colorScheme.onBackground
                            .withOpacity(kEmphasisLow),
                      ),
                    ),
                    cursorColor: kTheme.colorScheme.onBackground,
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendMessage(),
                    autocorrect: true,
                    enableInteractiveSelection: true,
                  ),
                ),
                SizedBox(width: kSpacingX8),
                InkWell(
                  borderRadius: BorderRadius.circular(kSpacingX42),
                  onTap: _sendMessage,
                  child: Container(
                    height: kSpacingX42,
                    width: kSpacingX42,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kTheme.brightness == Brightness.light
                          ? kTheme.colorScheme.primary
                          : kTheme.colorScheme.background,
                    ),
                    child: Icon(
                      kSendIcon,
                      size: kSpacingX20,
                      color: kTheme.brightness == Brightness.light
                          ? kTheme.colorScheme.onPrimary
                          : kTheme.colorScheme.onBackground,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  /// send message
  void _sendMessage() {
    var message = _messageController.text?.trim();
    if (message.isNotEmpty) {
      /// send message
      _sendMessageBloc.add(
        ConversationEvent.sendMessage(
          sender: _sender,
          recipient: _recipient?.id,
          message: message,
          type: ConversationFormat.textFormat(),
        ),
      );

      /// reload messages
      _messageBloc.add(
        ConversationEvent.getMessages(
            sender: _sender, recipient: _recipient?.id),
      );

      /// clear field
      _messageController.clear();
    }
  }
}
