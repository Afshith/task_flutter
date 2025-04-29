import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productId;

  const ProductDetailScreen({Key? key, required this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context, listen: false).findById(productId);

    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.imageUrl!, fit: BoxFit.cover),
            SizedBox(height: 10),
            Text(product.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            SizedBox(height: 10),
            Text('₹${product.price.toStringAsFixed(2)}', style: TextStyle(color: Colors.green, fontSize: 20)),
            SizedBox(height: 20),
            Text(product.description),
          ],
        ),
      ),
    );
  }
}
