import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/pages/login.dart';
import 'package:handyman/app/routes/route.gr.dart';
import 'package:handyman/app/widget/booking_card_item.dart';
import 'package:handyman/app/widget/buttons.dart';
import 'package:handyman/app/widget/fields.dart';
import 'package:handyman/app/widget/user_avatar.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/entities/customer_model.dart';
import 'package:handyman/data/local_database.dart';
import 'package:handyman/data/services/data.dart';
import 'package:handyman/data/services/storage.dart';
import 'package:handyman/domain/models/user.dart';
import 'package:handyman/domain/services/auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  double _kWidth, _kHeight;
  ThemeData _themeData;
  final _dataService = DataServiceImpl.create();
  final _storageService = StorageServiceImpl.create();
  bool _isSaving = false;
  SheetController _sheetController = SheetController();

  File _avatar;
  String _userId;
  final picker = ImagePicker();

  Future<void> _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      debugPrint("Image picked as -> ${pickedFile.path}");
      _avatar = File(pickedFile.path);
      await _storageService.uploadFile(_avatar, path: _userId);
    } else {
      debugPrint('No image selected.');
    }
    setState(() {});
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
  void initState() {
    super.initState();
    if (mounted) {
      /// FIXME: User data not loaded when page is first viewed
      if (mounted)
        Future.delayed(kScaleDuration).then((value) => setState(() => {}));
      _storageService.onStorageUploadResponse.listen((event) {
        debugPrint(event.state.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) => Consumer<PrefsProvider>(
        builder: (_, provider, __) {
          _userId = provider.userId;
          return Scaffold(
            extendBodyBehindAppBar: true,
            extendBody: true,
            body: SafeArea(
              child: Stack(
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
                  Container(
                    height: _kHeight,
                    width: _kWidth,
                    child: Column(
                      children: [
                        _buildAppbar(provider),
                        Flexible(child: _buildProfileHeader(provider)),
                        Expanded(child: _buildProfileContent(provider)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );

  Widget _buildAppbar(PrefsProvider provider) => Container(
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
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  tooltip: "Toggle theme",
                  icon: Icon(
                    provider.isLightTheme ? Feather.moon : Feather.sun,
                  ),
                  onPressed: () => provider.toggleTheme(),
                ),
                IconButton(
                  icon: Icon(Entypo.info),
                  onPressed: () => showAboutDialog(
                    context: context,
                    applicationVersion: kAppVersion,
                    applicationName: kAppName,
                    applicationLegalese: kAppSloganDesc,
                    applicationIcon: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(kSpacingX16),
                      ),
                      child: Image(
                        image: Svg(kLogoAsset),
                        height: getProportionateScreenHeight(kSpacingX48),
                        width: getProportionateScreenHeight(kSpacingX48),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget _buildProfileHeader(PrefsProvider provider) => Container(
        // height: getProportionateScreenHeight(_kHeight * 0.5),
        width: _kWidth,
        padding: EdgeInsets.only(
          top: getProportionateScreenHeight(kSpacingX16),
        ),
        decoration: BoxDecoration(
          color: _themeData.cardColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(kSpacingX36),
            bottomRight: Radius.circular(kSpacingX36),
          ),
        ),
        child: Consumer<AuthService>(
          builder: (_, authService, __) => StreamBuilder<BaseUser>(
              stream: authService.currentUser(),
              builder: (context, snapshot) {
                final user = snapshot.data?.user;
                _nameController.text = user?.name;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _avatar == null
                        ? UserAvatar(
                            url: user?.avatar,
                            radius: kSpacingX120,
                            ringColor: _themeData.scaffoldBackgroundColor
                                .withOpacity(kEmphasisLow),
                            onTap: () => showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text("Select an option"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      title: Text("View"),
                                      leading: Icon(Feather.eye),
                                      onTap: () {
                                        ctx.navigator.pop();
                                        showNotAvailableDialog(ctx);
                                      },
                                    ),
                                    ListTile(
                                      title: Text("Change avatar"),
                                      leading: Icon(Feather.user),
                                      onTap: () async {
                                        ctx.navigator.pop();
                                        await _getImage();
                                      },
                                    ),
                                  ],
                                ),
                                actions: [
                                  ButtonClear(
                                    text: "Dismiss",
                                    onPressed: () => ctx.navigator.pop(),
                                    themeData: _themeData,
                                  )
                                ],
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () async => await _getImage(),
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.file(
                                _avatar,
                                fit: BoxFit.cover,
                                height:
                                    getProportionateScreenHeight(kSpacingX120),
                                width:
                                    getProportionateScreenHeight(kSpacingX120),
                              ),
                            ),
                          ),
                    SizedBox(height: getProportionateScreenHeight(kSpacingX16)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          user?.name ?? "",
                          style: _themeData.textTheme.headline5.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Feather.edit_2),
                          onPressed: () async => await _editProfileInfo(user),
                        ),
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(kSpacingX8)),
                    Text(
                      user?.email ?? "",
                      style: _themeData.textTheme.bodyText2,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: _themeData.cardColor.withOpacity(kEmphasisLow),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(kSpacingX16),
                        horizontal: getProportionateScreenWidth(kSpacingX8),
                      ),
                      margin: EdgeInsets.symmetric(
                        vertical: getProportionateScreenHeight(kSpacingX16),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text("Reviews"),
                              SizedBox(
                                height:
                                    getProportionateScreenHeight(kSpacingX8),
                              ),
                              StreamBuilder<List<CustomerReview>>(
                                  stream: _dataService
                                      .getReviewsByCustomer(provider.userId),
                                  initialData: [],
                                  builder: (context, snapshot) {
                                    return Text(
                                      "${snapshot.data.length}",
                                      style: _themeData.textTheme.headline6,
                                    );
                                  }),
                            ],
                          ),
                          Container(
                            height: getProportionateScreenHeight(kSpacingX8),
                            width: getProportionateScreenWidth(kSpacingX8),
                            decoration: BoxDecoration(
                              color: _themeData.primaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Column(
                            children: [
                              Text("Bookings"),
                              SizedBox(
                                height:
                                    getProportionateScreenHeight(kSpacingX8),
                              ),
                              StreamBuilder<List<Booking>>(
                                  stream: _dataService
                                      .getBookingsForCustomer(provider.userId),
                                  initialData: [],
                                  builder: (context, snapshot) {
                                    return Text(
                                      "${snapshot.data.length}",
                                      style: _themeData.textTheme.headline6,
                                    );
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ButtonPrimary(
                      width: _kWidth * 0.4,
                      themeData: _themeData,
                      color: _themeData.colorScheme.error,
                      enabled: user != null,
                      textColor: _themeData.colorScheme.onError,
                      onTap: () => showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text("Leaving already?"),
                          content: Text(
                            kSignOutText,
                          ),
                          actions: [
                            ButtonClear(
                              text: "No",
                              onPressed: () => ctx.navigator.pop(),
                              themeData: _themeData,
                            ),
                            ButtonClear(
                              text: "Yes",
                              onPressed: () async {
                                ctx.navigator.pop();
                                await authService.signOut();
                                context.navigator.pushAndRemoveUntil(
                                  Routes.loginPage,
                                  (route) => route is LoginPage,
                                );
                              },
                              themeData: _themeData,
                            ),
                          ],
                        ),
                      ),
                      label: "Sign out",
                    ),
                  ],
                );
              }),
        ),
      );

  Widget _buildProfileContent(PrefsProvider provider) => Container(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(kSpacingX24),
        ),
        width: _kWidth,
        child: StreamBuilder<List<Booking>>(
            stream: _dataService.getBookingsForCustomer(provider.userId),
            initialData: [],
            builder: (context, snapshot) {
              return AnimationLimiter(
                child: snapshot.data.isEmpty
                    ? Container(
                        height: kSpacingX320,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Entypo.bucket,
                              size: getProportionateScreenHeight(kSpacingX96),
                              color: _themeData.colorScheme.onBackground,
                            ),
                            SizedBox(
                                height:
                                    getProportionateScreenHeight(kSpacingX24)),
                            Text(
                              "No bookings",
                              style: _themeData.textTheme.subtitle1,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                                height:
                                    getProportionateScreenHeight(kSpacingX8)),
                            Text(
                              "You do not have any bookings yet",
                              style: _themeData.textTheme.bodyText2.copyWith(
                                color: _themeData.disabledColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: _kWidth,
                            decoration: BoxDecoration(),
                            padding: EdgeInsets.symmetric(
                              vertical:
                                  getProportionateScreenHeight(kSpacingX24),
                              horizontal:
                                  getProportionateScreenWidth(kSpacingX16),
                            ),
                            child: Text(
                              "My Recent Bookings",
                              textAlign: TextAlign.start,
                              style: _themeData.textTheme.headline6,
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (_, index) =>
                                  AnimationConfiguration.staggeredList(
                                position: index,
                                duration: kScaleDuration,
                                child: SlideAnimation(
                                  verticalOffset: kSlideOffset,
                                  child: FadeInAnimation(
                                    child: BookingCardItem(
                                      booking: snapshot.data[index],
                                      onTap: () => context.navigator.push(
                                        Routes.bookingsDetailsPage,
                                        arguments: BookingsDetailsPageArguments(
                                          booking: snapshot.data[index],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              );
            }),
      );

  Future<void> _editProfileInfo(Customer user) async =>
      await showSlidingBottomSheet(context,
          builder: (context) => SlidingSheetDialog(
                elevation: kSpacingX8,
                controller: _sheetController,
                dismissOnBackdropTap: false,
                addTopViewPaddingOnFullscreen: true,
                headerBuilder: (_, __) => Material(
                  type: MaterialType.card,
                  clipBehavior: Clip.hardEdge,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(kSpacingX16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Update profile information",
                          style: _themeData.textTheme.headline6,
                        ),
                        IconButton(
                          icon: Icon(
                            Feather.chevron_down,
                          ),
                          color: _themeData.colorScheme.onBackground,
                          onPressed: () => context.navigator.pop(),
                        ),
                      ],
                    ),
                  ),
                ),
                footerBuilder: (ctx, __) => Material(
                  type: MaterialType.card,
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    onTap: () async {
                      if (_formKey.currentState.validate()) {
                        /// Fix for setState in a non-stateful widget child
                        /// https://stackoverflow.com/questions/52414629/how-to-update-state-of-a-modalbottomsheet-in-flutter
                        _sheetController.rebuild();
                        setState(() {
                          _isSaving = true;
                        });
                        await _dataService.updateUser(
                          CustomerModel(
                            customer: user.copyWith(
                              name: _nameController.text.trim(),
                            ),
                          ),
                        );
                        setState(() {
                          _isSaving = false;
                        });
                        ctx.navigator.pop();
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: getProportionateScreenHeight(kToolbarHeight),
                      width: _kWidth,
                      decoration: BoxDecoration(
                        color: _themeData.colorScheme.secondary,
                      ),
                      child: _isSaving
                          ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(
                                  _themeData.colorScheme.onSecondary),
                            )
                          : Text(
                              "Save & continue".toUpperCase(),
                              style: _themeData.textTheme.button.copyWith(
                                color: _themeData.colorScheme.onSecondary,
                              ),
                            ),
                    ),
                  ),
                ),
                color:
                    _themeData.scaffoldBackgroundColor.withOpacity(kOpacityX50),
                duration: kScaleDuration,
                cornerRadius: kSpacingX16,
                snapSpec: const SnapSpec(
                  snap: true,
                  snappings: [0.4, 0.75, 1.0],
                  positioning: SnapPositioning.relativeToAvailableSpace,
                ),
                padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(kSpacingX8),
                ),
                builder: (context, state) {
                  return Material(
                    type: MaterialType.card,
                    clipBehavior: Clip.hardEdge,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(kSpacingX24),
                        vertical: getProportionateScreenHeight(kSpacingX36),
                      ),
                      decoration: BoxDecoration(),
                      child: Column(
                        children: [
                          Form(
                            key: _formKey,
                            child: TextFormInput(
                              labelText: "Full Name",
                              controller: _nameController,
                              onFieldSubmitted: (username) async {
                                setState(() {
                                  _isSaving = !_isSaving;
                                });
                                await _dataService.updateUser(
                                  CustomerModel(
                                    customer: user.copyWith(name: username),
                                  ),
                                );
                                setState(() {
                                  _isSaving = !_isSaving;
                                });
                                context.navigator.pop();
                              },
                              validator: (input) => input.isNotEmpty
                                  ? null
                                  : "Enter your full name",
                              color: _themeData.colorScheme.onBackground,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ));
}
