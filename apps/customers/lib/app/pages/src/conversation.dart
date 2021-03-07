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

class ConversationPage extends StatefulWidget {
  final String recipientId;
  final BaseUser recipient;

  const ConversationPage({
    Key key,
    @required this.recipientId,
    this.recipient,
  }) : super(key: key);

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  @override
  Widget build(BuildContext context) {
<<<<<<< Updated upstream
    return Scaffold(
      appBar: AppBar(),
=======
    kTheme = Theme.of(context);

    return BlocBuilder<BusinessBloc, BlocState>(
      bloc: _businessBloc,
      builder: (_, businessState) => BlocBuilder<ConversationBloc, BlocState>(
        bloc: _messageBloc,
        builder: (_, state) => StreamBuilder<List<BaseConversation>>(
            stream: state is SuccessState<Stream<List<BaseConversation>>>
                ? state.data
                : Stream.empty(),
            initialData: [],
            builder: (_, msgSnapshot) {
              var messages = msgSnapshot.data;

              return BlocBuilder<UserBloc, BlocState>(
                bloc: _userBloc,
                builder: (_, userState) => userState
                        is SuccessState<BaseArtisan>
                    ? Scaffold(
                        appBar: AppBar(
                          automaticallyImplyLeading: false,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(kSpacingX16),
                              bottomRight: Radius.circular(kSpacingX16),
                            ),
                          ),
                          titleSpacing: kSpacingNone,
                          leading: IconButton(
                            icon: Icon(kCloseIcon),
                            onPressed: () => context.navigator.pop(),
                            tooltip: 'Back',
                            color: kTheme.colorScheme.onPrimary,
                          ),
                          actions: [
                            if (userState.data.phone != null) ...{
                              IconButton(
                                icon: Icon(kCallIcon),
                                iconSize: kSpacingX20,
                                color: kTheme.colorScheme.onPrimary,
                                tooltip: 'Voice call',
                                onPressed: () => launchUrl(
                                    url: 'tel:${userState.data.phone}'),
                              )
                            }
                          ],
                          centerTitle: false,
                          title: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userState.data.name,
                                style: kTheme.textTheme.headline6.copyWith(
                                  color: kTheme.colorScheme.onPrimary,
                                ),
                              ),
                              SizedBox(height: kSpacingX4),
                              Text(
                                userState.data.isAvailable
                                    ? 'Available'
                                    : 'Unavailable',
                                style: kTheme.textTheme.caption.copyWith(
                                  color: kTheme.colorScheme.onPrimary
                                      .withOpacity(kEmphasisMedium),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          bottom: PreferredSize(
                            child: _buildBackgroundInfo(
                              userState.data,
                              businessState is SuccessState<List<BaseBusiness>>
                                  ? businessState.data
                                  : [],
                            ),
                            preferredSize:
                                Size.fromHeight(SizeConfig.screenHeight * 0.15),
                          ),
                          brightness: Brightness.dark,
                          backgroundColor: kTheme.colorScheme.primary,
                        ),
                        body: Stack(
                          fit: StackFit.expand,
                          children: [
                            _buildPageContent(messages ?? [], userState.data),
                            _buildMessagePanel(),
                          ],
                        ),
                      )
                    : Loading(),
              );
            }),
      ),
    );
  }

  /// page content
  Widget _buildPageContent(
      List<BaseConversation> messages, BaseArtisan artisan) {
    // fixme -> remove this
    // logger.d(messages
    //     .sortByDescending((r) => r.createdAt)
    //     .groupBy((r) => r.author)
    //     .values
    //     .first);

    return CustomScrollView(
      controller: _scrollController,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      reverse: true,
      clipBehavior: Clip.hardEdge,
      slivers: [
        /// messages list
        SliverList(
          delegate: SliverChildListDelegate.fixed(
            [
              /// spacing at the top
              SizedBox(height: SizeConfig.screenHeight * 0.08),

              /// messages
              for (int index = 0; index < messages.length; index++) ...{
                ChatListItem(message: messages[index], recipient: _recipient)
              },
            ],
          ),
        ),
      ],
>>>>>>> Stashed changes
    );
  }
}
