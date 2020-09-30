import 'package:flutter/material.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/model/theme_provider.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/service_locator.dart';
import 'package:handyman/data/local_database.dart';
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
              children: [
                themeProvider.isLightTheme
                    ? Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(kBackgroundAsset),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
                SafeArea(
                  child: StreamBuilder<Artisan>(
                    stream: _apiService.getArtisanById(id: widget.recipient),
                    builder: (_, snapshot) {
                      if (snapshot.hasError)
                        return Positioned.fill(
                            child: Text("No recipient found"));
                      else
                        return _buildChatWidget(snapshot.data);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChatWidget(Artisan artisan) {
    debugPrint(artisan.toString());
    return Column(
        children: [
          Text(artisan?.name ?? "no name"),
        ],
      );
  }
}
