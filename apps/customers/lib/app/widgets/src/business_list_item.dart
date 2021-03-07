import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lite/app/bloc/bloc.dart';
import 'package:lite/app/routes/routes.gr.dart';
import 'package:lite/domain/models/models.dart';
import 'package:lite/shared/shared.dart';

class BusinessListItem extends StatefulWidget {
  final BaseBusiness business;
  final BaseArtisan artisan;

  const BusinessListItem(
      {Key key, @required this.business, @required this.artisan})
      : super(key: key);

  @override
  _BusinessListItemState createState() => _BusinessListItemState();
}

class _BusinessListItemState extends State<BusinessListItem> {
  @override
  Widget build(BuildContext context) {
    final kTheme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kSpacingX4),
      ),
      clipBehavior: Clip.hardEdge,
      child: BlocBuilder<UserBloc, BlocState>(
        bloc: UserBloc(repo: Injection.get())
          ..add(
            UserEvent.getArtisanByIdEvent(id: widget.business.artisanId),
          ),
        builder: (_, state) => InkWell(
          splashColor: kTheme.splashColor,
          borderRadius: BorderRadius.circular(kSpacingX4),
          onTap: () => context.navigator.pushBusinessDetailsPage(
            business: widget.business,
            artisan: widget.artisan,
          ),
          child: Container(
            width: SizeConfig.screenWidth * 0.85,
            padding: EdgeInsets.symmetric(
              horizontal: kSpacingX12,
              vertical: kSpacingX8,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kSpacingX4),
            ),
            clipBehavior: Clip.hardEdge,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Business Details",
                  style: kTheme.textTheme.caption.copyWith(
                    color: kTheme.colorScheme.onBackground
                        .withOpacity(kEmphasisLow),
                  ),
                ),
                SizedBox(height: kSpacingX12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.business.name,
                      style: kTheme.textTheme.headline6,
                    ),
                    SizedBox(height: kSpacingX4),
                    Text(
                      widget.business.location,
                      style: kTheme.textTheme.bodyText1.copyWith(
                        color: kTheme.colorScheme.onBackground
                            .withOpacity(kEmphasisMedium),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
