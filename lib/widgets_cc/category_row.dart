import 'package:flutter/material.dart';

class CategoryRow extends StatelessWidget {
  final Widget? fCategory;
  final Widget? sCategory;

  const CategoryRow({Key? key, this.fCategory, this.sCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        fCategory!,
        const SizedBox(
          width: 5,
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: sCategory ??
              SizedBox(
                width: width / 2.4,
                height: width / 2.4,
              ),
        ),
      ],
    );
  }
}
