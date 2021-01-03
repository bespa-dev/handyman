/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:super_enum/super_enum.dart';

part 'bloc_state.super.dart';

/// base state for all blocs
@superEnum
enum _BlocState {
  @object
  InitialState,
  @object
  LoadingState,
  @generic
  @Data(fields: [
    DataField<Generic>('data', required: false),
  ])
  SuccessState,
  @generic
  @Data(fields: [
    DataField<Generic>('failure'),
  ])
  ErrorState,
}
