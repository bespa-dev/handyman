import 'package:flutter/material.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/model/theme_provider.dart';
import 'package:handyman/core/service_locator.dart';
import 'package:handyman/data/provider/artisan_api_provider.dart';
import 'package:provider/provider.dart';

class ConversationPage extends StatefulWidget {
  final String sender, recipient;

  const ConversationPage({Key key, this.sender, this.recipient})
      : super(key: key);

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final _apiService = sl.get<ApiProviderService>();
  Stream<dynamic> _liveSender;
  Stream<dynamic> _liveRecipient;

  void _fetchMetadata() async {

  }

  @override
  void initState() {
    super.initState();
    _fetchMetadata();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Consumer<PrefsProvider>(
        builder: (_, prefsProvider, __) => Consumer<ThemeProvider>(
          builder: (_, themeProvider, __) => Container(
            child: Stack(
              fit: StackFit.expand,
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
