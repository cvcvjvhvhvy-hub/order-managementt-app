class User {
  String id;
  String name;
  String phone;
  String role; // 'grocery', 'merchant', 'admin'
  String? address;

  User({required this.id, required this.name, required this.phone, required this.role, this.address});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      role: map['role'],
      address: map['address'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'role': role,
      'address': address,
    };
  }
}