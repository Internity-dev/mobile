class NewsModel {
  NewsModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.content,
    required this.status,
    required this.image,
    required this.userId,
    required this.newsableType,
    required this.newsableId,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String title;
  late final String slug;
  late final String content;
  late final int status;
  late final String image;
  late final int userId;
  late final String newsableType;
  late final int newsableId;
  late final String createdAt;
  late final String updatedAt;

  NewsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    content = json['content'];
    status = json['status'];
    image = json['image'];
    userId = json['user_id'];
    newsableType = json['newsable_type'];
    newsableId = json['newsable_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['slug'] = slug;
    data['content'] = content;
    data['status'] = status;
    data['image'] = image;
    data['user_id'] = userId;
    data['newsable_type'] = newsableType;
    data['newsable_id'] = newsableId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
