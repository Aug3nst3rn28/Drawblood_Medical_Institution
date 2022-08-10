class AppoinmentList {
  final String? user_id;
  final String? venue;
  final String? status;
  final DateTime? date;
  final DateTime? createdate;

  AppoinmentList(
      {this.user_id, this.venue, this.status, this.date, this.createdate});

  static AppoinmentList fromJson(Map<String, dynamic> snapshot) =>
      AppoinmentList(
        venue: snapshot['vanue'],
        status: snapshot['status'],
        date: snapshot['date'].toDate(),
        createdate: snapshot['createdate'].toDate(),
      );

  Map<String, dynamic> toJson() =>
      {"vanue": venue, "status": status, "createdate": createdate};
}
