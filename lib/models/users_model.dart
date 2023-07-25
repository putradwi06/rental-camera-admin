class UserModel {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String? profilePicture;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    this.profilePicture,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'fullName': this.fullName,
      'phoneNumber': this.phoneNumber,
      'email': this.email,
      'profilePicture': this.profilePicture,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      fullName: map['fullName'] as String,
      phoneNumber: map['phoneNumber'] as String,
      email: map['email'] as String,
      profilePicture: map['profilePicture'] != null ? map['profilePicture'] as String : null,
    );
  }

  UserModel copyWith({
    String? id,
    String? fullName,
    String? phoneNumber,
    String? email,
    String? profilePicture,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }
}