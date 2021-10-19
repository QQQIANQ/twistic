class UserModel {
  final String id;
  final String? bannerImageUrl;
  final String? profileImageUrl;
  final String? name;
  final String? email;

  UserModel({this.bannerImageUrl, this.profileImageUrl, this.name, this.email, required this.id});
}
