class DeveloperModel {
  final String image;
  final String name;
  final String field;
  final String shortDescription;
  final String longDescription;
  final String isAccepted;
  final String token;
  final String email;

  DeveloperModel(this.image, this.name, this.field, this.shortDescription,
      this.longDescription, this.isAccepted, this.token, this.email);

  factory DeveloperModel.fromJson(Map<String, dynamic>? data) {
    return DeveloperModel(
        data!['image'],
        data['name'],
        data['field'],
        data['shortDescription'],
        data['longDescription'],
        data['isAccepted'],
        data['token'],
        data['email']);
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'name': name,
      'field': field,
      'shortDescription': shortDescription,
      'longDescription': longDescription,
      'isAccepted': isAccepted,
      'token': token,
      'email':email
    };
  }
}
