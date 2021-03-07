/*
 * Copyright (c) 2021.
 * This application is owned by HandyMan LLC,
 * developed & designed by Quabynah Codelabs LLC.
 *
 *
 * author: codelbas.quabynah@gmail.com
 */

/// extensions on list
extension ListX on List<dynamic> {
  /// add an [item] to an existing [List] if it does not already contain it
  void addIfDoesNotExist(dynamic item) {
    if (this == null) return;
    if (!contains(item)) add(item);
  }

  /// remove an [item] to an existing [List] if it does not already contain it
  void removeIfExists(dynamic item) {
    if (this == null) return;
    if (contains(item)) remove(item);
  }
}
