import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:handyman/core/service_locator.dart';
import 'package:handyman/domain/services/storage.dart';
import 'package:meta/meta.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:uuid/uuid.dart';

@immutable
class StorageServiceImpl implements StorageService {
  final _bucket = sl.get<StorageReference>();

  StorageServiceImpl._();

  static StorageServiceImpl get instance => StorageServiceImpl._();

  @override
  Stream<StorageUploadResponse> uploadFile(File file, {String path}) async* {
    path = path ??= Uuid().v4();
    final dir = await path_provider.getTemporaryDirectory();
    final targetPath = dir.absolute.path + "/$path.jpg";
    final filePath = file.absolute.path;
    print("File path => $filePath");
    print("Target path => $targetPath");
    final result = await FlutterImageCompress.compressAndGetFile(
      filePath,
      targetPath,
      quality: 80, // Compress to 80% image quality
      minHeight: 512,
      minWidth: 512,
      format: filePath.endsWith("jpg") || filePath.endsWith("jpeg")
          ? CompressFormat.jpeg
          : CompressFormat.png,
    );

    // Upload to storage bucket
    var events = _bucket.child(path).putFile(result).events;
    events.listen((event) async* {
      print("Uploading => ${_bytesTransferred(event.snapshot)}");
      yield StorageUploadResponse(
          url: null, state: UploadProgressState.IN_PROGRESS);

      switch (event.type) {
        case StorageTaskEventType.success:
          event.snapshot.ref.getDownloadURL().then((url) async* {
            yield StorageUploadResponse(
              url: url,
              state: UploadProgressState.DONE,
              isInComplete: false,
            );
          }).catchError((e) async* {
            yield StorageUploadResponse(
                url: null, state: UploadProgressState.FAILED);
          });
          break;
        case StorageTaskEventType.resume:
        case StorageTaskEventType.progress:
          yield StorageUploadResponse(
              url: null, state: UploadProgressState.IN_PROGRESS);
          break;
        case StorageTaskEventType.pause:
          yield StorageUploadResponse(
              url: null, state: UploadProgressState.PAUSED);
          break;
        case StorageTaskEventType.failure:
          yield StorageUploadResponse(
              url: null, state: UploadProgressState.FAILED);
          break;
      }
    });
  }

  // Get progress as a percentage
  double _bytesTransferred(StorageTaskSnapshot snapshot) =>
      (snapshot.bytesTransferred / snapshot.totalByteCount) * 100;

  Future<StorageUploadResponse> uploadNow(
    File result,
    String key, {
    @required Function(String) onComplete,
    Function onCancel,
    Function(double) onProgress,
  }) async {}
}
