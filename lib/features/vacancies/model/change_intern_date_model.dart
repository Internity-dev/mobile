class ChangeInternDate {
  ChangeInternDate({
    required this.startDate,
    required this.endDate,
  });
  late final String startDate;
  late final String endDate;

  ChangeInternDate.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['start_date'] = startDate;
    _data['end_date'] = endDate;
    return _data;
  }
}
