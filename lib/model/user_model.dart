class User {
  final int id;
  final String firstName;
  final String lastName;
  final int age;
  final String gender;
  final String email;
  final String phone;
  final String username;
  final String birthDate;
  final String image;



  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.gender,
    required this.email,
    required this.phone,
    required this.username,
    required this.birthDate,
    required this.image,
   
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      age: json['age'],
      gender: json['gender'],
      email: json['email'],
      phone: json['phone'],
      username: json['username'],
      birthDate: json['birthDate'],
      image: json['image'],
     
    );
  }
}
