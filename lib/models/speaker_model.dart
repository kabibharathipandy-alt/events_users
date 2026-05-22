class SpeakerModel {
  final String id;
  final String name;
  final String designation;
  final String company;
  final String profileImage;

  SpeakerModel({
    required this.id,
    required this.name,
    required this.designation,
    required this.company,
    required this.profileImage,
  });

  factory SpeakerModel.fromJson(Map<String, dynamic> json) {
    return SpeakerModel(
      id: json['id'] as String,
      name: json['name'] as String,
      designation: json['designation'] as String,
      company: json['company'] as String,
      profileImage: json['profileImage'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'designation': designation,
      'company': company,
      'profileImage': profileImage,
    };
  }
}
