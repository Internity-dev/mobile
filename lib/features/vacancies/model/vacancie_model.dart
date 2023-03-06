class VacancieModel {
  VacancieModel({
    required this.id,
    required this.companyId,
    required this.name,
    required this.category,
    required this.description,
    required this.skills,
    required this.slots,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.applied,
    required this.company,
    required this.inProcessed,
    required this.inPending,
    this.pendingAppliances,
  });
  late final int id;
  late final int companyId;
  late final String name;
  late final String category;
  late final String description;
  late final String skills;
  late final int slots;
  late final int status;
  late final String createdAt;
  late final String updatedAt;
  late final int applied;
  late final bool inProcessed;
  late final bool inPending;
  late final Company company;
  late final PendingAppliances? pendingAppliances;

  List<String>? get getSkills => skills.split(',');

  VacancieModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    name = json['name'];
    category = json['category'];
    description = json['description'];
    skills = json['skills'];
    slots = json['slots'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    applied = json['applied'];
    inProcessed = json['in_processed'];
    inPending = json['in_pending'];
    company = Company.fromJson(json['company']);
    pendingAppliances = json['pending_appliances'] != null
        ? PendingAppliances.fromJson(json['pending_appliances'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['company_id'] = companyId;
    data['name'] = name;
    data['category'] = category;
    data['description'] = description;
    data['skills'] = skills;
    data['slots'] = slots;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['applied'] = applied;
    data['company'] = company.toJson();
    return data;
  }
}

class Company {
  Company({
    required this.id,
    required this.departmentId,
    required this.name,
    required this.category,
    required this.city,
    required this.state,
    required this.address,
    required this.email,
    required this.phone,
    required this.country,
    required this.website,
    required this.logo,
    required this.contactPerson,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final int departmentId;
  late final String name;
  late final String category;
  late final String city;
  late final String state;
  late final String address;
  late final String email;
  late final String phone;
  late final String country;
  late final String website;
  late final String logo;
  late final String contactPerson;
  late final int status;
  late final String createdAt;
  late final String updatedAt;

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    departmentId = json['department_id'];
    name = json['name'];
    category = json['category'];
    city = json['city'];
    state = json['state'];
    address = json['address'];
    email = json['email'];
    phone = json['phone'];
    country = json['country'];
    website = json['website'];
    logo = json['logo'];
    contactPerson = json['contact_person'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['department_id'] = departmentId;
    data['name'] = name;
    data['category'] = category;
    data['city'] = city;
    data['state'] = state;
    data['address'] = address;
    data['email'] = email;
    data['phone'] = phone;
    data['country'] = country;
    data['website'] = website;
    data['logo'] = logo;
    data['contact_person'] = contactPerson;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class PendingAppliances {
  PendingAppliances({
    required this.id,
    required this.userId,
    required this.vacancyId,
    required this.status,
    this.message,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final int userId;
  late final int vacancyId;
  late final String status;
  late final String? message;
  late final String createdAt;
  late final String updatedAt;

  PendingAppliances.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    vacancyId = json['vacancy_id'];
    status = json['status'];
    message = json['message'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['vacancy_id'] = vacancyId;
    data['status'] = status;
    data['message'] = message;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
