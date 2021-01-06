import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:handyman/app/bloc/bloc.dart';
import 'package:handyman/app/routes/routes.gr.dart';
import 'package:handyman/shared/shared.dart';

class BusinessProfilePage extends StatefulWidget {
  @override
  _BusinessProfilePageState createState() => _BusinessProfilePageState();
}

class _BusinessProfilePageState extends State<BusinessProfilePage> {
  final _businessBloc = BusinessBloc(repo: Injection.get());
  final _storageBloc = StorageBloc(repo: Injection.get());

  /// UI
  File _businessDocument;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    if (mounted) {
      _businessBloc.listen((state) {
        if (state is LoadingState) {
          _isLoading = true;
          if (mounted) setState(() {});
        } else if (state is ErrorState) {
          _isLoading = false;
          if (mounted) {
            setState(() {});
            showSnackBarMessage(context,
                message: "Failed to save business information");
          }
        } else if (state is SuccessState) {
          _isLoading = false;
          if (mounted) {
            setState(() {});
            context.navigator.pushAndRemoveUntil(
              Routes.homePage,
              (route) => false,
            );
          }
        }
      });
    }
  }

  @override
  void dispose() {
    _businessBloc.close();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
