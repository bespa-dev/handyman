/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:handyman/domain/repositories/repositories.dart';
import 'package:meta/meta.dart';

import 'usecase/result.dart';
import 'usecase/usecase.dart';

class UploadMediaUseCaseParams {
  final String path;
  final String filePath;
  final bool isImage;

  const UploadMediaUseCaseParams({
    @required this.path,
    @required this.filePath,
    this.isImage = true,
  });
}

class UploadMediaUseCase
    extends BackgroundUseCase<String, UploadMediaUseCaseParams> {
  final BaseStorageRepository _repo;

  const UploadMediaUseCase(this._repo);

  @override
  Future<UseCaseResult<String>> execute(params) async {
    try {
      var url = await _repo.uploadFile(
        params.filePath,
        path: params.path,
        isImageFile: params.isImage,
      );
      return UseCaseResult<String>.success(url);
    } on Exception {
      // cancel when process fails
      return UseCaseResult.error("failed to retrieve compressed file");
    }
  }
}
