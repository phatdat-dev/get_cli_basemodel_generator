// ignore_for_file: camel_case_types

import '../../interface/sample_interface.dart';

class Wwww3qDatz_text_editing_controller_extension_Sample extends Sample {
  Wwww3qDatz_text_editing_controller_extension_Sample()
      : super('lib/app/core/utils/extension/text_editing_controller_extension.dart', overwrite: true);

  @override
  String get content =>
      '''
import 'package:flutter/material.dart';


extension TextEditingControllerExtension on TextEditingController {
  void selectionAll() {
    if (selection.extentOffset != text.length) selection = TextSelection(baseOffset: 0, extentOffset: text.length);
  }
}
''';
}

class Wwww3qDatz_string_extension_Sample extends Sample {
  Wwww3qDatz_string_extension_Sample() : super('lib/app/core/utils/extension/string_extension.dart', overwrite: true);

  @override
  String get content =>
      '''
import 'dart:convert';
import 'dart:math';

extension StringExtension on String {
  bool get isHexColor => RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})\$').hasMatch(this);

  int toInt() => int.tryParse(replaceAll(',', '')) ?? 0;

  double toDouble() => double.tryParse(replaceAll(',', '')) ?? 0;

  num? toNumber() => num.tryParse(replaceAll(',', ''));
  //random String
  static String randomString(int length) {
    var random = Random();
    var values = List<int>.generate(length, (i) => random.nextInt(256));
    return base64UrlEncode(values);
  }

  String toCapitalized() => length > 0 ? '\${this[0].toUpperCase()}\${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}

''';
}

class Wwww3qDatz_num_extension_Sample extends Sample {
  Wwww3qDatz_num_extension_Sample() : super('lib/app/core/utils/extension/num_extension.dart', overwrite: true);

  @override
  String get content =>
      '''
import 'package:intl/intl.dart';

extension NumExtension on num {
  // Vietnam
  // NumberFormat.simpleCurrency(locale: 'vi-VN', decimalDigits: 2).format(10000) //10.000,00 ₫
  // NumberFormat.simpleCurrency(name: 'VND', decimalDigits: 2).format(10000) //₫10,000.00

  // String formatNumberMoney([String? symbol]) => NumberFormat.currency(customPattern: '#,### \u00a4', symbol: symbol, decimalDigits: 5).format(this);
  String formatNumber() => NumberFormat('#,###', 'en_US').format(this);
  String formatNumberCompact() => NumberFormat.compact(locale: 'en_US').format(this);
}
''';
}

class Wwww3qDatz_map_extension_Sample extends Sample {
  Wwww3qDatz_map_extension_Sample() : super('lib/app/core/utils/extension/map_extension.dart', overwrite: true);

  @override
  String get content =>
      '''
import 'list_extension.dart';

extension MapExtension<K, V> on Map<K, V> {
  Iterable<MapEntry<K, V>> _filterr(bool Function(MapEntry<K, V> entry) f) sync* {
    for (final entry in entries) {
      if (f(entry)) yield entry;
    }
  }

  //get list value with key
  List<V> getValues(List<K> keys) => keys.map((key) => this[key]!).toList();
  //get map value with key
  Map<K, V> getMap(List<K> keys) => Map.fromEntries(_filterr((entry) => keys.contains(entry.key)));

  //filter
  Map<K, V> filter(bool Function(K key, V value) test) {
    final result = <K, V>{};
    for (final entry in entries) {
      if (test(entry.key, entry.value)) result[entry.key] = entry.value;
    }
    return result;
  }

  //insert index
  void insert({required int index, required K key, required V value}) {
    final result = <K, V>{};
    var i = 0;
    for (final entry in entries) {
      if (i == index) result[key] = value;
      result[entry.key] = entry.value;
      i++;
    }
    clear();
    addAll(result);
  }

  /// * if [addNew] is true, add new key
  ///
  /// * if [noCopyIfIsEmpty] is true, not copy if value is empty
  ///
  /// example:
  /// ```dart
  /// final map = {"1": "key1", "2": "key2"};
  /// final copy = {"1": "newKey1", "3": "addNewKey","empty":""};
  /// final result1 = map.copyWith(copy, addNew: true, noCopyIfIsEmpty: true);
  /// // {"1": "newKey1", "2": "key2", "3": "addNewKey"}
  /// final result2 = map.copyWith(copy, addNew: false, noCopyIfIsEmpty: true);
  /// // {"1": "newKey1", "2": "key2"}
  /// final result3 = map.copyWith(copy, addNew: true, noCopyIfIsEmpty: false);
  /// // {"1": "newKey1", "2": "key2", "3": "addNewKey", "empty": ""}
  /// final result4 = map.copyWith(copy, addNew: false, noCopyIfIsEmpty: false);
  /// // {"1": "newKey1", "2": "key2"}
  /// ```
  ///
  Map<K, V> copyWith(Map<K, V> copy, {bool addNew = false, bool noCopyIfIsEmpty = false}) {
    final result = Map<K, V>.from(this);
    for (final entry in copy.entries) {
      if (!(noCopyIfIsEmpty && (entry.value == null || entry.value == '')) && (containsKey(entry.key) || addNew)) {
        result[entry.key] = entry.value;
      }
    }
    return result;
  }

  /// return key of element index
  /// ```dart
  /// final mapData = {
  ///   "index1": "value1",
  ///   "index2": "value2",
  ///   "index3": "value3",
  ///   "index4": "value4",
  ///   "index5": "value5",
  /// };
  /// // swap data
  /// final keyOfIndex = mapData.keyOfIndex(3); //"index4"
  /// final removeIndex = mapData.remove(keyOfIndex!); //"value4"
  /// final newInsert = mapData.insert(index: 0, key: keyOfIndex, value: removeIndex!); //
  /// print(newInsert);// {"index4": "value4", "index1": "value1", "index2": "value2", "index3": "value3", "index5": "value5"}
  ///  ```
  K? keyOfIndex(int index) {
    if (index < 0 || index >= length) return null;
    return keys.elementAt(index);
  }

  // from GetX

  void addIf(dynamic condition, K key, V value) {
    if (condition is Condition) condition = condition();
    if (condition is bool && condition) {
      this[key] = value;
    }
  }

  void addAllIf(dynamic condition, Map<K, V> values) {
    if (condition is Condition) condition = condition();
    if (condition is bool && condition) addAll(values);
  }

  void assign(K key, V val) {
    clear();
    this[key] = val;
  }

  void assignAll(Map<K, V> val) {
    if (this == val) return;
    clear();
    addAll(val);
  }
}
''';
}

class Wwww3qDatz_list_extension_Sample extends Sample {
  Wwww3qDatz_list_extension_Sample() : super('lib/app/core/utils/extension/list_extension.dart', overwrite: true);

  @override
  String get content =>
      '''
typedef Condition = bool Function();

extension ListExtension<E> on List<E> {
  /// Provide access to the generic type at runtime.
  Type get subType => E;
  // Type typeOfElementsInList<T>(List<E> e) => T;

  //[100,5,2].reduce(plus);   //=107
  T plus<T extends num>(T first, T second) => (first + second) as T;
  //[100,5,2].reduce(minus);   //=97
  T minus<T extends num>(T first, T second) => (first - second) as T;
  //[100,5,2].reduce(multiphy);   //=1000
  T multiphy<T extends num>(T first, T second) => (first * second) as T;
  //[100,5,2].reduce(divide);   //=10
  T divide<T extends num>(T first, T second) {
    // ignore: unnecessary_type_check
    return ((first ~/ second) is int) ? (first ~/ second) as T : (first / second) as T;
  }
}
''';
}

class Wwww3qDatz_iterable_extension_Sample extends Sample {
  Wwww3qDatz_iterable_extension_Sample() : super('lib/app/core/utils/extension/iterable_extension.dart', overwrite: true);

  @override
  String get content =>
      '''
//Searching List<List<T>> in Dart
extension FlattenFind<T extends Comparable> on Iterable<Iterable<T>> {
  bool containsElement(T value) {
    for (final arr in this) {
      if (arr.contains(value)) return true;
    }
    return false;
  }
}
''';
}

class Wwww3qDatz_datetime_extension_Sample extends Sample {
  Wwww3qDatz_datetime_extension_Sample() : super('lib/app/core/utils/extension/datetime_extension.dart', overwrite: true);

  @override
  String get content =>
      '''
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toDateFormat() => DateFormat('yyyy-MM-dd').format(this);

  String timeAgoSinceDate({bool numericDates = true}) {
    final date2 = DateTime.now();
    final difference = date2.difference(this);

    if (difference.inDays > 8) {
      return toDateFormat();
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '\${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '\${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '\${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '\${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }
}
''';
}

class Wwww3qDatz_app_extension_Sample extends Sample {
  Wwww3qDatz_app_extension_Sample() : super('lib/app/core/utils/extension/app_extension.dart', overwrite: true);

  @override
  String get content =>
      '''
export 'datetime_extension.dart';
export 'iterable_extension.dart';
export 'list_extension.dart';
export 'map_extension.dart';
export 'num_extension.dart';
export 'string_extension.dart';
export 'text_editing_controller_extension.dart';
''';
}
