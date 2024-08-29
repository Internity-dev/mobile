class JournalModel {
  JournalModel({
    required this.id,
    required this.companyId,
    required this.userId,
    required this.date,
    required this.workType,
    required this.description,
    required this.isApproved,
    required this.createdAt,
    required this.updatedAt,
    required this.filled,
  });
  late final int id;
  late final int companyId;
  late final int userId;
  late final String date;
  late final String? workType;
  late final String? description;
  late final bool isApproved;
  late final String createdAt;
  late final String updatedAt;
  late final bool filled;

  JournalModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    userId = json['user_id'];
    date = json['date'];
    workType = json['work_type'];
    description = json['description'];
    isApproved = json['is_approved'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    filled = json['filled'];
  }
}
