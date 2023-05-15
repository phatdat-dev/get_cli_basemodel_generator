// ignore_for_file: camel_case_types

import '../../interface/sample_interface.dart';

class Wwww3qDatz_utils_Sample extends Sample {
  Wwww3qDatz_utils_Sample() : super('lib/app/core/utils/utils.dart', overwrite: true);

  @override
  String get content =>
      '''
export '../../../generated/locales.g.dart';
export 'extension/app_extension.dart';
export 'helper.dart';
export 'helper_reflect.dart';
export 'helper_widget.dart';
export 'limit_range_text_input.dart';
export 'print.dart';
''';
}

class Wwww3qDatz_print_Sample extends Sample {
  Wwww3qDatz_print_Sample() : super('lib/app/core/utils/print.dart', overwrite: true);

  @override
  String get content =>
      '''
// ignore_for_file: avoid_print
//https://stackoverflow.com/questions/54018071/how-to-call-print-with-colorful-text-to-android-studio-console-in-flutter
import 'dart:developer';

class Printt {
  static void defaultt(Object? object) => log('\$object');
  static void black(Object? object) => log('\x1B[30m\$object\x1B[0m');
  static void red(Object? object) => log('\x1B[31m\$object\x1B[0m');
  static void green(Object? object) => log('\x1B[32m\$object\x1B[0m');
  static void yellow(Object? object) => log('\x1B[33m\$object\x1B[0m');
  static void blue(Object? object) => log('\x1B[34m\$object\x1B[0m');
  static void magenta(Object? object) => log('\x1B[35m\$object\x1B[0m');
  static void cyan(Object? object) => log('\x1B[36m\$object\x1B[0m');
  static void white(Object? object) => log('\x1B[37m\$object\x1B[0m');
  static void reset(Object? object) => log('\x1B[38m\$object\x1B[0m');
}
''';
}

class Wwww3qDatz_limit_range_text_input_Sample extends Sample {
  Wwww3qDatz_limit_range_text_input_Sample() : super('lib/app/core/utils/limit_range_text_input.dart', overwrite: true);

  @override
  String get content =>
      '''
import 'package:flutter/services.dart';
import 'package:flutter_getx_base_project/app/core/utils/extension/app_extension.dart';

class LimitRangeTextInput extends TextInputFormatter {
  LimitRangeTextInput({
    required this.minRange,
    required this.maxRange,
  }) : assert(minRange <= maxRange);

  final double minRange;
  final double maxRange;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    int count = 0;
    for (int i = 0; i < newValue.text.length; i++) {
      if (newValue.text[i] == '.') {
        count++;
      }
      if (count == 2) return oldValue;
    }

    //neu nhap dau' thap phan (.) giua~ chung` ma` phia' sau ko co' so' thi` tra? ve` dau' . con` nguyen vi tri' ko thay doi?
    final arrayS = newValue.text.split('.');

    if (arrayS.last.isEmpty) return newValue;
    //ep' kieu?, format so'

    var value = newValue.text.toDouble();
    if (value < minRange) return TextEditingValue(text: '\$minRange');

    // return value > maxRange ? oldValue : newValue;
    if (value > maxRange) {
      final format = maxRange.formatNumber();
      return oldValue.copyWith(text: format, selection: TextSelection.collapsed(offset: format.length));
    }
    String format;
    try {
      format = value.formatNumber();
    } catch (e) {
      format = '';
    }
    return newValue.copyWith(text: format, selection: TextSelection.collapsed(offset: format.length));
  }
}
''';
}

class Wwww3qDatz_helper_Sample extends Sample {
  Wwww3qDatz_helper_Sample() : super('lib/app/core/utils/helper.dart', overwrite: true);

  @override
  String get content =>
      '''
import 'dart:convert';
import 'dart:math';

// import 'package:collection/collection.dart'; //sort AZ
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class Helper {
  static String tryFormatDateTime(String dateString) {
    if (dateString.isEmpty) {
      return '';
    }
    var inputDate = DateTime.tryParse(dateString);
    if (inputDate == null) return dateString;
    String output = DateFormat('dd-MM-yyyy').format(inputDate);
    return output;
  }

  //limitShowList
  static void limitShowList(List list, [int limit = 5]) => (list.length > limit) ? list.removeRange(limit, list.length) : null;

  static Color get randomColor => Colors.primaries[Random().nextInt(Colors.primaries.length)];
  // static Color get randomColorAccents => Colors.accents[Random().nextInt(Colors.accents.length)];
  static num randomNumber({num min = 0, required num max}) {
    if (max is double || min is double) {
      return min.toDouble() + Random().nextDouble() * (max.toDouble() - min.toDouble());
    }
    return min.toInt() + Random().nextInt(max.toInt() - min.toInt());
  }

  //List.separated count,generator,separator
  //input: cout=> 7, generator=> 1 , separator=> 0
  //output: [1,0,1,0,1,0,1]
  static List<T> listGenerateSeparated<T>(int count, {required T Function(int index) generator, required T Function(int index) separator}) {
    final List<T> list = [];
    for (int i = 0; i < count; i++) {
      list.add(generator(i));
      if (i < count - 1) {
        list.add(separator(i));
      }
    }
    return list;
  }

  static Future<dynamic> readFileJson(String assets) async => jsonDecode(await rootBundle.loadString(assets));

  static bool containsToLowerCase(String? source, String? target) {
    if (source == null || target == null) return false;
    return source.toLowerCase().contains(target.toLowerCase());
  }

  static String generateIdFromDateTimeNow() => DateFormat('yyyyMMddHHmmssSSS').format(DateTime.now());

  static List<Map<String, dynamic>> convertToListMap(List<dynamic> list) =>
      List<Map<String, dynamic>>.from(list.map((e) => Map<String, dynamic>.from(e)));
}
''';
}

class Wwww3qDatz_helper_widget_Sample extends Sample {
  Wwww3qDatz_helper_widget_Sample() : super('lib/app/core/utils/helper_widget.dart', overwrite: true);

  @override
  String get content =>
      '''
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import '../../custom/other/more_dropdown_search_custom.dart';
import '../../custom/other/search_controller_custom.dart';
import 'helper_reflect.dart';

class HelperWidget {
  static void showToast(String message) {
    FToast fToast = FToast()..init(Get.context!);
    fToast.showToast(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.red.shade100,
        ),
        child: Text(
          message,
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
      ),
      gravity: ToastGravity.CENTER,
      toastDuration: const Duration(seconds: 10),
    );
  }

  //hight light occurrentces
  static List<TextSpan> highlightOccurrences(String text, String query) {
    final List<TextSpan> spans = [];
    final String lowercaseText = text.toLowerCase();
    final String lowercaseQuery = query.toLowerCase();

    int lastIndex = 0;
    int index = lowercaseText.indexOf(lowercaseQuery);

    while (index != -1) {
      spans.add(TextSpan(text: text.substring(lastIndex, index)));
      spans.add(TextSpan(text: text.substring(index, index + query.length), style: const TextStyle(fontWeight: FontWeight.bold)));
      lastIndex = index + query.length;
      index = lowercaseText.indexOf(lowercaseQuery, lastIndex);
    }

    spans.add(TextSpan(text: text.substring(lastIndex, text.length)));

    return spans;
  }

  static void showSnackBar({
    required String message,
    MaterialColor color = Colors.green,
    IconData iconData = Icons.task_alt,
    Duration duration = const Duration(seconds: 3),
    double? width,
  }) =>
      ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        content: Row(
          children: [
            Icon(iconData, color: color),
            const SizedBox(width: 10),
            Text(message, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          ],
        ),
        backgroundColor: color.shade100,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), //StadiumBorder()
        margin: const EdgeInsets.all(10),
        width: width,
        duration: duration,
        //show snackbar animation bottom to top
      ));

  static Widget buildImage(String image) {
    final context = Get.context!;
    return GestureDetector(
      onTap: () {
        showDialog(
            //barrierDismissible: false,
            context: context,
            builder: (context) => Stack(
                  children: [
                    InteractiveViewer(
                      maxScale: 10,
                      child: Center(
                        child: Hero(
                          tag: image,
                          child: Image.network(
                            image,
                            // fit: BoxFit.fill,
                            alignment: Alignment.center,
                            errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        child: BackButton(),
                      ),
                    ),
                  ],
                ));
      },
      child: Hero(
        tag: image,
        child: Image.network(
          image,
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width / 2,
          // alignment: Alignment.center,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, color: Colors.grey),
        ),
      ),
    );
  }

  static Widget buildFile(String file) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {},
          child: Image.asset(
            'assets/gif/attachment-file.gif',
            width: 100,
            height: 150,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          file.split('/').last,
          style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black, fontSize: 15),
        ),
      ],
    );
  }

  static Future<T?> showSearchDropDown<T extends SearchDelegateQueryName>({
    required Iterable<T> data,
    String? hintText = 'Search...',
  }) async {
    final ValueNotifier<List<T>> search = ValueNotifier(data.toList());
    final txtController = TextEditingController();
    return await showDialog<T>(
        // showGeneralDialog
        context: Get.context!,
        builder: (context) {
          final size = MediaQuery.of(context).size;
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            titlePadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            scrollable: true,
            title: Container(
              height: 40,
              margin: const EdgeInsets.all(10),
              child: TextField(
                controller: txtController,
                onChanged: (value) => HelperReflect.search(listOrigin: data, listSearch: search, nameModel: 'queryName', keywordSearch: value),
                decoration: InputDecoration(
                  hintText: hintText,
                  prefixIcon: const Icon(Icons.search_rounded),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            content: SizedBox(
              width: size.width,
              height: size.height / 2,
              child: ValueListenableBuilder(
                valueListenable: search,
                builder: (context, value, child) => ListView.builder(
                  shrinkWrap: true,
                  itemCount: value.length,
                  itemBuilder: (context, index) => ListTile(
                    title: txtController.text.isEmpty
                        ? Text(value[index].queryName)
                        : RichText(
                            text: TextSpan(
                                children: highlightOccurrences(value[index].queryName, txtController.text),
                                style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
                          ),
                    onTap: () => Navigator.of(context).pop(value[index]),
                  ),
                ),
              ),
            ),
          );
        });
  }

  /// [initData] mạc định sẽ gọi api
  /// [moreDropDownSearch] sẽ tạo ra nút dropdown cho chọn, khi click vào sẽ đổi theo api tương ứng
  static Future<MoreDropDownSearchCustom?> showSearchDropDownApiCall({
    required BuildContext context,
    required MoreDropDownSearchCustom initData,
    String hintText = 'Search...',
    Iterable<MoreDropDownSearchCustom>? moreDropDownSearch,
  }) async {
    final ValueNotifier<List> search = ValueNotifier([]);
    final txtController = TextEditingController();
    final Debouncer debouncer = Debouncer(delay: const Duration(seconds: 1));
    return await showDialog(
        // showGeneralDialog
        context: context,
        builder: (context) {
          final size = MediaQuery.of(context).size;
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            titlePadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            scrollable: true,
            title: Container(
              height: 40,
              margin: const EdgeInsets.all(10),
              child: StatefulBuilder(
                builder: (context, setState) => TextField(
                  controller: txtController,
                  onChanged: (value) => debouncer(() async => search.value = await initData.apiCall(value)),
                  decoration: InputDecoration(
                    hintText: hintText,
                    prefixIcon: const Icon(Icons.search_rounded),
                    suffixIcon: moreDropDownSearch != null
                        ? PopupMenuButton<String>(
                            icon: const Icon(Icons.more_vert_rounded),
                            onSelected: (key) {
                              initData = moreDropDownSearch.firstWhere((element) => element.key == key);
                              setState(() => hintText = key);
                            },
                            itemBuilder: (BuildContext context) {
                              return moreDropDownSearch.map((e) => PopupMenuItem<String>(value: e.key, child: Text(e.key))).toList();
                            })
                        : null,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            content: SizedBox(
              width: size.width,
              height: size.height / 2,
              child: ValueListenableBuilder(
                valueListenable: search,
                builder: (context, value, child) => ListView.builder(
                  shrinkWrap: true,
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    final item = value[index];

                    return ListTile(
                      title: txtController.text.isEmpty
                          ? Text(
                              item[initData.queryName] ?? '',
                              maxLines: 2,
                            )
                          : RichText(
                              text: TextSpan(
                                  children: highlightOccurrences(item[initData.queryName] ?? '', txtController.text),
                                  style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
                              maxLines: 2,
                            ),
                      onTap: () => Navigator.of(context).pop(initData..dataResponse = item),
                    );
                  },
                ),
              ),
            ),
          );
        });
  }
}
''';
}

class Wwww3qDatz_helper_reflect_Sample extends Sample {
  Wwww3qDatz_helper_reflect_Sample() : super('lib/app/core/utils/helper_reflect.dart', overwrite: true);

  @override
  String get content =>
      '''
// ignore_for_file: depend_on_referenced_packages

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../custom/other/search_controller_custom.dart';
import '../base/base_project.dart'; //sort AZ

class HelperReflect {
  //muon su dung ham` nay` thi` phai co' reflectable moi xai dc
  static void search<T>(
      {required Iterable<T> listOrigin, required ValueNotifier<List<T>> listSearch, required String nameModel, required String keywordSearch}) {
    keywordSearch = keywordSearch.toLowerCase().trim();
    var newList = listOrigin.where((element) {
      String? insMirror;
      if ((element is SearchDelegateQueryName) && nameModel == 'queryName') {
        insMirror = element.queryName;
      } else {
        final splitt = nameModel.split('??');
        for (var s in splitt) {
          if (element is BaseModel) {
            insMirror = (element).toJson()[s.trim()] as String?;
          } else {
            insMirror = (element as dynamic).toJson()[s.trim()] as String?;
          }
          if (insMirror?.isNotEmpty ?? false) break;
        }
      }
      return insMirror?.toLowerCase().contains(keywordSearch) ?? false;
    }).toList();
    listSearch.value = newList;
  }

  static void sortAZ<T>({required ValueNotifier<bool> isSort, required String nameModelSortAZ, required ValueNotifier<List<T>> listSearch}) {
    (isSort.value)
        ? listSearch.value.sort((a, b) {
            final insMirrorA = (a as BaseModel).toJson()[nameModelSortAZ] as String;
            final insMirrorB = (b as BaseModel).toJson()[nameModelSortAZ] as String;
            return compareNatural(insMirrorA, insMirrorB);
          })
        : listSearch.value.sort((a, b) {
            final insMirrorA = (a as BaseModel).toJson()[nameModelSortAZ] as String;
            final insMirrorB = (b as BaseModel).toJson()[nameModelSortAZ] as String;
            return compareNatural(insMirrorB, insMirrorA);
          });
    isSort.value = !isSort.value;

    // listSearch.refresh();
  }
}
''';
}
