/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'package:lite/domain/models/models.dart';
import 'package:meta/meta.dart';
import 'package:super_enum/super_enum.dart';

part 'storage.super.dart';

/// storage progress
@superEnum
enum _StorageProgress {
  @Data(
    fields: [DataField<String>("url")],
  )
  UploadSuccess,
  @Data(
    fields: [DataField<String>("cause")],
  )
  UploadFailed,
  @object
  UploadInProgress,
  @object
  UploadPaused,
}

/// base storage repository class
abstract class BaseStorageRepository implements Exposable {
  /// observe upload progress
  Stream<StorageProgress> get onStorageUploadResponse;

  /// upload media file (pdf, image etc)
  Future<String> uploadFile(
    String filePath, {
    String path,
    bool isImageFile = true,
  });

  /// close all streams, if any
  void dispose();
}
