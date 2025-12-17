class Bid {
  String id;
  String invoiceId;
  String merchantId;
  double price;
  DateTime createdAt;

  Bid({
    required this.id,
    required this.invoiceId,
    required this.merchantId,
    required this.price,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Bid.fromMap(Map<String, dynamic> map) {
    return Bid(
      id: map['id'],
      invoiceId: map['invoiceId'],
      merchantId: map['merchantId'],
      price: map['price'].toDouble(),
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'invoiceId': invoiceId,
      'merchantId': merchantId,
      'price': price,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}