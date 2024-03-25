class ProfileDetails {
  final String id;
  final String name;
  final String imgUrl;
  final int age;
  final String country;
  final String email;

  ProfileDetails(
      {required this.id,
      required this.name,
      required this.imgUrl,
      required this.age,
      required this.country,
      required this.email});
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'imgUrl': imgUrl});
    result.addAll({'age': age});
    result.addAll({'country': country});
    result.addAll({'email': email});

    return result;
  }

  factory ProfileDetails.fromMap(Map<String, dynamic> map, String documentId) {
    return ProfileDetails(
      id: documentId,
      name: map['name'] ?? '',
      imgUrl: map['imgUrl'] ?? '',
      age: map['age'] ?? 0,
      country: map['country'] ?? '',
      email: map['email'] ?? '',
    );
  }
}
