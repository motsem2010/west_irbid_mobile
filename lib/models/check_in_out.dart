class CheckInOut {
  bool? isWithinZone;
  String? message;
  int? employeeFingerprintLocationID;
  int? matchedLocationID;
  String? matchedLocationName;
  double? distanceInMeters;
  String? transactionDate;

  CheckInOut({
    this.isWithinZone,
    this.message,
    this.employeeFingerprintLocationID,
    this.matchedLocationID,
    this.matchedLocationName,
    this.distanceInMeters,
    this.transactionDate,
  });

  factory CheckInOut.fromJson(Map<String, dynamic> json) {
    return CheckInOut(
      isWithinZone: json['isWithinZone'],
      message: json['message'],
      employeeFingerprintLocationID: json['employeeFingerprintLocationID'],
      matchedLocationID: json['matchedLocationID'],
      matchedLocationName: json['matchedLocationName'],
      distanceInMeters: (json['distanceInMeters'] as num?)?.toDouble(),
      transactionDate: json['transactionDate'],
    );
  }
}
