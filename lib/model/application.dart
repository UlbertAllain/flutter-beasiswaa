class application {
  final String id;
  final String email;
  final String name;
  final String scholarship;
  final String School;
  final String Address;
  final String gender;

  application({
    required this.id,
    required this.email,
    required this.name,
    required this.scholarship,
    required this.School,
    required this.Address,
    required this.gender,
  });

  factory application.fromMap(Map<String, dynamic> map, String id) {
    return application(
      id: id,
      email: map['email'],
      name: map['name'],
      scholarship: map['scholarship'],
      School: map['school'],
      Address: map['Address'],
      gender: map['gender'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'scholarship': scholarship,
      'school': School,
      'address': Address,
      'gender': gender,
    };
  }
}
