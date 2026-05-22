class TicketModel {
  final String id;
  final String eventId;
  final String name;
  final double price;
  final String type; // Free, Paid
  final int availableQuantity;

  TicketModel({
    required this.id,
    required this.eventId,
    required this.name,
    required this.price,
    required this.type,
    required this.availableQuantity,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      id: json['id'] as String,
      eventId: json['eventId'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      type: json['type'] as String,
      availableQuantity: json['availableQuantity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'eventId': eventId,
      'name': name,
      'price': price,
      'type': type,
      'availableQuantity': availableQuantity,
    };
  }
}
