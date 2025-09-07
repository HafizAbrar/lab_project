class EmployeeProfileDto {
  final String id;
  final String userId;
  final String employeeCode;
  final String? hireDate;
  final String? jobTitle;
  final String? department;
  final String? profileImage;
  final String? status;
  final UserDto? user; // <-- make nullable

  EmployeeProfileDto({
    required this.id,
    required this.userId,
    required this.employeeCode,
    this.hireDate,
    this.jobTitle,
    this.department,
    this.profileImage,
    this.status,
    required this.user,
  });

  factory EmployeeProfileDto.fromJson(Map<String, dynamic> json) {
    return EmployeeProfileDto(
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      employeeCode: json['employeeCode'] as String? ?? '',
      hireDate: json['hireDate'] as String?,
      jobTitle: json['jobTitle'] as String?,
      department: json['department'] as String?,
      profileImage: json['profileImage'] as String?,
      status: json['status'] as String?,
      user: json['user'] != null
          ? UserDto.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userId": userId,
      "employeeCode": employeeCode,
      "hireDate": hireDate,
      "jobTitle": jobTitle,
      "department": department,
      "profileImage": profileImage,
      "status": status,
      "user": user?.toJson(), // <-- null-safe
    };
  }
}

class UserDto {
  final String id;
  final String email;
  final String fullName;
  final String roleId;


  UserDto({
    required this.id,
    required this.email,
    required this.fullName,
    required this.roleId,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      roleId: json['roleId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "fullName": fullName,
      "roleId": roleId,

    };
  }
}