class SessionModel {
  final String id;
  final String eventId;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final List<String> speakerIds;
  final String track;

  SessionModel({
    required this.id,
    required this.eventId,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.speakerIds,
    required this.track,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: json['id'] as String,
      eventId: json['eventId'] as String,
      title: json['title'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      speakerIds: List<String>.from(json['speakerIds'] as List),
      track: json['track'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'eventId': eventId,
      'title': title,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'speakerIds': speakerIds,
      'track': track,
    };
  }
}
