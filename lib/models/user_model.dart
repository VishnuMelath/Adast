class UserModel {
  String name;
  String email;
  String? image;
  List<String> subscriptions;
  List<String> saved;

  UserModel(
      {this.image,
      required this.name,
      required this.email,
      this.subscriptions = const [],
      this.saved=const[]});

  Map<String, dynamic> toMap() {
    return {
      'emailaddress': email,
      'image': image,
      'name': name,
      'subscriptions':subscriptions,
      'saved':saved
    };
  }
}
