import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:trs_app/api.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellowAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
           
            Image.network(
              product.image,
              fit: BoxFit.cover,
              width: double.infinity,
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child; 
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Center(child: Icon(Icons.error)); 
              },
            ),
            SizedBox(height: 16.0),
            Text(
              product.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            RatingBar(
              filledIcon: Icons.star,
              emptyIcon: Icons.star_border,
              onRatingChanged: (value) => debugPrint('$value'),
              initialRating: product.rating,
              maxRating: 5,
            ),
            SizedBox(height: 16.0),
            Text(
              product.description,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
