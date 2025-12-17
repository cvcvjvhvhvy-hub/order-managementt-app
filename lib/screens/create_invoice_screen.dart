import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../models/invoice.dart';
import '../services/firestore_service.dart';

class CreateInvoiceScreen extends StatefulWidget {
  const CreateInvoiceScreen({super.key});

  @override
  _CreateInvoiceScreenState createState() => _CreateInvoiceScreenState();
}

class _CreateInvoiceScreenState extends State<CreateInvoiceScreen> {
  final List<InvoiceItem> _items = [];
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();

  void _addItem() {
    if (_nameController.text.isNotEmpty && _quantityController.text.isNotEmpty) {
      setState(() {
        _items.add(InvoiceItem(name: _nameController.text, quantity: int.parse(_quantityController.text)));
        _nameController.clear();
        _quantityController.clear();
      });
    }
  }

  void _submit() async {
    if (_items.isNotEmpty) {
      final user = context.read<AuthProvider>().user!;
      final invoice = Invoice(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        groceryId: user.id,
        groceryName: user.name,
        phone: user.phone,
        address: user.address!,
        items: _items,
      );
      await FirestoreService().addInvoice(invoice);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Invoice')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Item Name'))),
                const SizedBox(width: 10),
                Expanded(child: TextField(controller: _quantityController, decoration: const InputDecoration(labelText: 'Quantity'), keyboardType: TextInputType.number)),
                IconButton(onPressed: _addItem, icon: const Icon(Icons.add)),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text('Quantity: ${item.quantity}'),
                  );
                },
              ),
            ),
            ElevatedButton(onPressed: _submit, child: const Text('Submit Invoice')),
          ],
        ),
      ),
    );
  }
}