import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handyman/app/bloc/bloc.dart';
import 'package:handyman/app/widgets/src/category_card.dart';
import 'package:handyman/app/widgets/widgets.dart';
import 'package:handyman/domain/models/models.dart';
import 'package:handyman/shared/shared.dart';

class CategoryPickerPage extends StatefulWidget {
  @override
  _CategoryPickerPageState createState() => _CategoryPickerPageState();
}

class _CategoryPickerPageState extends State<CategoryPickerPage> {
  /// blocs
  final _userBloc = UserBloc(repo: Injection.get());
  final _categoryBloc = CategoryBloc(repo: Injection.get());

  /// UI
  ThemeData kTheme;
  bool _isLoading = false;
  List<String> _selectedCategories = [];

  @override
  void dispose() {
    _userBloc.close();
    _categoryBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    /// observe categories
    _categoryBloc.add(
      CategoryEvent.observeAllCategories(
        group: ServiceCategoryGroup.featured(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    kTheme = Theme.of(context);
    return BlocBuilder<CategoryBloc, BlocState>(
      cubit: _categoryBloc,
      builder: (_, state) => Scaffold(
        backgroundColor: kTheme.colorScheme.primary,
        body: SafeArea(
          child: Stack(
            children: [
              /// content
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: kSpacingX24,
                    horizontal: kSpacingX12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Select your favorite service",
                        style: kTheme.textTheme.headline4.copyWith(
                          color: kTheme.colorScheme.onPrimary,
                        ),
                      ),
                      SizedBox(height: kSpacingX4),
                      Text(
                        "Select some of your favorite services to help us connect you to more customers",
                        style: kTheme.textTheme.bodyText2.copyWith(
                          color: kTheme.colorScheme.onPrimary,
                        ),
                      ),
                      SizedBox(height: kSpacingX16),
                      if (state is SuccessState<
                          Stream<List<BaseServiceCategory>>>) ...{
                        Expanded(
                          child: StreamBuilder<List<BaseServiceCategory>>(
                            stream: state.data,
                            initialData: [],
                            builder: (_, snapshot) => GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemCount: snapshot.data.length,
                              itemBuilder: (_, index) {
                                final category = snapshot.data[index];
                                return GridCategoryCardItem(
                                  category: category,
                                  isSelectable: true,
                                  onSelected: (item) {
                                    _selectedCategories.addIfDoesNotExist(item);
                                    setState(() {});
                                  },
                                );
                              },
                              padding: EdgeInsets.only(bottom: kSpacingX36),
                              addAutomaticKeepAlives: false,
                              cacheExtent: 100,
                            ),
                          ),
                        ),
                      } else ...{
                        Loading(color: kTheme.colorScheme.secondary),
                      }
                    ],
                  ),
                ),
              ),

              /// action button
              Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  splashColor: kTheme.splashColor,
                  onTap: () {
                    logger.d("services -> $_selectedCategories");
                  },
                  child: Container(
                    width: SizeConfig.screenWidth,
                    alignment: Alignment.center,
                    height: kToolbarHeight,
                    decoration: BoxDecoration(
                      color: kTheme.colorScheme.secondary,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Next",
                          style: kTheme.textTheme.button.copyWith(
                            color: kTheme.colorScheme.onSecondary,
                          ),
                        ),
                        SizedBox(width: kSpacingX12),
                        Icon(
                          kArrowIcon,
                          color: kTheme.colorScheme.onSecondary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
