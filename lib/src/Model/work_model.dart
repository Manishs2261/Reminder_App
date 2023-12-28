class WorkModel {
  String? dayName;
  String? time;
  String? dayOfWork;

  WorkModel({this.dayName, this.time, this.dayOfWork});

  WorkModel.fromJson(Map<String, dynamic> json) {
    dayName = json['dayName'];
    time = json['time'];
    dayOfWork = json['dayOfWork'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dayName'] = this.dayName;
    data['time'] = this.time;
    data['dayOfWork'] = this.dayOfWork;
    return data;
  }
}
