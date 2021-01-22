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
import 'package:handyman/app/bloc/bloc.dart';
import 'package:handyman/app/widgets/widgets.dart';
import 'package:handyman/domain/models/models.dart';
import 'package:handyman/shared/shared.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  /// blocs
  final _searchBloc = SearchBloc(repo: Injection.get());
  final _serviceBloc = ArtisanServiceBloc(repo: Injection.get());

  /// UI
  bool _isSearching = false, _shouldShowMoreSuggestions = false;
  String _query = '';
  ThemeData kTheme;
  final _searchController = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode?.dispose();
    _searchBloc?.close();
    _serviceBloc?.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (mounted) {
      _serviceBloc.add(ArtisanServiceEvent.getAllArtisanServices());

      _searchBloc.listen((state) {
        if (state is LoadingState) {
          _isSearching = true;
          if (mounted) setState(() {});
          if (_focusNode.hasFocus) _focusNode.unfocus();
        } else if (state is SuccessState || state is ErrorState) {
          _isSearching = false;
          if (mounted) setState(() {});
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    kTheme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          padding: EdgeInsets.only(
            top: SizeConfig.screenHeight * 0.1,
            left: kSpacingX16,
            right: kSpacingX16,
          ),
          color: kTheme.colorScheme.background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints:
                    BoxConstraints.tightFor(width: SizeConfig.screenWidth),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: kToolbarHeight * 1.5,
                      ),
                      width: SizeConfig.screenWidth * 0.9,
                      padding: EdgeInsets.symmetric(
                        horizontal: kSpacingX16,
                        vertical: kSpacingX2,
                      ),
                      decoration: BoxDecoration(
                        color: kTheme.colorScheme.background,
                        borderRadius: BorderRadius.circular(kSpacingX8),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.search,
                        controller: _searchController,
                        cursorColor: kTheme.colorScheme.onBackground,
                        autofocus: false,
                        focusNode: _focusNode,
                        enableSuggestions: true,
                        onTap: () {
                          _isSearching = false;
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '\tSearch',
                          suffixIcon: IconButton(
                            icon: Icon(
                                _focusNode.hasFocus ? kSearchIcon : kCloseIcon),
                            color: kTheme.unselectedWidgetColor,
                            onPressed: () {
                              if (_searchController.text.isNotEmpty) {
                                _searchController.clear();
                              } else {
                                _performSearch();
                              }
                            },
                          ),
                          fillColor: kTheme.colorScheme.background,
                          helperStyle: kTheme.textTheme.caption,
                          hintStyle: kTheme.textTheme.headline4.copyWith(
                            color: kTheme.colorScheme.onBackground
                                .withOpacity(kEmphasisLow),
                          ),
                        ),
                        onSubmitted: (_) => _performSearch(),
                        maxLines: 3,
                        style: kTheme.textTheme.headline4
                            .copyWith(color: kTheme.colorScheme.onBackground),
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(kSpacingX8),
                    ),
                    Divider(
                      endIndent: getProportionateScreenWidth(kSpacingX64),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(kSpacingX12),
              ),
              Expanded(
                child: BlocBuilder<SearchBloc, BlocState>(
                    cubit: _searchBloc,
                    builder: (_, state) {
                      return state is SuccessState && !_focusNode.hasFocus
                          ? _buildResults()
                          : _isSearching
                              ? Loading()
                              : _buildSuggestions();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestions() => BlocBuilder<ArtisanServiceBloc, BlocState>(
        cubit: _serviceBloc,
        builder: (_, state) => state is SuccessState<List<BaseArtisanService>>
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Recommended searches...',
                    style: kTheme.textTheme.headline6.copyWith(
                      fontSize: kTheme.textTheme.bodyText1.fontSize,
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(kSpacingX16),
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: _shouldShowMoreSuggestions
                          ? state.data.length
                          : state.data.getRange(0, 3).length,
                      itemBuilder: (_, index) {
                        final item = state.data[index];
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          onTap: () {
                            _searchController.text = item.name;
                            _performSearch(item.id);
                          },
                          title: Text(
                            item.name,
                            style: kTheme.textTheme.headline5,
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => SizedBox(
                        height: getProportionateScreenHeight(kSpacingX4),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(kSpacingX8),
                  ),
                  GestureDetector(
                    onTap: () {
                      _shouldShowMoreSuggestions = !_shouldShowMoreSuggestions;
                      setState(() {});
                    },
                    child: Container(
                      alignment: Alignment.bottomRight,
                      margin: EdgeInsets.only(
                        right: getProportionateScreenWidth(kSpacingX24),
                      ),
                      padding: EdgeInsets.all(kSpacingX8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RotatedBox(
                            child: Icon(Icons.arrow_right_alt_outlined),
                            quarterTurns: _shouldShowMoreSuggestions ? 3 : 1,
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(kSpacingX4),
                          ),
                          Text(
                            """${_shouldShowMoreSuggestions ? "Collapse" : "Expand"}""",
                            style: kTheme.textTheme.headline6.copyWith(
                              fontSize: kTheme.textTheme.bodyText1.fontSize,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : SizedBox.shrink(),
      );

  Widget _buildNoResults() => Container(
        width: SizeConfig.screenWidth,
        child: emptyStateUI(
          context,
          message: 'Nothing found',
          icon: kSearchIcon,
          onTap: () => _performSearch(),
        ),
      );

  Widget _buildResults() => BlocBuilder<SearchBloc, BlocState>(
        cubit: _searchBloc,
        builder: (_, state) => state is SuccessState<List<BaseUser>>
            ? state.data.isEmpty
                ? _buildNoResults()
                : SearchResultsCard(results: state.data)
            : state is ErrorState
                ? _buildNoResults()
                : Loading(),
      );

  void _performSearch([String query]) {
    if (_searchController.text.isNotEmpty) {
      _query = query ?? _searchController.text?.trim();
      if (mounted) setState(() {});
      _searchBloc.add(SearchEvent.searchAllUsers(query: _query));
    }
  }
}
