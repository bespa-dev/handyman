import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:handyman/app/bloc/bloc.dart';
import 'package:handyman/app/routes/routes.gr.dart';
import 'package:handyman/domain/repositories/repositories.dart';
import 'package:handyman/shared/shared.dart';

class CategoryPickerPage extends StatefulWidget {
  @override
  _CategoryPickerPageState createState() => _CategoryPickerPageState();
}

class _CategoryPickerPageState extends State<CategoryPickerPage> {
  /// blocs
  final _authBloc = AuthBloc(repo: Injection.get());
  final _userBloc = UserBloc(repo: Injection.get());

  /// UI
  ThemeData kTheme;
  bool _isLoading = false;

  /// form
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(),
      _nameController = TextEditingController(),
      _passwordController = TextEditingController();

  @override
  void dispose() {
    _userBloc.close();
    _authBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    /// observe auth state
    _authBloc
      ..add(AuthEvent.observeAuthStatetEvent())
      ..add(AuthEvent.observeMessageEvent())
      ..listen((state) {
        if (state is SuccessState<Stream<AuthState>>) {
          /// stream auth state
          state.data.listen((event) {
            if (event is AuthLoadingState) {
              _isLoading = true;
              if (mounted) setState(() {});
            } else if (event is AuthFailedState) {
              _isLoading = false;
              if (mounted) {
                setState(() {});
                showSnackBarMessage(context,
                    message: event.message ?? "Authentication failed");
              }
            } else if (event is AuthenticatedState) {
              _isLoading = false;
              if (mounted) {
                setState(() {});
                context.navigator.pushAndRemoveUntil(
                    Routes.businessProfilePage, (route) => false);
              }
            }
          });
        } else if (state is SuccessState<Stream<String>>) {
          /// stream messages
          state.data.listen((message) {
            if (mounted) showSnackBarMessage(context, message: message);
          });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    kTheme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Text(
          "Category picker",
          style: kTheme.textTheme.headline4,
        ),
      ),
    );
  }
}
