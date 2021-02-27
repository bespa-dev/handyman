/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lite/app/bloc/bloc.dart';
import 'package:lite/app/widgets/widgets.dart';
import 'package:lite/domain/models/models.dart';
import 'package:lite/shared/shared.dart';

class ArtisansPage extends StatefulWidget {
  @override
  _ArtisansPageState createState() => _ArtisansPageState();
}

class _ArtisansPageState extends State<ArtisansPage> {
  /// blocs
  final _categoryBloc = CategoryBloc(repo: Injection.get());

  /// UI
  ThemeData kTheme;

  @override
  void dispose() {
    _categoryBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (mounted) {
      /// fetch all categories
      _categoryBloc.add(
        CategoryEvent.observeAllCategories(
            group: ServiceCategoryGroup.featured()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    kTheme = Theme.of(context);
    return BlocBuilder<CategoryBloc, BlocState>(
      cubit: _categoryBloc,
      builder: (_, categoryState) => StreamBuilder<List<BaseServiceCategory>>(
        initialData: [],
        stream: categoryState is SuccessState<Stream<List<BaseServiceCategory>>>
            ? categoryState.data
            : Stream.empty(),
        builder: (_, categoriesSnapshot) => Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child: CustomScrollView(
            slivers: [
              /// categories' list header
              SliverList(
                delegate: SliverChildListDelegate.fixed(
                  [
                    /// header
                    Padding(
                      padding: EdgeInsets.only(
                        top: kSpacingX24,
                        left: kSpacingX16,
                        bottom: kSpacingX16,
                      ),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                                text: 'Services available\n',
                                style: kTheme.textTheme.headline5),
                            TextSpan(
                                text: kAppSloganDesc,
                                style: kTheme.textTheme.bodyText2.copyWith(
                                  color: kTheme.colorScheme.onBackground
                                      .withOpacity(kEmphasisLow),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// categories' list content
              SliverList(
                delegate: SliverChildListDelegate.fixed([
                  for (int position = 0;
                      position < categoriesSnapshot.data.length;
                      position++) ...{
                    ListCategoryCardItem(
                      category: categoriesSnapshot.data[position],
                    ),
                  },
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
