import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  String name;
  String imagePath;
  Function() onTap;

  CategoryCard({Key? key, required this.onTap, required this.name, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 35,
            ),
            SizedBox(height: 12,),
            Text(
              name,
              style: TextStyle(
                fontSize: 12
              ),
            ),
          ],
        ),
      ),
    );
  }
}
