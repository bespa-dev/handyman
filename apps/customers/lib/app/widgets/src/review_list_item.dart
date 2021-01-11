import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lite/app/bloc/bloc.dart';
import 'package:lite/app/routes/routes.gr.dart';
import 'package:lite/app/widgets/widgets.dart';
import 'package:lite/domain/models/models.dart';
import 'package:lite/shared/shared.dart';

class ReviewListItem extends StatefulWidget {
  final BaseReview review;
  final Function onTap;

  const ReviewListItem({Key key, @required this.review, this.onTap})
      : super(key: key);

  @override
  _ReviewListItemState createState() => _ReviewListItemState();
}

class _ReviewListItemState extends State<ReviewListItem> {
  final _userBloc = UserBloc(repo: Injection.get());

  @override
  void dispose() {
    _userBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (mounted) {
      _userBloc
          .add(UserEvent.getCustomerByIdEvent(id: widget.review.customerId));
    }
  }

  @override
  Widget build(BuildContext context) {
    final kTheme = Theme.of(context);

    return BlocBuilder<UserBloc, BlocState>(
      cubit: _userBloc,
      builder: (_, state) => state is SuccessState<BaseUser>
          ? Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserAvatar(
                  url: state.data.avatar,
                  radius: kSpacingX36,
                  isCircular: true,
                  onTap: () => context.navigator
                      .pushImagePreviewPage(url: state.data.avatar),
                ),
                SizedBox(width: kSpacingX12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(state.data.name, style: kTheme.textTheme.headline6),
                      SizedBox(height: kSpacingX8),
                      ConstrainedBox(
                        constraints: BoxConstraints.tightFor(
                          width: SizeConfig.screenWidth * 0.9,
                        ),
                        child: Text(
                          widget.review.body,
                          style: kTheme.textTheme.bodyText2,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: kSpacingX12),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          parseFromTimestamp(
                            widget.review.createdAt,
                            fromNow: true,
                          ),
                          style: kTheme.textTheme.caption,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : SizedBox.shrink(),
    );
  }
}
