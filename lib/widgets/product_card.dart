import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;
  final VoidCallback onDelete;
  final VoidCallback onEdit;  // Add onEdit parameter for Edit button

  const ProductCard({
    Key? key,
    required this.product,
    required this.onAddToCart,
    required this.onDelete,
    required this.onEdit,  // This parameter is now passed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: product.imageUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        product.imageUrl!,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.broken_image, size: 50, color: Colors.grey),
                      ),
                    )
                  : Container(
                      color: Colors.grey[200],
                      child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                    ),
            ),
            SizedBox(height: 8),
            Text(
              product.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
            Text('₹${product.price.toStringAsFixed(2)}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: onEdit,  // Trigger edit function
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: onDelete,  // Trigger delete function
                ),
                IconButton(
                  icon: Icon(Icons.add_shopping_cart, color: Colors.green),
                  onPressed: onAddToCart,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
