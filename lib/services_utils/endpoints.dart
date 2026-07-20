class Endpoints {
  static Map<String, String> headers = {'Content-Type': 'application/json'};

  // static String userToken = '';

  // static Map<String, String> get authorizedHeaders {
  //   return {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer ${userToken}',
  //   };
  // }

  static const String login = '/login';
  static const String register = '/register';

  static const String insert = '/insert';
  static const String insert_one = '/insert_one';
  static const String get_table = '/get_table';
  static const String update_table = '/update_table';
  static const String delete_table = '/delete_table';
  static const String upload_file = '/upload_file';
  static const String download_file = '/download_file';
  static const String notify = '/notify';
  static const String broadcast = '/broadcast';
  static const String notify_topic = '/notify_topic';
  static const String work_per_day = '/work_per_day';
  static const String work_statistics = '/work_statistics';
  static const String get_file_url = '/get_file_url';
  static const String insert_diwan_with_copyto = '/insert_diwan_with_copyto';
  static const String checkin = '/checkin';
  static const String checkout = '/checkout';

  // static String get currentLanguage {
  //   return Settings.language.runtimeType == ArLanguage ? 'lang=ar' : 'lang=en';
  // }

  // static String get currentLanguageTwoChar {
  //   return Settings.language.runtimeType == ArLanguage ? 'ar' : 'en';
  // }
}
