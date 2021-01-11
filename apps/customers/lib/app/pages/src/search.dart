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

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool _isSearching = false, _shouldShowMoreSuggestions = true;
  String _query = "";
  SearchBloc _searchBloc = SearchBloc(repo: Injection.get());
  ThemeData kTheme;
  final _searchController = TextEditingController();

  FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode?.dispose();
    _searchBloc?.close();
    super.dispose();
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints:
                    BoxConstraints.tightFor(width: SizeConfig.screenWidth),
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: getProportionateScreenWidth(kSpacingX16),
                        ),
                        child: Text("Search"),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(kSpacingX8),
                      ),
                      Container(
                        constraints: BoxConstraints(
                          maxHeight: kToolbarHeight * 1.5,
                        ),
                        width: SizeConfig.screenWidth * 0.9,
                        padding: EdgeInsets.only(
                          left: getProportionateScreenWidth(kSpacingX16),
                          right: getProportionateScreenWidth(kSpacingX16),
                          top: getProportionateScreenHeight(kSpacingX2),
                          bottom: getProportionateScreenHeight(kSpacingX2),
                        ),
                        decoration: BoxDecoration(
                          color: kTheme.colorScheme.background,
                          borderRadius: BorderRadius.circular(kSpacingX8),
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.search,
                          controller: _searchController,
                          cursorColor: kTheme.colorScheme.onBackground,
                          autofocus: false,
                          focusNode: _focusNode,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "\tSearch",
                            suffixIcon: IconButton(
                              icon: Icon(kSearchIcon),
                              color: kTheme.unselectedWidgetColor,
                              onPressed: () {
                                if (_searchController.text.isNotEmpty) {
                                  _query = _searchController.text?.trim();
                                  _searchBloc.add(SearchEvent.searchAllUsers(
                                      query: _query));
                                }
                              },
                            ),
                            helperStyle: kTheme.textTheme.caption,
                            hintStyle: kTheme.textTheme.headline4.copyWith(
                              color: kTheme.colorScheme.onBackground
                                  .withOpacity(kEmphasisLow),
                            ),
                          ),
                          onFieldSubmitted: (_) {
                            if (_.isNotEmpty) {
                              _query = _?.trim();
                              _searchBloc.add(
                                  SearchEvent.searchAllUsers(query: _query));
                            }
                          },
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
              ),
              SizedBox(
                height: getProportionateScreenHeight(kSpacingX12),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: getProportionateScreenWidth(kSpacingX24),
                  ),
                  child: BlocBuilder<SearchBloc, BlocState>(
                      cubit: _searchBloc,
                      builder: (_, state) {
                        return state is SuccessState<List<BaseUser>> ||
                                _isSearching
                            ? _buildResults()
                            : state is SuccessState<List<String>>
                                ? _buildSuggestions(state.data)
                                : Loading();
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestions(List<String> suggestions) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Recommended searches...",
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
                  ? suggestions.length
                  : suggestions.getRange(0, 3).length,
              itemBuilder: (_, index) {
                final item = suggestions[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  onTap: () {
                    _query = item;
                    _isSearching = true;
                    if (_focusNode.hasFocus) _focusNode.unfocus();
                    setState(() {});
                  },
                  title: Text(
                    item,
                    style: kTheme.textTheme.headline4,
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
      );

  Widget _buildNoResults() => Container(
        width: SizeConfig.screenWidth,
        child: emptyStateUI(
          context,
          message: "We cannot find what you are looking for",
        ),
      );

  Widget _buildResults() {
    /// fixme -> load search results card
    return BlocBuilder<SearchBloc, BlocState>(
      cubit: _searchBloc,
      builder: (_, state) => state is SuccessState<List<BaseModel>>
          ? state.data.isEmpty
              ? _buildNoResults()
              : /*SearchResultsCard(results: state.data)*/ Container()
          : state is ErrorState
              ? _buildNoResults()
              : Loading(),
    );
  }
}
