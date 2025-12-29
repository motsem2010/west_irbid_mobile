import 'package:flutter/material.dart';
import 'package:west_irbid_mobile/services_utils/translation_service.dart';

class CustomExpansionWidget extends StatefulWidget {
  final List<Map<Widget, Widget>> expansionContent;
  const CustomExpansionWidget({Key? key, required this.expansionContent})
    : super(key: key);

  @override
  State<CustomExpansionWidget> createState() => _CustomExpansionWidgetState();
}

class _CustomExpansionWidgetState extends State<CustomExpansionWidget> {
  int openedIndex = 0;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      elevation: 1,
      expandedHeaderPadding: EdgeInsets.zero,
      expansionCallback: (panelIndex, isExpanded) {
        setState(() {
          this.isExpanded = !isExpanded;
          if (!isExpanded)
            openedIndex = panelIndex;
          else
            openedIndex = 0;
        });
      },
      children: [
        for (var index = 0; index < widget.expansionContent.length; index++)
          ExpansionPanel(
            canTapOnHeader: true,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return Align(
                alignment: TranslationService().isLocaleArabic() == false
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: widget.expansionContent[index].keys.first,
                  //  color: Colors.red,
                ),
              );
            },
            isExpanded: openedIndex == index && isExpanded,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: widget.expansionContent[index].values.first,
            ),
          ),
      ],
    );
  }
}
