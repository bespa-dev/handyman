import 'dart:io';

import 'package:flutter/material.dart';
import 'package:handyman/app/widgets/widgets.dart';
import 'package:handyman/domain/repositories/repositories.dart';
import 'package:handyman/shared/shared.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  final _repo = Injection.get<BaseStorageRepository>();
  File _file;
  bool _loading = false;
  String _url;
  ThemeData _kTheme;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    _kTheme = Theme.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _pickFile,
        child: Icon(Icons.image_search_outlined),
      ),
      body: _loading ? _buildLoading() : _buildImagePicker(),
    );
  }

  /// pick file
  void _pickFile() async {
    var pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _file = File(pickedFile.path);
      _loading = true;
      setState(() {});
      _performUpload();
    }
  }

  /// upload to server
  void _performUpload() async {
    var path = Uuid().v4();
    _url = await _repo.uploadFile(_file.absolute.path, path: path);
    logger.i('download url -> $_url');
    _loading = false;
    _file = null;
    setState(() {});
  }

  Widget _buildImagePicker() => Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: kSpacingX120,
              width: kSpacingX120,
              decoration: BoxDecoration(
                color: _kTheme.colorScheme.secondary.withOpacity(kEmphasisLow),
                borderRadius: BorderRadius.circular(kSpacingX12),
              ),
              clipBehavior: Clip.hardEdge,
              child: _url == null
                  ? Icon(
                      Icons.image,
                      size: kSpacingX64,
                    )
                  : Image.network(
                      _url,
                      height: kSpacingX120,
                      width: kSpacingX120,
                      fit: BoxFit.cover,
                    ),
            ),
          ],
        ),
      );

  Widget _buildLoading() => Center(child: Loading());
}
