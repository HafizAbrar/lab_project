class CreateEmployeeProfileDto {
  final String userId;
  final String? hireDate;
  final String? jobTitle;
  final String? department;
  final String? status;

  CreateEmployeeProfileDto({
    required this.userId,
    this.hireDate,
    this.jobTitle,
    this.department,
    this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      if (hireDate != null) "hireDate": hireDate,
      if (jobTitle != null) "jobTitle": jobTitle,
      if (department != null) "department": department,
      if (status != null) "status": status,
    };
  }
}
