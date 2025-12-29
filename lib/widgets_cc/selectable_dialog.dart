import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:west_irbid_mobile/services_utils/translation_service.dart';
import 'package:west_irbid_mobile/widgets_cc/custom_text_field.dart';

class SelectableDialog extends StatefulWidget {
  final List<dynamic> list;
  final String header;
  final bool? multiSelect;
  final bool? flexibleHeight;
  final bool? disableSearch;
  final bool? disableSubmit;
  SelectableDialog({
    Key? key,
    required this.list,
    required this.header,
    this.flexibleHeight = false,
    this.disableSearch = false,
    this.disableSubmit = false,
    this.multiSelect = false,
  }) : super(key: key);

  @override
  State<SelectableDialog> createState() => _SelectableDialogState();
}

class _SelectableDialogState extends State<SelectableDialog> {
  var selectedItem;
  List<dynamic>? selectedItems = [];
  List<dynamic> _list = [];
  @override
  void initState() {
    _list.addAll(widget.list);
    super.initState();
  }

  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: Column(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Center(
              child: Text(
                widget.header,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
          if (!widget.disableSearch!)
            CustomTextField2(
              hintText: 'Search'.tr,
              icon: CupertinoIcons.search,
              controller: _searchController,
              onChange: (word) {
                _search(word);
              },
            ),
        ],
      ),
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      content: FractionallySizedBox(
        heightFactor: !widget.flexibleHeight! ? 0.8 : null,
        child: RawScrollbar(
          mainAxisMargin: 10,
          thumbColor: Colors.grey,
          radius: Radius.circular(20),
          thickness: 5,
          child: SingleChildScrollView(
            child: Directionality(
              textDirection: TranslationService().isLocaleArabic() == true
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: StatefulBuilder(
                builder: (context2, setState) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (var item in _list)
                          if (widget.disableSubmit! && !widget.multiSelect!)
                            Column(
                              children: [
                                Divider(height: 1),
                                ListTile(
                                  onTap: () => Navigator.pop(context, item),
                                  title: Text(
                                    item.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            )
                          else
                            ListTile(
                              title: Text(item.toString()),
                              onTap: () {
                                setState(() {
                                  if (!widget.multiSelect!) {
                                    selectedItem = item;
                                  } else {
                                    if (!selectedItems!.any(
                                      (element) => element == item,
                                    ))
                                      selectedItems?.add(item);
                                    else
                                      selectedItems?.remove(item);
                                  }
                                });
                              },
                              trailing: !widget.multiSelect!
                                  ? selectedItem == item
                                        ? Icon(
                                            Icons.check_circle_rounded,
                                            size: 30,
                                            color: Colors.green,
                                          )
                                        : null
                                  : Icon(
                                      Icons.check_circle_rounded,
                                      size: 30,
                                      color:
                                          selectedItems!.any((e) => e == item)
                                          ? Colors.green
                                          : Colors.grey,
                                    ),
                            ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
      actions: [
        if (!widget.disableSubmit!)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(
                      context,
                      !widget.multiSelect! ? selectedItem : selectedItems,
                    ),
                    child: Text('Submit'.tr),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  _search(String word) {
    if (word.isEmpty) {
      setState(() {
        _list
          ..clear()
          ..addAll(widget.list);
      });
      return;
    }
    if (word.length > 1) {
      setState(() {
        _list = widget.list
            .where(
              (e) => e.toString().toLowerCase().contains(word.toLowerCase()),
            )
            .toList();
      });
    }
  }
}
