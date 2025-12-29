import 'package:flutter/material.dart';
import 'package:west_irbid_mobile/services_utils/size_utils.dart';
import 'package:west_irbid_mobile/widgets_cc/selectable_dialog.dart';

class CustomDropDownWithContHeaderList extends StatefulWidget {
  final List? list;
  final String? hint;
  final dynamic defaultValue;
  final Function? onChange;
  final bool setDefault;
  final Future<List?> Function()? onTap;
  final bool? flexibleHeight;
  final bool? disableSearch;
  final bool? disableSubmit;
  final bool autoUpdateState;
  final IconData? prefixIcon;
  final IconData suffixIcon;
  final Function? validator;
  final EdgeInsets edgeInsets;
  final bool withHeaderText;
  final TextEditingController? textController;
  final int? maxLine;
  final multiSelect;
  CustomDropDownWithContHeaderList({
    Key? key,
    this.list,
    this.hint,
    this.prefixIcon,
    this.onChange,
    this.flexibleHeight = true,
    this.disableSearch = true,
    this.disableSubmit = true,
    this.setDefault = true,
    this.validator,
    this.suffixIcon = Icons.keyboard_arrow_down,
    this.edgeInsets = const EdgeInsets.only(left: 25, right: 25, bottom: 8),
    this.onTap,
    this.textController,
    this.defaultValue,
    this.autoUpdateState = false,
    this.withHeaderText = true,
    this.maxLine,
    this.multiSelect = false,
  }) : super(key: key);

  @override
  State<CustomDropDownWithContHeaderList> createState() =>
      _CustomDropDownListState();
}

class _CustomDropDownListState extends State<CustomDropDownWithContHeaderList>
    with AutomaticKeepAliveClientMixin<CustomDropDownWithContHeaderList> {
  bool keepAlive = true;

  late TextEditingController
  _controller; //=widget.textController!=null ?widget.textController!:TextEditingController();
  // Update this method to set the selected value in the controller.
  setDefaultValue() {
    if (widget.defaultValue != null) {
      setState(() {
        selectedItem = widget.defaultValue;
        _controller.text = selectedItem.toString();
      });
    } else if (widget.setDefault &&
        widget.list != null &&
        widget.list!.isNotEmpty) {
      if (_controller.text == '') {
        setState(() {
          selectedItem = widget.list![0];
          _controller.text = selectedItem.toString();
        });
      }
    }
  }

  // Rest of your code...
  @override
  void didUpdateWidget(covariant CustomDropDownWithContHeaderList oldWidget) {
    if (oldWidget.list != widget.list && widget.autoUpdateState)
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (widget.list != null && widget.list!.isNotEmpty) {
          _controller.text = widget.list!.first.toString();
        }
      });
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.textController != null
        ? widget.textController!
        : TextEditingController();
    setDefaultValue(); // Call this method in initState to set the initial value.
  }

  Future getSelected(List returnedList) async {
    var selected = await showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: 'Hello',
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
                widget.disableSubmit!, //&& (widget.list?.length ?? 0) < 50,
            flexibleHeight:
                widget.flexibleHeight! && (widget.list?.length ?? 0) < 10,
            header: widget.hint ?? '',
            multiSelect: widget.multiSelect,
            list: returnedList,
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
    super.build(context);
    return Padding(
      padding: widget.edgeInsets,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          (widget.withHeaderText == true
              ? Padding(
                  padding: EdgeInsets.only(bottom: 2.0.v, left: 3, right: 3),
                  child: Text(
                    widget.hint ?? '',
                    style: Theme.of(context).textTheme.bodyMedium,
                    // maxLines: widget.maxLine,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              : Container()),
          TextFormField(
            minLines: 1,
            maxLines: widget.maxLine == null ? 1 : widget.maxLine,
            onTap: () async {
              List? returnedList = [];
              if (widget.onTap != null)
                returnedList = await widget.onTap!();
              else if (widget.list != null && widget.list!.isNotEmpty)
                returnedList = widget.list;
              else
                return;
              if ((returnedList ?? []).isEmpty) return;

              var selected = await getSelected(returnedList ?? []);
              if (selected != null)
                selectedItem = selected;
              else if (widget.setDefault && selectedItem == null)
                selectedItem = widget.list?.first;
              if (selectedItem != null)
                _controller.text = selectedItem.toString();
              if (widget.onChange != null && selected != null)
                widget.onChange!(selectedItem);
            },
            controller: _controller,
            readOnly: true,
            style: widget.maxLine != null
                ? Theme.of(context).textTheme.bodySmall
                : Theme.of(context).textTheme.bodyMedium,
            validator: widget.validator as String? Function(String?)?,
            decoration: InputDecoration(
              prefixIcon: widget.prefixIcon != null
                  ? Icon(widget.prefixIcon)
                  : null,
              suffixIcon: widget.suffixIcon != null
                  ? Icon(widget.suffixIcon)
                  : null,
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
              ),
              filled: true,
              isDense: true,
              labelText: widget.withHeaderText ? null : widget.hint,
              hintStyle: TextStyle(color: Colors.grey[800]),
              fillColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => keepAlive;
}
