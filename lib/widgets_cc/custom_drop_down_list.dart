import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:west_irbid_mobile/widgets_cc/selectable_dialog.dart';

class CustomDropDownList extends StatefulWidget {
  final List? list;
  final String? hint;
  final Function? onChange;
  String? title;
  final bool setDefault;
  final Future<List?> Function()? onTap;
  final bool? flexibleHeight;
  final bool? disableSearch;
  final bool? disableSubmit;
  final IconData? prefixIcon;
  final Widget? suffexWidget;

  final Function? validator;
  final EdgeInsets edgeInsets;
  final TextEditingController? textController;
  final bool multiSelect;

  CustomDropDownList({
    Key? key,
    this.list,
    this.hint,
    this.prefixIcon,
    this.suffexWidget,
    this.onChange,
    this.title,
    this.flexibleHeight = true,
    this.disableSearch = true,
    this.disableSubmit = true,
    this.setDefault = false,
    this.validator,
    this.textController,
    this.edgeInsets = const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
    this.onTap,
    this.multiSelect = false,
  }) : super(key: key);

  @override
  State<CustomDropDownList> createState() => _CustomDropDownListState();
}

class _CustomDropDownListState extends State<CustomDropDownList> {
  late TextEditingController _controller;
  //  = TextEditingController();

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
    _controller = widget.textController ?? TextEditingController();
    setDefaultValue();
  }

  Future getSelected(List returnedList) async {
    var selected = await showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: 'MTS',
      transitionDuration: const Duration(milliseconds: 300),
      context: context,
      transitionBuilder: (context, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: SelectableDialog(
            disableSearch:
                widget.disableSearch! && (widget.list?.length ?? 0) < 10,
            disableSubmit:
                widget.disableSubmit! && (widget.list?.length ?? 0) < 20,
            flexibleHeight:
                widget.flexibleHeight! && (widget.list?.length ?? 0) < 20,
            header: widget.hint ?? '',
            list: returnedList,
            multiSelect: widget.multiSelect,
          ),
        );
      },
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
    );

    return selected;
  }

  var selectedItem;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              widget.title ?? '',
              style: Get.textTheme.headlineMedium,
            ),
          ),
          const SizedBox(height: 10.0),
        ],
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 0,
          ), //widget.edgeInsets,
          child: TextFormField(
            onTap: press_or_submited,
            onFieldSubmitted: (value) => press_or_submited(),
            controller: _controller,
            readOnly: true,
            validator: widget.validator as String? Function(String?)?,
            decoration: InputDecoration(
              isDense: true,
              prefixIcon: widget.prefixIcon != null
                  ? Icon(widget.prefixIcon)
                  : null,
              suffix: widget.suffexWidget,
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
              filled: true,
              labelText: widget.hint,
              hintStyle: TextStyle(color: Colors.grey[800]),
              fillColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  void press_or_submited() async {
    List? returnedList = [];
    if (widget.onTap != null)
      returnedList = await widget.onTap!();
    else if (widget.list != null && widget.list!.isNotEmpty)
      returnedList = widget.list;
    else
      return;
    if ((returnedList ?? []).isEmpty) return;

    var selected = await getSelected(returnedList ?? []);
    if (selected == null) _controller.text = '';
    if (selected != null)
      selectedItem = selected;
    else if (widget.setDefault)
      selectedItem = widget.list?.first;
    if (selectedItem != null) _controller.text = selectedItem.toString();
    if (widget.onChange != null && selected != null)
      widget.onChange!(selectedItem);
  }
}
