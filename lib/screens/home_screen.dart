import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../models/user.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;
    if (user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    Widget body;
    switch (user.role) {
      case 'grocery':
        body = GroceryHome(user: user);
        break;
      case 'merchant':
        body = MerchantHome(user: user);
        break;
      case 'admin':
        body = AdminHome(user: user);
        break;
      default:
        body = const Center(child: Text('Unknown role'));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome ${user.name}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => context.read<AuthProvider>().signOut().then((_) => Navigator.pushReplacementNamed(context, '/')),
          ),
        ],
      ),
      body: body,
    );
  }
}

class GroceryHome extends StatelessWidget {
  final User user;
  const GroceryHome({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, '/create_invoice'),
        child: const Text('Create Invoice'),
      ),
    );
  }
}

class MerchantHome extends StatelessWidget {
  final User user;
  const MerchantHome({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Merchant Home'));
  }
}

class AdminHome extends StatelessWidget {
  final User user;
  const AdminHome({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Admin Home'));
  }
}