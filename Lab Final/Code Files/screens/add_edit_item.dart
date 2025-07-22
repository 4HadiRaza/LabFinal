import 'package:flutter/material.dart';
import '../models/item.dart';
import '../services/firestore_service.dart';

class AddEditItemScreen extends StatefulWidget {
  final Item? item;

  const AddEditItemScreen({super.key, this.item});

  @override
  State<AddEditItemScreen> createState() => _AddEditItemScreenState();
}

class _AddEditItemScreenState extends State<AddEditItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _service = FirestoreService();

  String name = '';
  String category = '';
  int quantity = 0;
  double price = 0;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      name = widget.item!.name;
      category = widget.item!.category;
      quantity = widget.item!.quantity;
      price = widget.item!.price;
    }
  }

  Future<void> saveItem() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();
    setState(() => _isSaving = true);

    final newItem = Item(
      id: widget.item?.id ?? '',
      name: name,
      category: category,
      quantity: quantity,
      price: price,
    );

    try {
      if (widget.item == null) {
        await _service.addItem(newItem);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Item added successfully!')),
        );
      } else {
        await _service.updateItem(newItem);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Item updated successfully!')),
        );
      }
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.item != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Item' : 'Add Item')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(labelText: 'Item Name'),
                validator: (val) => val!.isEmpty ? 'Required' : null,
                onSaved: (val) => name = val!,
              ),
              TextFormField(
                initialValue: category,
                decoration: const InputDecoration(labelText: 'Category'),
                validator: (val) => val!.isEmpty ? 'Required' : null,
                onSaved: (val) => category = val!,
              ),
              TextFormField(
                initialValue: quantity.toString(),
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (val) {
                  final num = int.tryParse(val ?? '');
                  return (num == null || num < 0) ? 'Invalid quantity' : null;
                },
                onSaved: (val) => quantity = int.parse(val!),
              ),
              TextFormField(
                initialValue: price.toString(),
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (val) {
                  final num = double.tryParse(val ?? '');
                  return (num == null || num < 0) ? 'Invalid price' : null;
                },
                onSaved: (val) => price = double.parse(val!),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isSaving ? null : saveItem,
                child: Text(_isSaving
                    ? 'Saving...'
                    : isEdit
                        ? 'Update'
                        : 'Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
