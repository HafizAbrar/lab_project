class UpdateEmployeeProfileDto {
  final String? jobTitle;
  final String? department;
  final String? status;
  final String? hireDate;

  UpdateEmployeeProfileDto({
    this.jobTitle,
    this.department,
    this.status,
    this.hireDate,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = {};
    if (jobTitle != null) map["jobTitle"] = jobTitle;
    if (department != null) map["department"] = department;
    if (status != null) map["status"] = status;
    if (hireDate != null) map["hireDate"] = hireDate;
    return map;
  }
}
