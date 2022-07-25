import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart';
import 'package:projectsecond/controllers/product_controller.dart';

class ProductAdd extends StatefulWidget {
  const ProductAdd({Key? key}) : super(key: key);

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  final productController = Get.put(ProductController());
  final url = "https://jsonplaceholder.typicode.com/posts";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  // void _printLatestValue() {
  //   print('Second text field: ${myController.text}');
  // }

  var productname = '';
  var productDescription = '';
  var price = '';
  var imagelink = '';
  bool postsuccess = false;

  void mytextvalue() async {
    print(productname);
    print(productDescription);
    print(price);
    print(imagelink);

    Map data = {
      "productName": productname,
      "productDescription": productDescription,
      "price": price,
      "productImage": imagelink,
      'favorite': true
    };
    var result = await productController.postProductData(data);
    print("===========result=================");
    if (result) {
      setState(() {
        postsuccess = result;
      });
    }
  }

  Widget _buildChild() {
    print("postsuccess===========================");
    print(postsuccess);
    if (postsuccess) {
      return const Text("Product Added...........");
    }
    return const Text("Add product..");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
        key: _formKey,
      ),
      body: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter your product name',
              ),
              onChanged: (text) {
                setState(() {
                  productname = text;
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter your product descrpition',
              ),
              onChanged: (text) {
                setState(() {
                  productDescription = text;
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter your product price',
              ),
              keyboardType: TextInputType.number,
              onChanged: (text) {
                setState(() {
                  price = text;
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter your product image link',
              ),
              onChanged: (text) {
                setState(() {
                  imagelink = text;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  mytextvalue();
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                },
                child: const Text('Submit'),
              ),
            ),
            Stack(
              children: <Widget>[
                Center(
                  child: _buildChild(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
