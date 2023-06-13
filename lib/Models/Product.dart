import 'package:alisveris/Models/Category.dart';
import 'package:alisveris/Models/Gender.dart';

class Product{
  int id;
  String name;
  String description;
  String imagePath;
  double amount;
  Category category;
  Gender gender;
  DateTime createdAt;
  bool isDiscounted;

  Product({
    required this.name,
    required this.id,
    required this.description,
    required this.amount,
    required this.imagePath,
    required this.category,
    required this.gender,
    required this.createdAt,
    required this.isDiscounted,
  });
}