class PostPresencesModel {
  PostPresencesModel({
    this.checkOut,
    required this.presenceStatusId,
    this.checkIn,
    this.attachment,
    this.description,
  });
  late final String? checkOut;
  late final String? checkIn;
  late final String? attachment;
  late final String? description;
  late final int presenceStatusId;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['check_out'] = checkOut;
    data['presence_status_id'] = presenceStatusId;
    data['check_in'] = checkIn;
    data['attachment'] = attachment;
    data['description'] = description;
    return data;
  }
}
