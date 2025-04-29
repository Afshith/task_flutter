import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:5000/api/products'; 

  static Future<List<Product>> getProducts() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((productData) => Product.fromJson(productData)).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load products');
    }
  }

  // Add a product to the API
  static Future<Product> addProduct(Product product) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        body: json.encode(product.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        return Product.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to add product: ${response.statusCode}');
      }
    } catch (e) {
      print('Add error: $e');
      throw Exception('Failed to add product');
    }
  }

  // Update a product on the API
  static Future<void> updateProduct(Product product) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/${product.id}'),
        body: json.encode(product.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update product: ${response.statusCode}');
      }
    } catch (e) {
      print('Update error: $e');
      throw Exception('Failed to update product');
    }
  }

  // Delete a product from the API
  static Future<void> deleteProduct(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/$id'),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete product: ${response.statusCode}');
      }
    } catch (e) {
      print('Delete error: $e');
      throw Exception('Failed to delete product');
    }
  }
}
