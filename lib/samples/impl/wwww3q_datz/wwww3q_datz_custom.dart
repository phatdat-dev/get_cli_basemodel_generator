// ignore_for_file: camel_case_types

import '../../interface/sample_interface.dart';

class Wwww3qDatz_more_dropdown_search_custom_Sample extends Sample {
  Wwww3qDatz_more_dropdown_search_custom_Sample() : super('lib/app/custom/other/more_dropdown_search_custom.dart', overwrite: true);

  @override
  String get content =>
      '''
typedef MoreDropDownSearchAsyncCallBack = Future<List> Function(dynamic);

class MoreDropDownSearchCustom {
  final String key;
  final String queryName;
  final MoreDropDownSearchAsyncCallBack apiCall;
  dynamic dataResponse;
  MoreDropDownSearchCustom({
    required this.key,
    required this.queryName,
    required this.apiCall,
    this.dataResponse,
  });
}
''';
}

class Wwww3qDatz_search_controller_custom_Sample extends Sample {
  Wwww3qDatz_search_controller_custom_Sample() : super('lib/app/custom/other/search_controller_custom.dart', overwrite: true);

  @override
  String get content =>
      '''
import 'package:flutter/material.dart';

// https://api.flutter.dev/flutter/material/SearchAnchor-class.html
class SearchControllerCustom<T extends SearchDelegateQueryName> extends SearchController {
  SearchControllerCustom({required this.searchSuggestions});
  final List<T> searchSuggestions;
  List<T> searchHistory = <T>[];
  T? selectedItem;

  void handleSelection(T item) {
    closeView(item.queryName);
    //
    selectedItem = item;
    if (searchHistory.length >= 5) {
      searchHistory.removeLast();
    }
    searchHistory.insert(0, item);
  }

  Iterable<Widget> getHistoryList() {
    return searchHistory.map((item) => ListTile(
          leading: const Icon(Icons.history),
          title: Text(item.queryName),
          trailing: _buildTrailingIconButton(item),
          onTap: () => handleSelection(item),
        ));
  }

  Iterable<Widget> getSuggestions() {
    final String input = value.text;
    return searchSuggestions.where((element) => element.queryName.contains(input)).map((item) => ListTile(
          title: Text(item.queryName),
          trailing: _buildTrailingIconButton(item),
          onTap: () => handleSelection(item),
        ));
  }

  Widget _buildTrailingIconButton(T item) => IconButton(
      icon: const Icon(Icons.call_missed),
      onPressed: () {
        text = item.queryName;
        selection = TextSelection.collapsed(offset: text.length);
      });
}

abstract class SearchDelegateQueryName {
  String get queryName;
  set queryName(String value) => queryName = value;
  Object? objectt;
}

class TesttSearchDelegateModel extends SearchDelegateQueryName {
  final String? id;
  final String? no;
  final String? name;

  TesttSearchDelegateModel({this.id, this.no, this.name});

  @override
  String get queryName => name ?? '';
}

/*
searchController = CSearchController<TesttSearchDelegateModel>(searchSuggestions: [
      ...List.generate(10, (index) => TesttSearchDelegateModel(id: '\$index', no: 'no \$index', name: 'name \$index')),
    ]);
    
SearchAnchor(
            searchController: searchController,
            viewHintText: 'Search friends',
            headerHintStyle: Theme.of(context).textTheme.bodySmall,
            builder: (context, searchController) => AppBarIcon(
                  icon: const Icon(MdiIcons.magnify),
                  onPressed: () => searchController.openView(),
                ),
            suggestionsBuilder: (context, searchController) {
              searchController = (searchController as CSearchController);
              if (searchController.text.isEmpty) {
                if (searchController.searchHistory.isNotEmpty) {
                  return searchController.getHistoryList();
                }
                return <Widget>[
                  const Center(
                    child: Text('No search history.', style: TextStyle(color: Colors.grey)),
                  )
                ];
              }
              return searchController.getSuggestions();
            }),
*/
''';
}

class Wwww3qDatz_loadding_widget_Sample extends Sample {
  Wwww3qDatz_loadding_widget_Sample() : super('lib/app/custom/widget/loadding_widget.dart', overwrite: true);

  @override
  String get content =>
      '''
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loadding {
  static GlobalKey<_LoaddingWidgetState> key = GlobalKey<_LoaddingWidgetState>();

  static List<bool> stacKLoadding = [];

  static void show() async {
    stacKLoadding.add(true);
    if (key.currentContext == null && stacKLoadding.length == 1) {
      showDialog(
        context: Get.context!,
        barrierDismissible: true,
        builder: (context) => LoaddingWidget(key: key),
      );
    }
  }

  static void dismiss() {
    if (stacKLoadding.isNotEmpty) stacKLoadding.removeLast();
    if (stacKLoadding.isEmpty && key.currentContext != null) {
      Navigator.of(key.currentContext!, rootNavigator: true).pop();
      key = GlobalKey<_LoaddingWidgetState>();
    }
  }
}

class LoaddingWidget extends StatefulWidget {
  const LoaddingWidget({super.key});

  @override
  State<LoaddingWidget> createState() => _LoaddingWidgetState();
}

class _LoaddingWidgetState extends State<LoaddingWidget> {
  // late final AssetImage imageLoadding;

  @override
  void initState() {
    // imageLoadding = AssetImage("assets/images/loading/loading-loop.gif");
    super.initState();
  }

  @override
  void dispose() {
    // imageLoadding.evict();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Dialog(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.transparent,
        child: Center(
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: const CircularProgressIndicator()
              // Image(
              //   image: imageLoadding,
              //   width: 200,
              //   height: 200,
              // ),
              ),
        ),
      ),
    );
  }
}
''';
}
