import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:handyman/app/widget/user_avatar.dart';
import 'package:handyman/core/constants.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/entities/customer_model.dart';
import 'package:handyman/data/local_database.dart';
import 'package:handyman/data/provider/artisan_api_provider.dart';
import 'package:handyman/domain/models/user.dart';
import 'package:random_color/random_color.dart';
import 'package:uuid/uuid.dart';
import 'package:meta/meta.dart';

class CustomerReviewCard extends StatefulWidget {
  final CustomerReview review;
  final ApiProviderService apiService;
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
    final kHeight = MediaQuery.of(context).size.height;
    final kWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<BaseUser>(
        stream: widget.apiService.getCustomerById(id: widget.userId),
        builder: (context, snapshot) {
          final customer = snapshot.data.user;
          return Container(
            width: kWidth,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: themeData.cardColor,
              borderRadius: BorderRadius.circular(kSpacingX16),
            ),
            padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(kSpacingX8),
              horizontal: getProportionateScreenWidth(kSpacingX12),
            ),
            margin: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(kSpacingX8),
              vertical: getProportionateScreenHeight(kSpacingX4),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        UserAvatar(
                          url: customer?.avatar ?? "",
                          ringColor: RandomColor().randomColor(
                              colorBrightness: ColorBrightness.dark),
                        ),
                        SizedBox(
                            width: getProportionateScreenWidth(kSpacingX16)),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              customer?.name ?? "",
                              style: themeData.textTheme.headline6,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "@${customer?.name?.toString()?.toLowerCase()?.replaceAll(" ", "_")}",
                              style: themeData.textTheme.caption,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                                height:
                                    getProportionateScreenHeight(kSpacingX8)),
                            Text(
                              widget.review.review ?? "",
                              style: themeData.textTheme.bodyText2,
                              maxLines: 3,
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.fade,
                            ),
                            SizedBox(
                                height:
                                    getProportionateScreenHeight(kSpacingX8)),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: Icon(Feather.thumbs_up),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Feather.share_2),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.reply_outlined),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
