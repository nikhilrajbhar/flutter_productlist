class Product {
  final dynamic id;
  final String productName;
  final String productImage;
  final String productDescription;
  final int price;
  bool favorite;

  Product({
    required this.id,
    required this.productName,
    required this.productImage,
    required this.productDescription,
    required this.price,
    required this.favorite,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      productName: json['productName'],
      productImage: json['productImage'],
      productDescription: json['productDescription'],
      price: json['price'],
      favorite: json['favorite'],
    );
  }
}

// class Cases {
//   final int? id;
//   final int? userId;
//   final String? title;
//   final String? body;

//   Cases({this.id, this.userId, this.title, this.body});

//   factory Cases.fromJson(Map<String, dynamic> json) {
//     return Cases(
//       id: json['id'],
//       userId: json['userId'],
//       title: json['title'],
//       body: json['body'],
//     );
//   }

//   @override
//   String toString() {
//     return 'Trans{id: $id, name: $title, age: $title}';
//   }
// }

