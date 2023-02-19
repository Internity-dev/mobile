class AuthModel {
  AuthModel({
    required this.message,
    required this.accessToken,
    required this.tokenType,
  });
  late final String message;
  late final String accessToken;
  late final String tokenType;

  AuthModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    accessToken = json['access_token'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    return data;
  }
}
