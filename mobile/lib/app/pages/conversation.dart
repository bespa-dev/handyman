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
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

/*FIXME: Unable to fetch provider information from database*/
class ConversationPage extends StatefulWidget {
  final String sender, recipient;

  const ConversationPage({Key key, this.sender, this.recipient})
      : super(key: key);

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final _apiService = sl.get<ApiProviderService>();
  final _dummyArtisan = Stream.value(
    Artisan(
        id: Uuid().v4(),
        name: "Kwasi Babone",
        business: "LA Galaxy Inc",
        email: "kwasi@mail.com",
        isCertified: true,
        avatar:
            "https://images.unsplash.com/photo-1598547461182-45d03f6661e4?ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60",
        category: "598d67f5-b84b-4572-9058-57f36463aeac",
        startWorkingHours: 8,
        endWorkingHours: 23,
        price: 23.69,
        rating: 3.5),
  );

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      extendBody: true,
      body: Consumer<PrefsProvider>(
        builder: (_, prefsProvider, __) => Container(
          child: SafeArea(
            child: StreamBuilder<Artisan>(
              stream: /*_apiService.getArtisanById(id: widget.recipient) ??*/
                  _dummyArtisan,
              builder: (_, snapshot) {
                if (snapshot.hasError)
                  return Column(
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
                  );
                else
                  return _buildChatWidget(snapshot.data);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChatWidget(Artisan artisan) => StreamBuilder<Customer>(
      stream: /*_apiService.getCustomerById(id: widget.sender)*/ Stream.value(
        Customer(
          id: widget.sender,
          avatar:
              "https://images.unsplash.com/photo-1574981370294-edbbf06bb159?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=600&q=60",
          email: "quabynah@gmail.com",
          name: "Quabynah Bilson Jr.",
        ),
      ),
      builder: (context, snapshot) => Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: ChatMessages(
                      messages: _apiService.getConversation(
                          sender: widget.sender, recipient: widget.recipient),
                      artisan: artisan,
                      customer: snapshot.data,
                    ),
                  ),
                  UserInput(
                    onMessageSent: (content) async {
                      final timestamp = DateFormat.jms().format(DateTime.now());
                      final conversation = Conversation(
                        id: Uuid().v4(),
                        author: widget.sender,
                        recipient: widget.recipient,
                        content: content,
                        createdAt: timestamp,
                      );
                      debugPrint(timestamp);
                      // FIXME: send message
                      //await _apiService.sendMessage(conversation: conversation);
                    },
                  ),
                ],
              ),
              Positioned(
                top: kSpacingNone,
                left: kSpacingNone,
                right: kSpacingNone,
                child: ChatHeader(artisan: artisan),
              ),
            ],
          ));
}
