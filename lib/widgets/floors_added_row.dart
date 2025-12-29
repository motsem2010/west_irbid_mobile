import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:west_irbid_mobile/models/floor_model.dart';
import 'package:west_irbid_mobile/services_utils/constants.dart';
import 'package:west_irbid_mobile/widgets_cc/custom_text_field.dart';

class FloorRow extends StatelessWidget {
  FloorRow({
    super.key,
    required this.floor,
    required this.onPressDelete,
    this.isWP = false,
  });
  FloorModel floor;
  Function()? onPressDelete;
  bool isWP;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey.shade50,
      elevation: 3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Flexible(
          //   child: CustomDropDownList(
          //     title: 'buildDetailsFloor'.tr,
          //     list: ConstantsData.floor,
          //     // hint: 'Enter'.tr + ' ' + 'buildDetailsSakan'.tr,
          //     prefixIcon: Icons.home,
          //     disableSearch: false,
          //     onChange: (String? val) {
          //       controller.newFloosFloorName = val;
          //       Get.log('Floor=${val}');
          //     },
          //   ),
          // ),
          CircleAvatar(
            backgroundColor: ConstantsData.absentClr,
            child: Text(floor.id.toString()),
          ),
          Flexible(
            child: CustomTextField2(
              title: 'buildDetailsFloor'.tr,
              boldHint: true,
              enable: false,
              controller: TextEditingController(text: floor.floor ?? ""),
            ),
          ),

          Flexible(
            child: CustomTextField2(
              title: 'buildDetailsBuildType'.tr,
              enable: false,
              controller: TextEditingController(text: floor.licenceType ?? ""),
            ),
          ),

          Flexible(
            child: CustomTextField2(
              title: 'buildDetailsArea'.tr,
              enable: false,
              controller: TextEditingController(text: floor.area.toString()),
            ),
          ),
          if (isWP) ...[
            Flexible(
              child: CustomTextField2(
                title: 'licenceNunmber'.tr,
                enable: false,
                controller: TextEditingController(
                  text: floor.licenceNumber.toString(),
                ),
              ),
            ),
            Flexible(
              child: CustomTextField2(
                title: 'licenceDate'.tr,
                enable: false,
                controller: TextEditingController(
                  text: floor.licenceDate.toString(),
                ),
              ),
            ),
            Flexible(
              child: CustomTextField2(
                title: 'numberOfAppartment'.tr,
                enable: false,
                controller: TextEditingController(
                  text: floor.numOfAssets.toString(),
                ),
              ),
            ),
          ],

          if (!isWP) ...[
            // Flexible(
            //   child: CustomTextField2(
            //     title: 'FeesReciptNumber'.tr,
            //     enable: false,
            //     controller:
            //         TextEditingController(text: floor.reciptNumber.toString()),
            //   ),
            // ),
            Flexible(
              child: CustomTextField2(
                title: 'FeesReciptNumber'.tr,
                enable: false,
                controller: TextEditingController(
                  text: floor.reciptNumber.toString(),
                ),
              ),
            ),
            Flexible(
              child: CustomTextField2(
                title: 'FeesReciptDate'.tr,
                enable: false,
                controller: TextEditingController(
                  text: floor.reciptDate.toString(),
                ),
              ),
            ),
            Flexible(
              child: CustomTextField2(
                title: 'Fees'.tr,
                enable: false,
                controller: TextEditingController(text: floor.fees.toString()),
              ),
            ),
          ],

          Expanded(
            child: CustomTextField2(
              title: 'Notes'.tr,
              maxline: 5,
              enable: false,
              controller: TextEditingController(text: floor.notes.toString()),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
              IconButton(onPressed: onPressDelete, icon: Icon(Icons.delete)),
            ],
          ),
          //  Expanded(
          // flex: 1,
          // child: MainButton(text: ''.tr,onPressed: (){},)),
        ],
      ),
    );
  }
}
