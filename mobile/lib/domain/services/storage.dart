import 'dart:io';

import 'package:meta/meta.dart';
import 'package:json_annotation/json_annotation.dart' as j;

part 'storage.g.dart';

enum UploadProgressState { DONE, FAILED, IN_PROGRESS, PAUSED }

@j.JsonSerializable()
@immutable
class StorageUploadResponse {
  final String url;
  final bool isInComplete;
  final UploadProgressState state;

  StorageUploadResponse({
    @required this.url,
    this.state = UploadProgressState.IN_PROGRESS,
    this.isInComplete = true,
  });

  factory StorageUploadResponse.fromJson(Map<String, dynamic> json) =>
      _$StorageUploadResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StorageUploadResponseToJson(this);
}

/// Base storage service
abstract class StorageService {
  Stream<StorageUploadResponse> uploadFile(File file, {String path});
}
