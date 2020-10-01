import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/widget/buttons.dart';
import 'package:handyman/app/widget/chat_header.dart';
import 'package:handyman/app/widget/chat_input_entry.dart';
import 'package:handyman/app/widget/chat_list_item.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/service_locator.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/local_database.dart';
import 'package:handyman/data/provider/artisan_api_provider.dart';
import 'package:handyman/domain/models/user.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ConversationPage extends StatefulWidget {
  final bool isCustomer;
  final String recipient;

  const ConversationPage({Key key, this.recipient, this.isCustomer})
      : super(key: key);

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final _apiService = sl.get<ApiProviderService>();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      extendBody: true,
      body: Consumer<PrefsProvider>(
        builder: (_, provider, __) => Container(
          child: SafeArea(
            child: StreamBuilder<BaseUser>(
              stream: _apiService.getArtisanById(id: widget.recipient),
              builder: (_, snapshot) {
                if (snapshot.hasError)
                  return Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("No recipient found"),
                        SizedBox(
                            height: getProportionateScreenHeight(kSpacingX24)),
                        ButtonOutlined(
                          width: getProportionateScreenWidth(kSpacingX200),
                          themeData: themeData,
                          onTap: () => context.navigator.pop(),
                          label: "Go back",
                        )
                      ],
                    ),
                  );
                else
                  return _buildChatWidget(
                      snapshot.data, provider.userId, provider.userType);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChatWidget(BaseUser recipient, userId, userType) {
    debugPrint("$userId => ${widget.recipient}");
    return StreamBuilder<BaseUser>(
        stream: userType == kCustomerString
            ? _apiService.getCustomerById(id: userId)
            : _apiService.getArtisanById(id: userId),
        builder: (context, snapshot) => Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: ChatMessages(
                        messages: _apiService.getConversation(
                          sender: userId,
                          recipient: widget.recipient,
                        ),
                        recipient: recipient,
                        sender: snapshot.data,
                      ),
                    ),
                    UserInput(
                      onMessageSent: (content) async {
                        final timestamp =
                            DateFormat.jms().format(DateTime.now());
                        final conversation = Conversation(
                          id: Uuid().v4(),
                          author: userId,
                          recipient: widget.recipient,
                          content: content,
                          createdAt: timestamp,
                        );
                        debugPrint(conversation.toString());
                        await _apiService.sendMessage(
                            conversation: conversation);
                      },
                    ),
                  ],
                ),
                Positioned(
                  top: kSpacingNone,
                  left: kSpacingNone,
                  right: kSpacingNone,
                  child: ChatHeader(user: recipient),
                ),
              ],
            ));
  }
}
