class FeatureDto {
  final String feature;          // e.g. "users"
  final List<String> actions;    // e.g. ["create", "read", "update", "delete"]

  FeatureDto({
    required this.feature,
    required this.actions,
  });

  factory FeatureDto.fromJson(Map<String, dynamic> json) {
    return FeatureDto(
      feature: json['feature'] as String,
      actions: List<String>.from(json['actions'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "feature": feature,
      "actions": actions,
    };
  }
}
