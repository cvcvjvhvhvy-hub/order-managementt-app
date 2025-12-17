import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/invoice.dart';
import '../models/bid.dart';
import '../models/user.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Invoices
  Future<void> addInvoice(Invoice invoice) async {
    await _firestore.collection('invoices').doc(invoice.id).set(invoice.toMap());
  }

  Stream<List<Invoice>> getInvoicesForMerchant() {
    return _firestore.collection('invoices').where('status', isEqualTo: 'pending').snapshots().map(
      (snapshot) => snapshot.docs.map((doc) => Invoice.fromMap(doc.data())).toList()
    );
  }

  Stream<List<Invoice>> getInvoicesForGrocery(String groceryId) {
    return _firestore.collection('invoices').where('groceryId', isEqualTo: groceryId).snapshots().map(
      (snapshot) => snapshot.docs.map((doc) => Invoice.fromMap(doc.data())).toList()
    );
  }

  Future<List<Invoice>> getAllInvoices() async {
    var snapshot = await _firestore.collection('invoices').get();
    return snapshot.docs.map((doc) => Invoice.fromMap(doc.data())).toList();
  }

  Future<void> updateInvoiceStatus(String invoiceId, String status, {double? price, String? merchantId}) async {
    Map<String, dynamic> update = {'status': status};
    if (price != null) update['lowestPrice'] = price;
    if (merchantId != null) update['selectedMerchantId'] = merchantId;
    await _firestore.collection('invoices').doc(invoiceId).update(update);
  }

  // Bids
  Future<void> addBid(Bid bid) async {
    await _firestore.collection('bids').doc(bid.id).set(bid.toMap());
  }

  Stream<List<Bid>> getBidsForInvoice(String invoiceId) {
    return _firestore.collection('bids').where('invoiceId', isEqualTo: invoiceId).snapshots().map(
      (snapshot) => snapshot.docs.map((doc) => Bid.fromMap(doc.data())).toList()
    );
  }

  // Users
  Future<List<User>> getAllUsers() async {
    var snapshot = await _firestore.collection('users').get();
    return snapshot.docs.map((doc) => User.fromMap(doc.data())).toList();
  }
}