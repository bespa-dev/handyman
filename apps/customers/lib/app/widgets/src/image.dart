/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lite/shared/shared.dart';

class ImageView extends StatelessWidget {
  final double height;
  final double width;
  final double radius;
  final bool isInteractive;
  final bool useImageProvider;
  final bool isAssetImage;
  final bool isFileImage;
  final bool showErrorIcon;
  final String imageUrl;
  final Function onTap;
  final BoxFit fit;
  final String tag;

  const ImageView({
    Key key,
    @required this.imageUrl,
    this.height,
    this.width,
    this.onTap,
    this.radius = kSpacingNone,
    this.fit = BoxFit.cover,
    this.isInteractive = false,
    this.useImageProvider = false,
    this.isAssetImage = false,
    this.isFileImage = false,
    this.showErrorIcon = true,
    this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final kTheme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      splashColor: kTheme.splashColor,
      borderRadius: BorderRadius.circular(radius),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: height ?? SizeConfig.screenHeight * 0.4,
          maxHeight: height ?? SizeConfig.screenHeight,
          minWidth: width ?? SizeConfig.screenWidth,
        ),
        child: imageUrl == null
            ? _buildError(context)
            : Hero(
                tag: tag ?? imageUrl,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: InteractiveViewer(
                    scaleEnabled: isInteractive,
                    panEnabled: isInteractive,
                    child: useImageProvider
                        ? Image.network(
                            imageUrl,
                            width: width ?? SizeConfig.screenWidth,
                            filterQuality: FilterQuality.low,
                            fit: fit,
                            errorBuilder: (_, __, ___) => _buildError(context),
                            loadingBuilder: (_, __, ___) =>
                                _buildPlaceHolder(context),
                          )
                        : isAssetImage
                            ? Image.asset(
                                imageUrl,
                                width: width ?? SizeConfig.screenWidth,
                                filterQuality: FilterQuality.low,
                                fit: fit,
                                errorBuilder: (_, __, ___) =>
                                    _buildError(context),
                              )
                            : isFileImage
                                ? Image.file(
                                    File(imageUrl),
                                    width: width ?? SizeConfig.screenWidth,
                                    filterQuality: FilterQuality.low,
                                    fit: fit,
                                    errorBuilder: (_, __, ___) =>
                                        _buildError(context),
                                  )
                                : imageUrl == null || imageUrl.isEmpty
                                    ? _buildError(context)
                                    : CachedNetworkImage(
                                        imageUrl: imageUrl,
                                        width: width ?? SizeConfig.screenWidth,
                                        filterQuality: FilterQuality.low,
                                        fit: fit,
                                        placeholder: (_, __) =>
                                            _buildPlaceHolder(context),
                                        errorWidget: (_, __, ___) =>
                                            _buildError(context),
                                      ),
                  ),
                ),
              ),
      ),
    );
  }

  /// placeholder view
  Widget _buildPlaceHolder(context) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: Theme.of(context).cardColor,
        ),
        clipBehavior: Clip.hardEdge,
      );

  /// error view
  Widget _buildError(context) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: Theme.of(context)
              .colorScheme
              .background
              .withOpacity(kEmphasisLow),
        ),
        clipBehavior: Clip.hardEdge,
        alignment: Alignment.center,
        child: showErrorIcon
            ? Center(
                child: Icon(
                  kUserImageNotFound,
                  size: radius != 0 ? radius * 2 : kSpacingX56,
                  color: Theme.of(context).cardColor,
                ),
              )
            : SizedBox.shrink(),
      );
}
