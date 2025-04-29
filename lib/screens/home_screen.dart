import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/product_card.dart';
import 'cart_screen.dart';
import 'product_detail_screen.dart';  // Import Product Detail Screen
import 'edit_product_screen.dart';   // Import Edit Product Screen

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProductProvider>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Apple Store',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.orange,  // Changed to a neutral color (orange)
        actions: [
          Stack(
            children: [
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CartScreen()),
                );
              },
            ),
            if (cartProvider.items.isNotEmpty)
              Positioned(
                right: 8,
                top: 8,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.red,
                  child: Text(
                    cartProvider.items.length.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      body: productProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : productProvider.products.isEmpty
              ? Center(child: Text('No products found'))
              : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: productProvider.products.length,
                    itemBuilder: (ctx, i) {
                      final product = productProvider.products[i];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductDetailScreen(productId: product.id),
                            ),
                          );
                        },
                        child: ProductCard(
                          product: product,
                          onAddToCart: () {
                            cartProvider.addToCart(product);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Added to cart')),
                            );
                          },
                          onDelete: () {
                            Provider.of<ProductProvider>(context, listen: false)
                                .deleteProduct(product.id);
                          },
                          onEdit: () {
                            // Navigate to edit product screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditProductScreen(product: product),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        backgroundColor: Colors.orange,  // Set the background color to yellow
        child: Icon(Icons.add, color: Colors.black),  // Icon color is black for contrast
      ),
    );
  }
}
