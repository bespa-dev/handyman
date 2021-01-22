import 'package:flutter/material.dart';
import 'package:lite/app/widgets/widgets.dart';
import 'package:lite/domain/models/models.dart';
import 'package:lite/shared/shared.dart';

class SearchResultsCard extends StatefulWidget {
  const SearchResultsCard({@required this.results});

  final List<BaseUser> results;

  @override
  _SearchResultsCardState createState() => _SearchResultsCardState();
}

class _SearchResultsCardState extends State<SearchResultsCard> {
  @override
  Widget build(BuildContext context) {
    var results = widget.results;

    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemBuilder: (_, index) {
          var artisan = results[index];
          return Card(
            child: ListTile(
              onTap: () =>
                  context.navigator.pushArtisanInfoPage(artisan: artisan),
              title: Text(artisan.name ?? 'Anonymous'),
              subtitle: Text('Tap for more details'),
              trailing: IconButton(
                icon: Icon(kChatIcon),
                onPressed: () => context.navigator.pushConversationPage(
                  recipientId: artisan.id,
                ),
              ),
              leading: UserAvatar(
                url: artisan.avatar,
                radius: kSpacingX28,
                isCircular: true,
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => SizedBox(height: kSpacingX6),
        itemCount: results.length,
      ),
    );
  }
}
