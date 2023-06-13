import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  String name;
  double amount;
  String imagePath;
  Function() onTap;

  ProductCard({Key? key, required this.amount, required this.name, required this.onTap, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Hero(
              tag: 'product-${name}',
              child: Image.asset(
                imagePath,
                width: 120,
                height: 120,
              ),
            ),
            Spacer(),
            Text(
              name,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6,),
            Text(
                "${amount.toString()} ₺"
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
