import 'package:flutter/material.dart';
import 'package:handyman/app/widget/user_avatar.dart';
import 'package:handyman/core/size_config.dart';
import 'package:handyman/data/local_database.dart';
import 'package:random_color/random_color.dart';
import 'package:uuid/uuid.dart';

class CustomerReviewCard extends StatefulWidget {
  final CustomerReview review;

  const CustomerReviewCard({Key key, this.review}) : super(key: key);

  @override
  _CustomerReviewCardState createState() => _CustomerReviewCardState();
}

class _CustomerReviewCardState extends State<CustomerReviewCard> {
  Customer _customer;

  @override
  void initState() {
    super.initState();
    _fetchMetaDataForReview();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final kHeight = MediaQuery.of(context).size.height;
    final kWidth = MediaQuery.of(context).size.width;

    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        width: kWidth,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(),
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(8),
          horizontal: getProportionateScreenWidth(12),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserAvatar(
              url: _customer?.avatar ?? "",
              ringColor: RandomColor()
                  .randomColor(colorBrightness: ColorBrightness.dark),
            ),
            SizedBox(width: getProportionateScreenWidth(16)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  _customer?.name ?? "",
                  style: themeData.textTheme.headline6.copyWith(
                    fontFamily: themeData.textTheme.bodyText1.fontFamily,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: getProportionateScreenHeight(8)),
                ConstrainedBox(
                  constraints: BoxConstraints.expand(
                      width: kWidth * 0.6, height: kHeight * 0.1),
                  child: Text(
                    widget.review.review ?? "",
                    style: themeData.textTheme.bodyText2,
                    maxLines: 3,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _fetchMetaDataForReview() async {
    _customer = Customer(
      id: Uuid().v4(),
      name: "Grace Willocks",
      email: "grace@gmail.com",
    );
    setState(() {});
  }
}
