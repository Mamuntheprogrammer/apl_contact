class Contact {
  final int id;
  final String department;
  final String name;
  final String designation;
  final String ip;
  final String personalNumber;
  final String profileImage;
  final String email;
  final bool isActive;

  Contact({
    required this.id,
    required this.department,
    required this.name,
    required this.designation,
    required this.ip,
    required this.personalNumber,
    required this.profileImage,
    required this.email,
    required this.isActive,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'] ?? 0,
      department: json['department'] ?? '',
      name: json['name'] ?? '',
      designation: json['designation'] ?? '',
      ip: json['ip'] ?? '',
      personalNumber: json['personal_number'] ?? '',
      profileImage: json['profile_image'] ?? '',
      email: json['email'] ?? '',
      isActive:
          json['isactive'] is bool
              ? json['isactive']
              : (json['isactive'].toString().toLowerCase() == 'true'),
    );
  }
}
