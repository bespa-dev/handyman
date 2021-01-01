/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:lite/domain/repositories/repositories.dart';

import 'usecase/result.dart';
import 'usecase/usecase.dart';

class UploadBusinessPhotosUseCase
    extends CompletableUseCase<UploadBusinessPhotosParams> {
  final BaseBusinessRepository _repo;

  const UploadBusinessPhotosUseCase(this._repo);

  @override
  Future<UseCaseResult<void>> execute(UploadBusinessPhotosParams params) async {
    try {
      await _repo.uploadBusinessPhotos(
          userId: params.userId, images: params.images);
      return UseCaseResult.success();
    } on Exception {
      return UseCaseResult.error("Failed to upload business images");
    }
  }
}

/// params
class UploadBusinessPhotosParams {
  final List<String> images;
  final String userId;

  const UploadBusinessPhotosParams({this.images, this.userId});
}
