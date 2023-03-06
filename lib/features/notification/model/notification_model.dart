class NotificationModel {
  NotificationModel({
    required this.id,
    this.userId,
    required this.title,
    required this.body,
    this.readAt,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final Null userId;
  late final String title;
  late final String body;
  late final Null readAt;
  late final String createdAt;
  late final String updatedAt;

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = null;
    title = json['title'];
    body = json['body'];
    readAt = null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = userId;
    _data['title'] = title;
    _data['body'] = body;
    _data['read_at'] = readAt;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}
