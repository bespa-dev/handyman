import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/routes/route.gr.dart';
import 'package:handyman/app/widget/buttons.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/entities/customer_model.dart';
import 'package:handyman/data/local_database.dart';
import 'package:handyman/domain/models/user.dart';
import 'package:handyman/domain/services/data.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';

class UserInfoPage extends StatefulWidget {
  final Customer customer;

  const UserInfoPage({
    Key key,
    @required this.customer,
  }) : super(key: key);

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  bool _isCurrentUser = false;
  double _kWidth, _kHeight;
  ThemeData _themeData;

  @override
  void initState() {
    super.initState();

    // Update current user state
    if (mounted) {
      final provider = PrefsProvider.instance;
      _isCurrentUser = provider.userId == widget.customer.id;
      debugPrint("Current user => ${widget.customer.id} : ${provider.userId}");
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _themeData = Theme.of(context);
    final size = MediaQuery.of(context).size;
    _kWidth = size.width;
    _kHeight = size.height;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PrefsProvider>(
      builder: (_, provider, __) => Scaffold(
        extendBody: true,
        body: Stack(
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
            Consumer<DataService>(
              builder: (_, dataService, __) => StreamBuilder<BaseUser>(
                  stream: dataService.getCustomerById(id: widget.customer.id),
                  initialData: CustomerModel(customer: widget.customer),
                  builder: (context, snapshot) {
                    return Column(
                      children: [
                        Spacer(),
                        /*_isCurrentUser
                            ?*/ _buildCompleteProfileBar(provider)
                            // : SizedBox.shrink(),
                      ],
                    );
                  }),
            ),
            Positioned(
              top: kSpacingNone,
              width: _kWidth,
              child: _buildAppbar(provider),
            ),
          ],
        ),
      ),
    );
  }

  // Builds top appbar
  Widget _buildAppbar(PrefsProvider provider) => SafeArea(
        child: Container(
          width: _kWidth,
          decoration: BoxDecoration(
            color: _themeData.scaffoldBackgroundColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                tooltip: "Go back",
                icon: Icon(Feather.x),
                onPressed: () => context.navigator.pop(),
              ),
              IconButton(
                tooltip: "Toggle theme",
                icon: Icon(
                  provider.isLightTheme ? Feather.moon : Feather.sun,
                ),
                onPressed: () => provider.toggleTheme(),
              ),
            ],
          ),
        ),
      );

  // Complete profile bar
  Widget _buildCompleteProfileBar(PrefsProvider provider) => Container(
        width: _kWidth,
        decoration: BoxDecoration(
          color: _themeData.colorScheme.secondary,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(kSpacingX36),
          vertical: getProportionateScreenHeight(kSpacingX24),
        ),
        clipBehavior: Clip.hardEdge,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Complete profile"),
              ],
            ),
            ButtonIconOnly(
              icon: Icons.arrow_right_alt_outlined,
              onPressed: () => context.navigator.popAndPush(
                Routes.profilePage,
              ),
            ),
          ],
        ),
      );
}
