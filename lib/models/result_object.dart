class ResultObject<T> {
  final String actionName;
  final int actionId;
  String? actionInfo;
  T? returnObject;
  bool isDone;
  ResultObject(
      {required this.actionName,
      required this.actionId,
      this.actionInfo,
      this.isDone = true,
      this.returnObject});
}
