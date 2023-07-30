class MessageModel {
  final String message;
  final String id;
  MessageModel({required this.message,required this.id});

  factory MessageModel.fromJson(Map<String, dynamic>? data) {
    return MessageModel(
      message: data!['message'],
      id: data['id']
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message,
    'id':id,
     'createdAt': DateTime.now()};
  }
}