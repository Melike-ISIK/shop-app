import 'package:alisveris/Models/Category.dart';
import 'package:alisveris/Models/Gender.dart';
import 'package:alisveris/Models/Product.dart';

class Data{
  late List<Category> categories;
  late List<Product> products;

  Data(){
    categories = [
      Category(
          id: 1,
          name: 'Tişört',
          imagePath: 'assets/categories/tshirt.png'
      ),
      Category(
          id: 2,
          name: 'Pantolon',
          imagePath: 'assets/categories/pants.png'
      ),
      Category(
          id: 3,
          name: 'Kapşonlu',
          imagePath: 'assets/categories/hoodie.png'
      ),
      Category(
          id: 4,
          name: 'Elbise',
          imagePath: 'assets/categories/dress.png'
      ),
    ];

    products = [
      Product(
        id: 1,
        name: 'Beyaz Gömlek',
        amount: 375,
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum id libero vitae nulla imperdiet vehicula. Nunc eget magna a elit cursus tristique eget interdum turpis. Nulla eu ullamcorper lacus. Aliquam erat volutpat. Sed auctor arcu sed venenatis euismod. Quisque eget suscipit lorem. ",
        category: categories[0],
        imagePath: 'assets/products/product_0.png',
        gender: Gender.Male,
        createdAt: new DateTime(2001, 3, 28),
        isDiscounted:false,
      ),
      Product(
        id: 2,
        name: 'Siyah Tişört',
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum id libero vitae nulla imperdiet vehicula. Nunc eget magna a elit cursus tristique eget interdum turpis. Nulla eu ullamcorper lacus. Aliquam erat volutpat. Sed auctor arcu sed venenatis euismod. Quisque eget suscipit lorem. ",
        amount: 325,
        category: categories[0],
        imagePath: 'assets/products/product_1.png',
        gender: Gender.Male,
        createdAt: new DateTime(2001, 3, 26),
        isDiscounted:true,
      ),
      Product(
        id: 3,
        name: 'Yeşil-Beyaz Gömlek',
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum id libero vitae nulla imperdiet vehicula. Nunc eget magna a elit cursus tristique eget interdum turpis. Nulla eu ullamcorper lacus. Aliquam erat volutpat. Sed auctor arcu sed venenatis euismod. Quisque eget suscipit lorem. ",
        amount: 425,
        category: categories[0],
        imagePath: 'assets/products/product_2.png',
        gender: Gender.Female,
        createdAt: new DateTime(2000, 2, 9),
        isDiscounted:false,
      ),
      Product(
        id: 4,
        name: 'Yeşil Tişört',
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum id libero vitae nulla imperdiet vehicula. Nunc eget magna a elit cursus tristique eget interdum turpis. Nulla eu ullamcorper lacus. Aliquam erat volutpat. Sed auctor arcu sed venenatis euismod. Quisque eget suscipit lorem. ",
        amount: 430,
        category: categories[0],
        imagePath: 'assets/products/product_3.png',
        gender: Gender.Female,
        createdAt: new DateTime(2002, 5, 14),
        isDiscounted:true,
      ),
      Product(
        id: 5,
        name: 'Gri Pantolon',
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum id libero vitae nulla imperdiet vehicula. Nunc eget magna a elit cursus tristique eget interdum turpis. Nulla eu ullamcorper lacus. Aliquam erat volutpat. Sed auctor arcu sed venenatis euismod. Quisque eget suscipit lorem. ",
        amount: 225,
        category: categories[1],
        imagePath: 'assets/products/product_4.png',
        gender: Gender.Male,
        createdAt: new DateTime(1998, 5, 14),
        isDiscounted:false,
      ),
      Product(
        id: 6,
        name: 'Mavi Pantolon',
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum id libero vitae nulla imperdiet vehicula. Nunc eget magna a elit cursus tristique eget interdum turpis. Nulla eu ullamcorper lacus. Aliquam erat volutpat. Sed auctor arcu sed venenatis euismod. Quisque eget suscipit lorem. ",
        amount: 620,
        category: categories[1],
        imagePath: 'assets/products/product_5.png',
        gender: Gender.Male,
        createdAt: new DateTime(1998, 5, 14),
        isDiscounted:false,
      ),
      Product(
        id: 7,
        name: 'Mavi Kapşonlu',
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum id libero vitae nulla imperdiet vehicula. Nunc eget magna a elit cursus tristique eget interdum turpis. Nulla eu ullamcorper lacus. Aliquam erat volutpat. Sed auctor arcu sed venenatis euismod. Quisque eget suscipit lorem. ",
        amount: 552,
        category: categories[2],
        imagePath: 'assets/products/product_6.png',
        gender: Gender.Male,
        createdAt: new DateTime(1998, 5, 14),
        isDiscounted:true,
      ),
      Product(
        id: 8,
        name: 'Siyah Kapşonlu',
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum id libero vitae nulla imperdiet vehicula. Nunc eget magna a elit cursus tristique eget interdum turpis. Nulla eu ullamcorper lacus. Aliquam erat volutpat. Sed auctor arcu sed venenatis euismod. Quisque eget suscipit lorem. ",
        amount: 180,
        category: categories[2],
        imagePath: 'assets/products/product_7.png',
        gender: Gender.Male,
        createdAt: new DateTime(1998, 5, 14),
        isDiscounted:false,
      ),
      Product(
        id: 9,
        name: 'Çilekli Elbise',
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum id libero vitae nulla imperdiet vehicula. Nunc eget magna a elit cursus tristique eget interdum turpis. Nulla eu ullamcorper lacus. Aliquam erat volutpat. Sed auctor arcu sed venenatis euismod. Quisque eget suscipit lorem. ",
        amount: 980,
        category: categories[3],
        imagePath: 'assets/products/product_8.png',
        gender: Gender.Female,
        createdAt: new DateTime(1998, 5, 14),
        isDiscounted:false,
      ),
      Product(
        id: 10,
        name: 'Sarı Elbise',
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum id libero vitae nulla imperdiet vehicula. Nunc eget magna a elit cursus tristique eget interdum turpis. Nulla eu ullamcorper lacus. Aliquam erat volutpat. Sed auctor arcu sed venenatis euismod. Quisque eget suscipit lorem. ",
        amount: 1020,
        category: categories[3],
        imagePath: 'assets/products/product_9.png',
        gender: Gender.Female,
        createdAt: new DateTime(1998, 5, 14),
        isDiscounted:true,
      ),
    ];
  }
}