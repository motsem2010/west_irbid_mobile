class StatisticData {
  final String? criteria;
  final int? count;

  StatisticData({this.criteria, this.count});

  factory StatisticData.fromJson(Map<String, dynamic> json) => StatisticData(
        criteria: json['creteria'] as String?,
        count: json['count'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'creteria': criteria,
        'count': count,
      };
}

class WorkPerDay {
  final String? dateDay;
  final String? email;
  final int? count;

  WorkPerDay({required this.dateDay, required this.email, required this.count});

  factory WorkPerDay.fromJson(Map<String, dynamic> json) => WorkPerDay(
        dateDay: json['date_day'],
        email: json['email'],
        count: json['count'],
      );

  Map<String, dynamic> toJson() => {
        'date_day': dateDay,
        'email': email,
        'count': count,
      };
}
