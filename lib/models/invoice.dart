class Invoice {
  String id;
  String groceryId;
  String groceryName;
  String phone;
  String address;
  List<InvoiceItem> items;
  String status; // 'pending', 'priced', 'approved'
  double? lowestPrice;
  String? selectedMerchantId;
  DateTime createdAt;

  Invoice({
    required this.id,
    required this.groceryId,
    required this.groceryName,
    required this.phone,
    required this.address,
    required this.items,
    this.status = 'pending',
    this.lowestPrice,
    this.selectedMerchantId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Invoice.fromMap(Map<String, dynamic> map) {
    return Invoice(
      id: map['id'],
      groceryId: map['groceryId'],
      groceryName: map['groceryName'],
      phone: map['phone'],
      address: map['address'],
      items: (map['items'] as List).map((e) => InvoiceItem.fromMap(e)).toList(),
      status: map['status'] ?? 'pending',
      lowestPrice: map['lowestPrice']?.toDouble(),
      selectedMerchantId: map['selectedMerchantId'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'groceryId': groceryId,
      'groceryName': groceryName,
      'phone': phone,
      'address': address,
      'items': items.map((e) => e.toMap()).toList(),
      'status': status,
      'lowestPrice': lowestPrice,
      'selectedMerchantId': selectedMerchantId,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class InvoiceItem {
  String name;
  int quantity;

  InvoiceItem({required this.name, required this.quantity});

  factory InvoiceItem.fromMap(Map<String, dynamic> map) {
    return InvoiceItem(name: map['name'], quantity: map['quantity']);
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'quantity': quantity};
  }
}