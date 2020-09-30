import 'package:flutter/material.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/model/theme_provider.dart';
import 'package:provider/provider.dart';

class ConversationPage extends StatefulWidget {
  final dynamic sender, recipient;

  const ConversationPage({Key key, this.sender, this.recipient})
      : super(key: key);

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  @override
  Widget build(BuildContext context) {
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
