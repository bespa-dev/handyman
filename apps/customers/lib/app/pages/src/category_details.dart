import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lite/app/bloc/bloc.dart';
import 'package:lite/app/widgets/src/artisan_card.dart';
import 'package:lite/app/widgets/widgets.dart';
import 'package:lite/domain/models/models.dart';
import 'package:lite/shared/shared.dart';

class CategoryDetailsPage extends StatefulWidget {
  const CategoryDetailsPage({Key key, @required this.category})
      : super(key: key);

  final BaseServiceCategory category;

  @override
  _CategoryDetailsPageState createState() => _CategoryDetailsPageState();
}

class _CategoryDetailsPageState extends State<CategoryDetailsPage> {
  final _userBloc = UserBloc(repo: Injection.get());
  ThemeData kTheme;

  @override
  void dispose() {
    _userBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (mounted) {
      _userBloc.add(
        UserEvent.observeArtisansEvent(category: widget.category.groupName),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    kTheme = Theme.of(context);
    return BlocBuilder<UserBloc, BlocState>(
      cubit: _userBloc,
      builder: (_, state) => Scaffold(
        body: state is SuccessState<Stream<List<BaseArtisan>>>
            ? Stack(
                children: [
                  Positioned.fill(
                    child: StreamBuilder<List<BaseArtisan>>(
                        stream: state.data.map((items) => items
                            .where((person) =>
                                person.category == widget.category.id)
                            .toList()),
                        initialData: [],
                        builder: (_, snapshot) {
                          final artisans = snapshot.data ?? [];
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Loading();
                          } else if (snapshot.hasError || artisans.isEmpty) {
                            return Center(
                              child: emptyStateUI(
                                context,
                                message: 'No artisans found',
                                onTap: () => _userBloc.add(
                                  UserEvent.observeArtisansEvent(
                                      category: widget.category.groupName),
                                ),
                              ),
                            );
                          }
                          return SafeArea(
                            child: Container(
                              width: SizeConfig.screenWidth,
                              height: SizeConfig.screenHeight,
                              margin: EdgeInsets.only(top: kSpacingX72),
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      getProportionateScreenWidth(kSpacingX16)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height: getProportionateScreenHeight(
                                          kSpacingX8)),
                                  Text(
                                    'Showing results for...',
                                    style: kTheme.textTheme.caption,
                                  ),
                                  Text(
                                    widget.category.name,
                                    style: kTheme.textTheme.headline3,
                                  ),
                                  SizedBox(
                                      height: getProportionateScreenHeight(
                                          kSpacingX16)),
                                  Expanded(
                                    child: _buildArtisanCard(artisans),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),

                  /// back button
                  Positioned(
                    top: kSpacingX36,
                    left: kSpacingX16,
                    child: IconButton(
                      icon: Icon(kBackIcon),
                      onPressed: () => context.navigator.pop(),
                    ),
                  ),
                ],
              )
            : Loading(),
      ),
    );
  }

  Widget _buildArtisanCard(List<BaseArtisan> data) {
    return AnimationLimiter(
      child: GridView.builder(
        addAutomaticKeepAlives: true,
        clipBehavior: Clip.hardEdge,
        cacheExtent: 200,
        itemBuilder: (_, index) {
          final artisan = data[index];
          return AnimationConfiguration.staggeredGrid(
            position: index,
            columnCount: 2,
            child: ScaleAnimation(
              child: FadeInAnimation(
                child: GridArtisanCardItem(artisan: artisan),
              ),
            ),
          );
        },
        itemCount: data.length,
        scrollDirection: Axis.vertical,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      ),
    );
  }
}
