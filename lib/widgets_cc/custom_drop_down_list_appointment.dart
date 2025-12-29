import 'package:flutter/material.dart';
import 'package:west_irbid_mobile/services_utils/translation_service.dart';
import 'package:west_irbid_mobile/services_utils/ui_helpers.dart';

class CustomDropDownListAppointmetns extends StatefulWidget {
  final List? list;
  final String? hint;
  final Function? onChange;
  final bool setDefault;
  TextEditingController? controller;
  final Function? validator;

  CustomDropDownListAppointmetns({
    Key? key,
    this.list,
    this.hint,
    this.onChange,
    this.setDefault = true,
    this.validator,
    this.controller,
  }) : super(key: key);

  @override
  State<CustomDropDownListAppointmetns> createState() =>
      _CustomDropDownListAppointmetnsState();
}

class _CustomDropDownListAppointmetnsState
    extends State<CustomDropDownListAppointmetns> {
  setDefaultValue() {
    if (widget.setDefault && widget.list != null && widget.list!.isNotEmpty) {
      if (widget.controller!.text.isEmpty) {
        setState(() {
          widget.controller!.text = widget.list![0].toString();
        });
        return true;
      }
    }
    return false;
  }

  String selectedValue = '';

  @override
  void initState() {
    super.initState();
    setDefaultValue();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
      child: TextFormField(
        onTap: () {
          if (!setDefaultValue()) widget.controller!.text = '';
          if (widget.list != null && widget.list!.isNotEmpty)
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                contentPadding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                content: Container(
                  child: RawScrollbar(
                    mainAxisMargin: 10,
                    thumbColor: Colors.grey,
                    radius: Radius.circular(20),
                    thickness: 5,
                    child: SingleChildScrollView(
                      child: Directionality(
                        textDirection:
                            TranslationService().isLocaleArabic() == true
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            for (var item in widget.list!)
                              ListTile(
                                onTap: () {
                                  widget.controller!.text = item.toString();
                                  selectedValue = item.toString();
                                  pop(context);
                                  widget.onChange!(item);
                                },
                                title: Text(item.toString()),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
        },
        controller: widget.controller,
        readOnly: true,
        validator: widget.validator as String? Function(String?)?,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
          ),
          filled: true,
          labelText: widget.hint,
          hintStyle: TextStyle(color: Colors.grey[800]),
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
