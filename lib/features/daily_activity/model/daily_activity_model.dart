class DailyActivityModel {
  DailyActivityModel({
    required this.status,
    required this.message,
    this.presence,
    this.journal,
  });
  late final bool status;
  late final String message;
  Presence? presence;
  Journal? journal;

  DailyActivityModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    presence = presence != null ? Presence.fromJson(json['presence']) : null;
    journal = journal != null ? Journal.fromJson(json['journal']) : null;
  }
}

class Presence {
  Presence({
    required this.id,
    required this.companyId,
    required this.userId,
    required this.presenceStatusId,
    required this.date,
    this.checkIn,
    this.checkOut,
    this.attachment,
    required this.isApproved,
    this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.presenceStatus,
  });
  late final int id;
  late final int companyId;
  late final int userId;
  late final int presenceStatusId;
  late final String date;
  String? checkIn;
  String? checkOut;
  String? attachment;
  late final int isApproved;
  String? description;
  late final String createdAt;
  late final String updatedAt;
  late final PresenceStatus presenceStatus;

  Presence.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    userId = json['user_id'];
    presenceStatusId = json['presence_status_id'];
    date = json['date'];
    checkIn = json['check_in'];
    checkOut = json['check_out'];
    attachment = json['attachment'];
    isApproved = json['is_approved'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    presenceStatus = PresenceStatus.fromJson(json['presence_status']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['company_id'] = companyId;
    data['user_id'] = userId;
    data['presence_status_id'] = presenceStatusId;
    data['date'] = date;
    data['check_in'] = checkIn;
    data['check_out'] = checkOut;
    data['attachment'] = attachment;
    data['is_approved'] = isApproved;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['presence_status'] = presenceStatus.toJson();
    return data;
  }
}

class PresenceStatus {
  PresenceStatus({
    required this.id,
    required this.schoolId,
    required this.name,
    this.description,
    required this.color,
    this.icon,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final int schoolId;
  late final String name;
  String? description;
  late final String color;
  String? icon;
  late final int status;
  late final String createdAt;
  late final String updatedAt;

  PresenceStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    schoolId = json['school_id'];
    name = json['name'];
    description = json['description'];
    color = json['color'];
    icon = json['icon'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['school_id'] = schoolId;
    data['name'] = name;
    data['description'] = description;
    data['color'] = color;
    data['icon'] = icon;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Journal {
  Journal({
    required this.id,
    required this.companyId,
    required this.userId,
    required this.date,
    this.workType,
    this.description,
    required this.isApproved,
    required this.createdAt,
    required this.updatedAt,
    required this.filled,
  });
  late final int id;
  late final int companyId;
  late final int userId;
  late final String date;
  String? workType;
  String? description;
  late final bool isApproved;
  late final String createdAt;
  late final String updatedAt;
  late final bool filled;

  Journal.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['company_id'] = companyId;
    data['user_id'] = userId;
    data['date'] = date;
    data['work_type'] = workType;
    data['description'] = description;
    data['is_approved'] = isApproved;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['filled'] = filled;
    return data;
  }
}
