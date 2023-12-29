class WorkModel {
  String dayOfName;
  String dayOfWork;
  String time;
  WorkModel({required this.dayOfName, required this.dayOfWork,required this.time});

  factory WorkModel.fromJson(Map<String, dynamic> json) => WorkModel(
    dayOfName: json["dayOfName"],
    dayOfWork: json["dayOfWork"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "dayOfName": dayOfName,
    "dayOfWork": dayOfWork,
    "time": time,
  };

}