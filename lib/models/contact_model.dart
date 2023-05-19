class ContactModel {
  final String email;
  final String image;
  final String username;

  ContactModel(
      {required this.email, required this.image, required this.username});

  factory ContactModel.fromJson(Map<String, dynamic>? data) {
    return ContactModel(
      email: data!['email'],
      image: data['image'],
      username: data['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'image': image,
      'username': username,
    };
  }
}
