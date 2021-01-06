// import 'package:auto_route/auto_route.dart';
// import 'package:handyman/app/routes/routes.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:handyman/app/bloc/bloc.dart';
import 'package:handyman/app/routes/routes.gr.dart';
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
  final _prefsBloc = PrefsBloc(repo: Injection.get());
  final _categoryBloc = CategoryBloc(repo: Injection.get());

  /// UI
  ThemeData kTheme;
  String _selectedCategory;
  BaseArtisan _currentUser;
  bool _isLoading = false;

  @override
  void dispose() {
    _userBloc.close();
    _prefsBloc.close();
    _categoryBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    /// get user id
    _prefsBloc
      ..add(PrefsEvent.getUserIdEvent())
      ..listen((userIdState) {
        if (userIdState is SuccessState<String> && userIdState.data != null) {
          /// get artisan by id
          _userBloc.add(UserEvent.getArtisanByIdEvent(id: userIdState.data));
        }
      });

    /// user update status
    _userBloc.listen((state) {
      if (state is SuccessState<BaseArtisan>) {
        _currentUser = state.data;
        if (mounted) setState(() {});
      } else if (state is SuccessState<void>) {
        if (mounted) {
          showSnackBarMessage(context, message: "Profile updated successfully");
          context.navigator.popAndPush(Routes.businessProfilePage);
        }
      } else if (state is ErrorState) {
        if (mounted)
          showSnackBarMessage(context, message: "Failed to update profile");
      }
    });

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
          child: _isLoading
              ? Loading()
              : Stack(
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
                                  builder: (_, snapshot) =>
                                      SelectableGridCategory(
                                    categories: snapshot.data,
                                    selected: _selectedCategory,
                                    onSelected: (item) {
                                      _selectedCategory = item.id;
                                      setState(() {});
                                    },
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
                          if (_selectedCategory == null)
                            showSnackBarMessage(context,
                                message: "Please select a service first");
                          else {
                            final updatedUser = _currentUser.copyWith(
                              category: _selectedCategory,
                              categoryGroup:
                                  ServiceCategoryGroup.featured().name(),
                            );

                            /// update user profile information
                            _userBloc.add(UserEvent.updateUserEvent(
                              user: updatedUser,
                            ));
                            showSnackBarMessage(context,
                                message: "Updating profile");
                          }
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
