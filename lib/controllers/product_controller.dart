import 'package:get/get.dart';
import 'package:projectsecond/models/product_model.dart';
import 'package:http/http.dart';
import 'dart:convert';

class ProductController extends GetxController {
  List<Product> productData = [];

  List<Product> cartItem = List<Product>.empty().obs;

  addtoCart(Product item) {
    print("calling addToCart");
    cartItem.add(item);
  }

  double get totalPrice => cartItem.fold(0, (sum, item) => sum + item.price);
  int get count => cartItem.length;

  @override
  void onInit() {
    super.onInit();
    fatchProductData();
  }

  fatchProductData() async {
    var uri = Uri.parse('https://testingproduct.herokuapp.com/product');

    var response = await get(uri);

    print(response.body);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      List<Product> product =
          body.map((dynamic item) => Product.fromJson(item)).toList();

      productData.assignAll(product);
      print(
          productData); //[Instance of 'Product', Instance of 'Product', Instance of 'Product']
      update();
      print("res====================2"); //checkimg this
    } else {
      throw "Failed to load cases list";
    }
  }

  postProductData(data) async {
    print("posting=====================");
    var uri = Uri.parse('https://testingproduct.herokuapp.com/product');
    print("posting==============11=======1");
    print(data);

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await post(
      uri,
      headers: requestHeaders,
      body: jsonEncode(data),
    );
    print("posting=====22222=========11=======1");
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      print(productData);
      productData.add(Product.fromJson(json.decode(response.body)));
      update();
      return true;
    } else {
      throw Exception('Failed to post');
    }
  }

  adddToFavorites(id) {
    var index = productData.indexWhere((element) => element.id == id);
    productData[index].favorite = !productData[index].favorite;
    update();
  }
}
