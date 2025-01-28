// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

class MyUser {
  MyUser({
    required this.fullName,
    required this.profession,
    required this.bio,
    required this.profilePic,
    required this.email,
    required this.address,
    required this.phoneNumber,
    this.linkedIn,
    this.github,
    this.website,
  });
  
  final String fullName;
  final String profession;
  final String bio;
  final File profilePic;
  final String email;
  final String address;
  final String phoneNumber;
  final String? linkedIn;
  final String? github;
  final String? website; 

  MyUser copyWith({
    String? fullName,
    String? profession,
    String? bio,
    File? profilePic,
    String? email,
    String? address,
    String? phoneNumber,
    String? linkedIn,
    String? github,
    String? website,
  }) {
    return MyUser(
      fullName: fullName ?? this.fullName,
      profession: profession ?? this.profession,
      bio: bio ?? this.bio,
      profilePic: profilePic ?? this.profilePic,
      email: email ?? this.email,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      linkedIn: linkedIn ?? this.linkedIn,
      github: github ?? this.github,
      website: website ?? this.website,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'profession': profession,
      'bio': bio,
      'profilePic': profilePic.path,
      'email': email,
      'address': address,
      'phoneNumber': phoneNumber,
      'linkedIn': linkedIn,
      'github': github,
      'website': website,
    };
  }

  factory MyUser.empty(){
    return MyUser(
      fullName: '',
      profession: '',
      bio: '',
      profilePic: File(''),
      email: '',
      address: '',
      phoneNumber: '',
      linkedIn: null,
      github: null,
      website: null,
    );
  }

  factory MyUser.fromMap(Map<String, dynamic> map) {
    return MyUser(
      fullName: map['fullName'] as String,
      profession: map['profession'] as String,
      bio: map['bio'] as String,
      profilePic: File(map['profilePic'] as String),
      email: map['email'] as String,
      address: map['address'] as String,
      phoneNumber: map['phoneNumber'] as String,
      linkedIn: map['linkedIn'] != null ? map['linkedIn'] as String : null,
      github: map['github'] != null ? map['github'] as String : null,
      website: map['website'] != null ? map['website'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyUser.fromJson(String source) => MyUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MyUser(fullName: $fullName, profession: $profession, bio: $bio, profilePic: $profilePic, email: $email, address: $address, phoneNumber: $phoneNumber, linkedIn: $linkedIn, github: $github, website: $website)';
  }
}
