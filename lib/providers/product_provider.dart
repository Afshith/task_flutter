import 'package:flutter/material.dart';
import 'package:flutter_application/services/api_service.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  // Fetch the products from the API
  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners(); // Notify UI that loading has started

    try {
      _products = await ApiService.getProducts();
    } catch (e) {
      print('Fetch error: $e');
    }

    _isLoading = false; // Set loading state to false
    notifyListeners(); // Notify UI that loading has finished and products are fetched
  }

  // Add a new product
  Future<void> addProduct(Product product) async {
    try {
      final newProduct = await ApiService.addProduct(product);
      _products.add(newProduct);
      notifyListeners();
    } catch (e) {
      print('Add error: $e');
    }
  }

  // Update a product
  Future<void> updateProduct(Product product) async {
    try {
      await ApiService.updateProduct(product);
      final index = _products.indexWhere((p) => p.id == product.id);
      if (index != -1) {
        _products[index] = product;
        notifyListeners();
      }
    } catch (e) {
      print('Update error: $e');
    }
  }

  // Delete a product
  Future<void> deleteProduct(String id) async {
    try {
      await ApiService.deleteProduct(id);
      _products.removeWhere((p) => p.id == id);
      notifyListeners(); // Notify after removing the product
    } catch (e) {
      print('Delete error: $e');
    }
  }

  Product findById(String id) {
    return _products.firstWhere((p) => p.id == id);
  }
}
