class User {
  final int userId;
  final String name;
  final String email;
  final String username;
  final String? deviceToken;

  User({
    required this.userId,
    required this.name,
    required this.email,
    required this.username,
    this.deviceToken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      name: json['name'],
      email: json['email'],
      username: json['username'],
      deviceToken: json['device_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'name': name,
      'email': email,
      'username': username,
      'device_token': deviceToken,
    };
  }
}
