/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  final Color color;
  final bool circular;

  const Loading({
    Key key,
    this.color,
    this.circular = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: circular
          ? CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation(
                  color ?? Theme.of(context).colorScheme.secondary),
            )
          : SpinKitCircle(
              color: color ?? Theme.of(context).colorScheme.secondary,
            ),
    );
  }
}
