import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/item.dart';

class FirestoreService {
  static final CollectionReference _items =
      FirebaseFirestore.instance.collection('items');

  /// Get real-time stream of items
  Stream<List<Item>> getItems() {
    return _items.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Item.fromMap(doc.id, data);
      }).toList();
    });
  }

  /// Add a new item and return its generated ID
  Future<String> addItem(Item item) async {
    try {
      print('Adding item: ${item.name}');
      final docRef = await _items.add(item.toMap());
      print('Item added with ID: ${docRef.id}');
      return docRef.id;
    } catch (e, stack) {
      print('🔥 Error adding item: $e\n$stack');
      rethrow;
    }
  }

  /// Update an existing item
  Future<void> updateItem(Item item) async {
    if (item.id.isEmpty) {
      throw ArgumentError('Item ID cannot be empty when updating.');
    }

    try {
      print('Updating item ID: ${item.id}');
      await _items.doc(item.id).update(item.toMap());
      print('Item updated');
    } catch (e, stack) {
      print('🔥 Error updating item: $e\n$stack');
      rethrow;
    }
  }

  /// Delete an item
  Future<void> deleteItem(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('Item ID cannot be empty when deleting.');
    }

    try {
      print('Deleting item ID: $id');
      await _items.doc(id).delete();
      print('Item deleted');
    } catch (e, stack) {
      print('Error deleting item: $e\n$stack');
      rethrow;
    }
  }
}
