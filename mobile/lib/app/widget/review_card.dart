import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:handyman/app/model/prefs_provider.dart';
import 'package:handyman/app/routes/route.gr.dart';
import 'package:handyman/app/widget/user_avatar.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/local_database.dart';
import 'package:handyman/domain/models/user.dart';
import 'package:handyman/domain/services/data.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';
import 'package:random_color/random_color.dart';
import 'package:share/share.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import 'buttons.dart';

class CustomerReviewCard extends StatefulWidget {
  final CustomerReview review;
  final DataService apiService;
  final String userId;

  const CustomerReviewCard({
    Key key,
    @required this.review,
    @required this.apiService,
    @required this.userId,
  }) : super(key: key);

  @override
  _CustomerReviewCardState createState() => _CustomerReviewCardState();
}

class _CustomerReviewCardState extends State<CustomerReviewCard> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final kWidth = SizeConfig.screenWidth;

    return StreamBuilder<BaseUser>(
        stream: widget.apiService.getCustomerById(id: widget.userId),
        builder: (context, snapshot) {
          final Customer customer = snapshot.data?.user;
          return GestureDetector(
            onLongPress: () => showReviewOptions(),
            child: Container(
              width: kWidth,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: themeData.cardColor,
                borderRadius: BorderRadius.circular(kSpacingX16),
              ),
              padding: EdgeInsets.fromLTRB(
                getProportionateScreenWidth(kSpacingX12),
                getProportionateScreenHeight(kSpacingX8),
                getProportionateScreenWidth(kSpacingX12),
                getProportionateScreenHeight(kSpacingX16),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(kSpacingX8),
                vertical: getProportionateScreenHeight(kSpacingX4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      UserAvatar(
                        url: customer?.avatar ?? "",
                        ringColor: RandomColor(1).randomColor(
                            colorBrightness: ColorBrightness.veryDark),
                      ),
                      SizedBox(width: getProportionateScreenWidth(kSpacingX16)),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                                text:
                                    "@${customer?.name?.toString()?.toLowerCase()?.replaceAll(" ", "_")}",
                                style: themeData.textTheme.caption,
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.navigator.push(Routes.userInfoPage,
                                        arguments: UserInfoPageArguments(
                                            customer: customer));
                                  }),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                              height: getProportionateScreenHeight(kSpacingX8)),
                          ConstrainedBox(
                            constraints: BoxConstraints.tightFor(
                              width: kWidth * 0.6,
                            ),
                            child: Text(
                              widget.review.review ?? "",
                              style: themeData.textTheme.bodyText1,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Entypo.dots_three_vertical),
                    iconSize: kSpacingX16,
                    color: themeData.primaryIconTheme.color,
                    onPressed: () => showReviewOptions(),
                  ),
                ],
              ),
            ),
          );
        });
  }

  /// Sliding sheet for review options
  void showReviewOptions() async {
    final themeData = Theme.of(context);
    final currentUserId =
        Provider.of<PrefsProvider>(context, listen: false).userId;
    await showSlidingBottomSheet(context,
        builder: (_) => SlidingSheetDialog(
              headerBuilder: (_, __) => Container(
                height: getProportionateScreenHeight(kToolbarHeight),
                alignment: Alignment.center,
                child: Text(
                  "Actions for this review",
                  style: themeData.textTheme.button.copyWith(
                    color: themeData.colorScheme.onBackground,
                  ),
                ),
              ),
              builder: (_, __) {
                return Material(
                  child: Container(
                    padding: EdgeInsets.only(
                      bottom: getProportionateScreenHeight(kSpacingX16),
                    ),
                    width: SizeConfig.screenWidth,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: Text("Like"),
                          onTap: () {
                            _.navigator.pop();
                            showNotAvailableDialog(context);
                          },
                        ),
                        ListTile(
                          title: Text("Share"),
                          onTap: () {
                            _.navigator.pop();
                            Share.share(widget.review.review);
                          },
                        ),
                        widget.userId == currentUserId
                            ? ListTile(
                                title: Text("Delete"),
                                onTap: () {
                                  _.navigator.pop();
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      content: Text(
                                          "Do you wish to delete this review?"),
                                      actions: [
                                        ButtonClear(
                                          text: "No",
                                          onPressed: () => ctx.navigator.pop(),
                                          themeData: themeData,
                                        ),
                                        ButtonClear(
                                          text: "Yes",
                                          onPressed: () {
                                            widget.apiService.deleteReviewById(
                                                id: widget.review.id,
                                                customerId: widget.userId);
                                            ctx.navigator.pop();
                                          },
                                          themeData: themeData,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),
                );
              },
            ));
  }
}
