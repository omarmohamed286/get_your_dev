class UserModel {
  final String username, email, image, role;

  final String? field, shortDescription, longDescription, status;

  UserModel(
      {required this.username,
      required this.email,
      required this.image,
      required this.role,
      required this.field,
      required this.shortDescription,
      required this.longDescription,
      required this.status});

  factory UserModel.fromJson(Map<String, dynamic>? data) {
    return UserModel(
        username: data!['username'],
        email: data['email'],
        image: data['image'],
        role: data['role'],
        field: data['field'],
        shortDescription: data['shortDescription'],
        longDescription: data['longDescription'],
        status: data['status']);
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'image': image,
      'role': role,
      'field': field,
      'shortDescription': shortDescription,
      'longDescription': longDescription,
      'status': status
    };
  }
}
