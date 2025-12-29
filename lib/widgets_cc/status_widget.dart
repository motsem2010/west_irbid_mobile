import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/export.dart';

class StatusWidget extends StatelessWidget {
  final int? status;
  const StatusWidget({Key? key, this.status}) : super(key: key);

  Color _colorAccent(int status) {
    switch (status) {
      case 1:
        return Colors.greenAccent.shade100.withOpacity(0.5);
      case 0:
        return Colors.amber.shade200.withOpacity(0.5);
      case 2:
        return Colors.redAccent.shade100.withOpacity(0.5);
    }
    return Colors.yellowAccent.shade100.withOpacity(0.5);
  }

  Color _color(int status) {
    switch (status) {
      case 1:
        return Colors.green.shade500;
      case 0:
        return Colors.amber.shade700;
      case 2:
        return Colors.red.shade500;
    }
    return Colors.yellow;
  }

  IconData _iconStatus() {
    switch (status) {
      case 1:
        return Icons.priority_high_sharp;
      case 0:
        return Icons.low_priority;
      case 2:
        return Icons.priority_high;
    }
    return Icons.access_time;
  }

  String _status(num) {
    switch (num) {
      case 1:
        return 'normal'.tr;
      case 0:
        return 'low'.tr;
      case 2:
        return 'high'.tr;
    }
    return 'other'.tr;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 7),
            decoration: BoxDecoration(
                color: _colorAccent(status!),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              children: [
                Icon(
                  _iconStatus(),
                  color: _color(status!),
                  size: 14,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  _status(status),
                  style: TextStyle(color: _color(status!), fontSize: 12),
                ),
              ],
            )),
      ],
    );
  }
}
