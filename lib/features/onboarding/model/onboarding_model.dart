class Onboarding {
  Onboarding({
    required this.isOnboarding,
  });
  late final bool isOnboarding;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['is_onboarding'] = isOnboarding;
    return data;
  }
}
