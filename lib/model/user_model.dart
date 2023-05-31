class User {
  String name;
  String image;
  String status;
  String language;
  String about;
  List<String> interests;
  Map<String, String> availability;
  String email;
  String phone;

  User({
    required this.name,
    required this.image,
    required this.status,
    required this.language,
    required this.about,
    required this.interests,
    required this.availability,
    required this.email,
    required this.phone,
  });
}
