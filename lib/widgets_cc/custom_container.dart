import 'package:flutter/material.dart';

class CustomRoundedContainer extends StatelessWidget {
  final Widget? child;
  final String? title;
  const CustomRoundedContainer({Key? key, this.child, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double val = 10;
    return Container(
        margin: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(val), topLeft: Radius.circular(val)),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Container(
                child: child,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(val),
                        topLeft: Radius.circular(val))))));
  }
}
