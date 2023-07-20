import 'dart:convert';
import 'package:barterlt/buyer/paymentscreen.dart';
import 'package:barterlt/models/card.dart';
import 'package:barterlt/models/cart.dart';
import 'package:barterlt/models/item.dart';
import 'package:barterlt/models/user.dart';
import 'package:barterlt/myconfig.dart';
import 'package:barterlt/shared/cardinfoscreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class BuyerCartScreen extends StatefulWidget {
  final User user;
  const BuyerCartScreen({super.key, required this.user});

  @override
  State<BuyerCartScreen> createState() => _BuyerCartScreenState();
}

class _BuyerCartScreenState extends State<BuyerCartScreen> {
  List<Cart> cartList = <Cart>[];
  List<CardModel> cardList = <CardModel>[];
  late double screenHeight, screenWidth,containerHeight, containerWidth;
  late int axiscount = 2;
  double totalprice = 0.0;
  String password = '';

  @override
  void initState() {
    super.initState();
    loadcart();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    containerHeight = screenHeight *0.5;
    containerWidth = screenWidth *0.5;
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart",
        style: GoogleFonts.manrope(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          cartList.isEmpty
          ? const Center(
            child: Text("No item in your cart"),
          )
          : Expanded(child: ListView.builder(
            itemCount: cartList.length,
            itemBuilder: (context,index){
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      CachedNetworkImage(
                        width: screenWidth / 3,
                        fit: BoxFit.cover,
                        imageUrl:
                        "${MyConfig().SERVER}/barterlt/assets/item_list/${cartList[index].itemId}a.png",
                        placeholder: (context, url) => const LinearProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                        Flexible(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Text(
                                  cartList[index].itemName.toString(),
                                  style: GoogleFonts.manrope(fontSize: 17,fontWeight: FontWeight.bold),),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(onPressed: () {
                                                if (int.parse(cartList[index]
                                                        .cartQty
                                                        .toString()) <=
                                                    1) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(const SnackBar(
                                                          content: Text(
                                                              "Quantity cannot less than 1")));
                                                } else {
                                                  int newqty = int.parse(
                                                          cartList[index].cartQty.toString()) - 1;
                                                  double newprice =
                                                      double.parse(
                                                              cartList[index].itemPrice.toString()) * newqty;
                                                  updateCart(index, newqty, newprice); 
                                                                                                 }
                                                setState(() {});
                                              },
                                              icon: const Icon(Icons.remove)),
                                              Text(cartList[index].cartQty.toString()),
                                              IconButton(
                                            onPressed: () {
                                              if (int.parse(cartList[index].itemQty.toString()) >
                                                  int.parse(cartList[index].cartQty.toString())) {
                                                int newqty = int.parse(
                                                        cartList[index].cartQty.toString()) + 1;
                                                double newprice = double.parse(
                                                        cartList[index].itemPrice.toString()) * newqty;
                                                updateCart(index, newqty, newprice);
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            "Please check on the quantity available")));
                                              }
                                            },
                                            icon: const Icon(Icons.add),
                                          )
                                    ],
                                  ),
                                  Text(
                                    "RM ${double.parse(cartList[index].cartPrice.toString()).toStringAsFixed(2)}")
                              ],
                            ),),),
                            IconButton(
                              onPressed: (){
                                deleteDialog(index);
                                }, 
                              icon: const Icon(Icons.delete_rounded))
                    ],
                  ),
                  ),
              );
            })),
            Padding(
              padding: const EdgeInsets.all(8),
            child: SizedBox(
              height: 70,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Price ",
                  style: GoogleFonts.manrope(fontSize: 17,fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 5),
                  Text("RM ${totalprice.toStringAsFixed(2)}",
                  style: GoogleFonts.manrope(fontSize: 17),
                  ),
                  const SizedBox(width: 35),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                context, MaterialPageRoute(
                  builder: (content) => PaymentScreen(user: widget.user)));
                    }, 
                    child: const Text("Check Out"))
                ],
              ),
            ),)
        ],
      ),
    );
  }
  
  void loadcart() {
    http.post(Uri.parse("${MyConfig().SERVER}/barterlt/php/load_cart.php"),
    body: {
      "userid":widget.user.id,
    }).then((response) {
      print(response.body);
      cartList.clear();
      if(response.statusCode == 200){
        var jsondata = jsonDecode(response.body);
      if (jsondata['status'] == "success") {
          var extractdata = jsondata['data'];
          extractdata['carts'].forEach((v) {
            cartList.add(Cart.fromJson(v));
          });
          totalprice = 0.0;

          for (var element in cartList) {
            totalprice =
                totalprice + double.parse(element.cartPrice.toString());
          }
        } else {
          Navigator.of(context).pop();
        }
        setState(() {});
      }
    });
  }
  
  void updateCart(int index, int newqty, double newprice) {
    http.post(Uri.parse("${MyConfig().SERVER}/barterlt/php/update_cart.php"),
    body: {
      "cartid": cartList[index].cartId,
      "newqty": newqty.toString(),
      "newprice": newprice.toString(),
    }).then((response) {
      if(response.statusCode == 200){
        var jsondata = jsonDecode(response.body);
        if(jsondata['status'] == 'success'){
          loadcart();
        } else{}
      } else {}
    });
  }
  
  void deleteDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Text(
            "Delete this item?",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                deleteCart(index);
                //registerUser();
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  
  void deleteCart(int index) {
    http.post(Uri.parse("${MyConfig().SERVER}/barterlt/php/delete_cart.php"),
        body: {
          "cartid": cartList[index].cartId,
        }).then((response) {
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == 'success') {
          loadcart();
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Cart Successfully Deleted")));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Cart Failed to Delete")));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Cart Failed to Delete")));
      }
    });
  }
  
}