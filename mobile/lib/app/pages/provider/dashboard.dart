import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/service_locator.dart';
import 'package:handyman/core/utils.dart';
import 'package:handyman/data/local_database.dart';
import 'package:handyman/data/provider/artisan_api_provider.dart';
import 'package:handyman/domain/models/user.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _apiService = sl.get<ApiProviderService>();
  String _userId;

  @override
  void initState() {
    super.initState();

    _fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Consumer<PrefsProvider>(
        builder: (_, provider, __) => Stack(
          fit: StackFit.expand,
          children: [
            provider.isLightTheme
                ? Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(kBackgroundAsset),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            StreamBuilder<BaseUser>(
                stream: _apiService.getArtisanById(id: provider.userId),
                builder: (context, snapshot) {
                  _userId = provider.userId;
                  if (snapshot.hasError) return Container();

                  final artisan = snapshot.data?.user;

                  return Container(
                    child: Center(
                      child: Text(
                        artisan?.name ?? "Quabynah Bilson",
                        style: themeData.textTheme.headline4,
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  void _fetchUser() async {
    if (mounted) {
      final snapshot = await sl
          .get<FirebaseFirestore>()
          .collection(FirestoreUtils.kCustomerRef)
          .doc(_userId)
          .get();

      debugPrint(snapshot.data()?.toString());
      if (snapshot.exists) {
        await sl
            .get<LocalDatabase>()
            .providerDao
            .saveProvider(Artisan.fromJson(snapshot.data()));
      }
    }
  }
}
