/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:lite/domain/repositories/repositories.dart';
import 'package:lite/domain/repositories/src/storage/storage.dart';
import 'package:lite/shared/shared.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class StorageRepositoryImpl implements BaseStorageRepository {
  final StorageReference bucket;

  StorageRepositoryImpl({@required this.bucket});

  final _onStorageUploadResponseController =
      StreamController<StorageProgress>.broadcast();

  @override
  void dispose() {
    _onStorageUploadResponseController.close();
  }

  @override
  Stream<StorageProgress> get onStorageUploadResponse =>
      _onStorageUploadResponseController.stream;

  @override
  Future<String> uploadFile(String filePath,
      {String path, bool isImageFile = true}) async {
    var compressedFile = await compressMedia(filePath, isImageFile);
    var uploadTask = bucket.child(path ??= Uuid().v4()).putFile(compressedFile);

    /// listen for live stream of events from upload
    uploadTask.events.listen((event) async {
      switch (event.type) {
        case StorageTaskEventType.success:
          var url = await event.snapshot.ref.getDownloadURL();
          _onStorageUploadResponseController
              .add(StorageProgress.uploadSuccess(url: url));
          break;
        case StorageTaskEventType.failure:
          _onStorageUploadResponseController.add(StorageProgress.uploadFailed(
              cause: "Failed with error -> ${event.snapshot.error}"));
          break;
        case StorageTaskEventType.pause:
          _onStorageUploadResponseController
              .add(StorageProgress.uploadPaused());
          break;
        case StorageTaskEventType.resume:
          _onStorageUploadResponseController
              .add(StorageProgress.uploadInProgress());
          break;
        case StorageTaskEventType.progress:
          _onStorageUploadResponseController
              .add(StorageProgress.uploadInProgress());
          break;
      }
    });
    var snapshot = await uploadTask.onComplete; // get snapshot upon completion
    return await snapshot.ref.getDownloadURL(); // return download url
  }

  /// compress video & image files
  static Future<File> compressMedia(String filePath, bool isImage) async {
    try {
      if (isImage) {
        final docDir = await getTemporaryDirectory();
        final targetPath = join(docDir.absolute.path,
            "target${filePath.substring(filePath.lastIndexOf("."))}");
        logger.d("Path provided as params -> $filePath");
        logger.d("Target path created -> $targetPath");
        // compress image
        var result = await FlutterImageCompress.compressAndGetFile(
          filePath,
          targetPath,
          quality: 60,
          format: filePath.endsWith(".png")
              ? CompressFormat.png
              : CompressFormat.jpeg,
        );

        // log compression difference
        logger.i(
            "Image compressed from ${File(filePath).lengthSync()} to ${result.lengthSync()}");

        // return compressed image
        return result;
      } else {
        // return a file for upload from path
        return File(filePath);
      }
    } on Exception {
      return null;
    }
  }
}
