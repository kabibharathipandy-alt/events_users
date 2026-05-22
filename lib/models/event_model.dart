class EventModel {
  final String id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String location;
  final String eventType; // Virtual, Hybrid, In-Person
  final String bannerImage;
  final String status;
  final String url;
  final List<String> categoryIds;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.eventType,
    required this.bannerImage,
    required this.status,
    required this.url,
    required this.categoryIds,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      location: json['location'] as String,
      eventType: json['eventType'] as String,
      bannerImage: json['bannerImage'] as String,
      status: json['status'] as String,
      url: json['url'] as String,
      categoryIds: List<String>.from(json['categoryIds'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'location': location,
      'eventType': eventType,
      'bannerImage': bannerImage,
      'status': status,
      'url': url,
      'categoryIds': categoryIds,
    };
  }
}
