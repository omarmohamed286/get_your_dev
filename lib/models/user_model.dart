class UserModel {
  final String image;
  final String username;
  final String email;
  final String role;

  UserModel(
      {required this.image,
      required this.username,
      required this.email,
      required this.role});

  factory UserModel.fromJson(Map<String, dynamic>? data) {
    return UserModel(
        username: data!['username'],
        email: data['email'],
        role: data['role'],
        image: data['image']);
  }

  Map<String, dynamic> toJson() {
    return {'username': username, 'image': image, 'email': email, 'role': role};
  }
}
