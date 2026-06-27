import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:west_irbid_mobile/models/departments.dart';
import 'package:west_irbid_mobile/models/diwan_classes.dart';
import 'package:west_irbid_mobile/models/floor_model.dart';
import 'package:west_irbid_mobile/models/lookup_model.dart';
import 'package:west_irbid_mobile/models/news_source.dart';
import 'package:west_irbid_mobile/models/roles_model.dart';
import 'package:west_irbid_mobile/models/settings_model.dart';
import 'package:west_irbid_mobile/models/user_model.dart';
import 'package:west_irbid_mobile/models/user_role_model.dart';

import '../models/student_model.dart';

class ConstantsData {
  static Color primaryClr = Color(0xff5B4E9B);
  // Color.fromARGB(255, 147, 46, 255);
  static Color secondaryClr = const Color(0xff813B8F);
  static Color buttonClr = const Color(0xffF59B2B);
  static Color activeClr = Colors.green;
  static Color inActiveClr = Colors.grey;
  static Color absentClr = Colors.red;
  // static int selectedLabId = -1;
  // static Lab? selectedLab;
  // static StudentsWithStatus? studentData;
  // static List<Lectures> allLectures = [];
  static UserModel? currentUser;
  static List<UserModel>? departmentsUser;
  static List<UserModel> listUsers = [];

  static List<RoleModel> rolesList = [];
  static List<UserRoleModel> userGrantedRoles = [];
  static WindowsDeviceInfo? deviceInfo;
  static List<Department> departments = [];
  static List<DiwanClass> diwanCLassesList = [];
  static List<SettingModel> settingsList = [];
  static List<LoockupModel> tandeemTypeList = [];
  static List<LoockupModel> tandeemProceduresTypeList = [];
  static List<String> sakan = [
    'أ',
    'ب',
    'ج',
    'د',
    'هـ',
    'أخضر',
    'زراعي',
    'سكن زراعي',
    'تجازي',
    'غيرذلك',
  ];
  static List<String> tijari = [
    'مركزي',
    'طولي',
    'محلي',
    'معارض تجارية',
    'غير تجاري',
  ];
  static List<String> build_type = [
    'قائم',
    'مقترح',
    'قائم زائد عن الترخيص',
    'غيرذلك',
  ];
  static List<String> wp_type = ['خدمات', 'إفراز', 'غيرذلك'];
  static List<String> floor = [
    'تسوية ثالث',
    'تسوية ثاني',
    'تسوية أول',
    'أرضي',
    'أول',
    'ثاني',
    'ثالث',
    'رابع',
    'تجاوزات',
    'سور',
    'مكرر درج',
    'رووف',
    'تغيير إسم مالك الترخيص',
  ];
  static List<String> city = [
    'كفريوبا',
    'سوم',
    'زحر',
    'ناطفه',
    'جمحا',
    'ججين',
    'دوقره',
    'بيت يافا',
    'كفررحتا',
    'هام',
    'مناطق غرب اربد',
    'ناطفة وهام ',
    'المركز',
    'المصنع',
    'مواطنين',
  ];

  static List<String> complaintsClassificationsType = [
    'الخدمات الهندسية',
    'الشؤون الصحية والبيئة',
    'التنظيم',
    'إداريه',
    'ابداءرأي',
    'تنمويه',
    'علاقات عامة',
    'استملاكات',
    'أبنيه',
    'اخرى',
  ];

  static List<String> complaintsProceduresNote = [
    'تم الحفظ ',
    'تم الاجراء ',
    'المتابعة',
    'تم تصويب الوضع',
    'لم يصوب الوضع',
    'كتابة تعهد ',
    'مخاطبة المحافظ',
    'اخرى',
  ];

  static Map<int, String> complaintsStatus = {
    0: 'جديد',
    1: 'تحت الإجراء',
    2: 'تم الاجراء ',
    3: 'تم الحفظ ',
    4: 'اخرى',
  };

  static List<String> diwan_type = [
    'وارد مناطق',
    'وارد عام',
    'صادر مناطق',
    'صادر عام',
    'تنظيم',
  ];

  static List<String> est_type = ['فضلات', 'إستملاكات'];
  static List<String> diwan_to = ['عام', 'مناطق'];

  // static List<String> relation_news_jaredah = [
  //   'الغد',
  //   'الدرستور',
  //   'الرأي',
  //   'الجردية الرسمية',
  //   'غيرذلك'
  // ];
  static List<NewsSource> relation_news_jaredah = [];

  static var decimalInputFormatter = <TextInputFormatter>[
    FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
  ];
  static var numberInputFormatter = <TextInputFormatter>[
    FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
  ];
  static var shadowVal = [
    BoxShadow(
      color: Colors.black12.withOpacity(0.3),
      spreadRadius: 5,
      blurRadius: 3,
      blurStyle: BlurStyle.outer,
    ),
  ];
  static double radiusVal = 10;
  static var headerShadowVal = [
    BoxShadow(
      color: Colors.black12.withOpacity(0.1),
      spreadRadius: 2,
      blurStyle: BlurStyle.outer,
      offset: const Offset(1, 2),
    ),
  ];
  static BoxDecoration todyLecturesDecoration = BoxDecoration(
    color: Colors.blueGrey.withOpacity(0.4),
    borderRadius: BorderRadius.circular(8),
  );
}
