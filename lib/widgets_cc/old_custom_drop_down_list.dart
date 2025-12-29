import 'package:flutter/material.dart';
import 'package:west_irbid_mobile/services_utils/translation_service.dart';
import 'package:west_irbid_mobile/services_utils/ui_helpers.dart';

class OldCustomDropDownList extends StatefulWidget {
  final List? list;
  final String? hint;
  final Function? onChange;
  final bool setDefault;
  final bool enable;
  final Function? validator;
  final EdgeInsets edgeInsets;

  OldCustomDropDownList({
    Key? key,
    this.list,
    this.hint,
    this.onChange,
    this.setDefault = true,
    this.validator,
    this.edgeInsets = const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
    this.enable = true,
  }) : super(key: key);

  @override
  State<OldCustomDropDownList> createState() => _CustomDropDownListState();
}

class _CustomDropDownListState extends State<OldCustomDropDownList> {
  final TextEditingController _controller = TextEditingController();

  setDefaultValue() {
    if (widget.setDefault && widget.list != null && widget.list!.isNotEmpty) {
      setState(() {
        _controller.text = widget.list![0].toString();
      });
      return true;
    }
  }

  @override
  void initState() {
    super.initState();
    setDefaultValue();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.edgeInsets,
      child: TextFormField(
        onTap: !widget.enable
            ? null
            : () {
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
                                        _controller.text = item.toString();
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
        controller: _controller,
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
