class PostJournal {
  PostJournal({
    required this.workType,
    required this.description,
  });
  late final String workType;
  late final String description;

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['work_type'] = workType;
    _data['description'] = description;
    return _data;
  }
}
