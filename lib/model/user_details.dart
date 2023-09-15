class UserDetailsModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String image;
  final int age;
  final String gender;
  final String birthDate;
  final String city;
  final String address;
  final String bloodGroup;
  final int height;
  final double weight;

  UserDetailsModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.image,
    required this.age,
    required this.gender,
    required this.birthDate,
    required this.city,
    required this.address,
    required this.bloodGroup,
    required this.height,
    required this.weight,
  });

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) {
    return UserDetailsModel(
      id: json['id'] as int,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      image: json['image'] as String,
      age: json['age'] as int, 
      gender: json['gender'] as String,
      birthDate: json['birthDate'] as String,
      city: json['address']['city'] as String,
      address: json['address']['address'] as String,
      bloodGroup: json['bloodGroup'] as String,
      height: json['height'] as int,
      weight: json['weight'] as double,
    );
  }
}
