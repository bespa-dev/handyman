/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lite/app/bloc/bloc.dart';
import 'package:lite/app/widgets/widgets.dart';
import 'package:lite/domain/models/models.dart';
import 'package:lite/shared/shared.dart';

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
  final _businessBloc = BusinessBloc(repo: Injection.get());
  final _messageBloc = ConversationBloc(repo: Injection.get());
  final _sendMessageBloc = ConversationBloc(repo: Injection.get());

  /// UI
  ThemeData kTheme;
  String _sender;
  BaseArtisan _recipient;
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _prefsBloc.close();
    _messageBloc.close();
    _sendMessageBloc.close();
    _userBloc.close();
    _businessBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      /// get artisan's info
      _userBloc
        ..add(UserEvent.getArtisanByIdEvent(
            id: widget.recipientId ?? widget.recipient.id))
        ..listen((state) {
          if (state is SuccessState<BaseArtisan>) {
            _recipient = state.data;
            if (mounted) setState(() {});
          }
        });

      /// load business info
      _businessBloc.add(BusinessEvent.getBusinessesForArtisan(
          artisanId: widget.recipientId ?? widget.recipient.id));

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
    }
  }

  @override
  Widget build(BuildContext context) {
    kTheme = Theme.of(context);

    return BlocBuilder<BusinessBloc, BlocState>(
      cubit: _businessBloc,
      builder: (_, businessState) => BlocBuilder<ConversationBloc, BlocState>(
        cubit: _messageBloc,
        builder: (_, state) => StreamBuilder<List<BaseConversation>>(
            stream: state is SuccessState<Stream<List<BaseConversation>>>
                ? state.data
                : Stream.empty(),
            initialData: [],
            builder: (_, msgSnapshot) {
              var messages = msgSnapshot.data;

              return Scaffold(
                  body: Stack(
                fit: StackFit.expand,
                children: [
                  _buildPageContent(
                    messages,
                    businessState is SuccessState<List<BaseBusiness>>
                        ? businessState.data
                        : [],
                  ),
                  _buildMessagePanel(),
                ],
              ));
            }),
      ),
    );
  }

  /// page content
  Widget _buildPageContent(
      List<BaseConversation> messages, List<BaseBusiness> businesses) {
    var businessName = businesses.isNotEmpty
        ? businesses?.first?.name
        : 'our business enterprise';

    return BlocBuilder<UserBloc, BlocState>(
      cubit: _userBloc,
      builder: (_, state) => state is SuccessState<BaseArtisan>
          ? CustomScrollView(
              controller: _scrollController,
              slivers: [
                /// app bar
                SliverAppBar(
                  expandedHeight: SizeConfig.screenHeight * 0.4,
                  automaticallyImplyLeading: false,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    background: _buildBackgroundInfo(state.data, businessName),
                  ),
                  backgroundColor: kTheme.colorScheme.primary,
                  stretch: true,
                  snap: true,
                  collapsedHeight: SizeConfig.screenHeight * 0.1,
                  toolbarHeight: SizeConfig.screenHeight * 0.1,
                  leadingWidth: kSpacingX48,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarBrightness: kTheme.brightness == Brightness.light
                        ? Brightness.dark
                        : Brightness.light,
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(kCloseIcon),
                      color: kTheme.colorScheme.onPrimary,
                      onPressed: () => context.navigator.pop(),
                    ),
                  ],
                  floating: true,
                ),

                /// messages list
                SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    [
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
            )
          : Loading(),
    );
  }

  /// message composing panel
  Widget _buildMessagePanel() => Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: SizeConfig.screenHeight * 0.08,
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
            color: kTheme.colorScheme.background,
          ),
          padding: EdgeInsets.symmetric(horizontal: kSpacingX16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: kSpacingX16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kSpacingX24),
                    color: kTheme.cardColor,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: kSpacingX12),
                  clipBehavior: Clip.hardEdge,
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type here',
                      hintStyle: TextStyle(
                        color: kTheme.colorScheme.onBackground
                            .withOpacity(kEmphasisLow),
                      ),
                    ),
                    cursorColor: kTheme.colorScheme.onBackground,
                    textCapitalization: TextCapitalization.words,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.send,
                    autocorrect: true,
                    enableInteractiveSelection: true,
                  ),
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(kSpacingX42),
                onTap: () {
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
                },
                child: Container(
                  height: kSpacingX42,
                  width: kSpacingX42,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: kTheme.cardColor),
                  child: Icon(
                    kSendIcon,
                    color: kTheme.colorScheme.onBackground,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  /// appbar background info panel
  Widget _buildBackgroundInfo(BaseArtisan user, String businessName) =>
      Container(
        width: SizeConfig.screenWidth,
        color: kTheme.colorScheme.primary,
        padding: EdgeInsets.symmetric(
          horizontal: kSpacingX24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserAvatar(
              url: user.avatar,
              radius: kSpacingX84,
              isCircular: true,
            ),
            SizedBox(height: kSpacingX16),
            Text(
              'Hi there!',
              style: kTheme.textTheme.headline3.copyWith(
                color: kTheme.colorScheme.onPrimary,
              ),
            ),
            SizedBox(height: kSpacingX8),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: 'Welcome to '),
                  TextSpan(
                    text: businessName,
                    style: kTheme.textTheme.headline5.copyWith(
                      color: kTheme.colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(text: '. How can we help you today?'),
                ],
              ),
              style: kTheme.textTheme.headline5.copyWith(
                color: kTheme.colorScheme.onPrimary,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      );
}
