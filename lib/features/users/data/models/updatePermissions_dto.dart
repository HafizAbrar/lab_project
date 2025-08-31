class UpdatePermissionDto {
  final String feature;
  final List<String> actions; // should be ["create", "read", ...]
  final String assignmentAction;

  UpdatePermissionDto({
    required this.feature,
    required this.actions,
    required this.assignmentAction,
  });

  Map<String, dynamic> toJson() {
    return {
      "feature": feature,
      "actions": actions,
      "assignmentAction": assignmentAction,
    };
  }
}
