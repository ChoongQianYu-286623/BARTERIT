import 'dart:convert';

import 'package:barterlt/models/order.dart';
import 'package:barterlt/models/user.dart';
import 'package:barterlt/myconfig.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class SellerOrderScreen extends StatefulWidget {
  final User user;
  const SellerOrderScreen({super.key, required this.user});

  @override
  State<SellerOrderScreen> createState() => _SellerOrderScreenState();
}

class _SellerOrderScreenState extends State<SellerOrderScreen> {
  String status = "Loading...";
  List<Order> orderList = <Order>[];
  late double screenHeight, screenWidth, cardwitdh;

  @override
  void initState() {
    super.initState();
    loadsellerorders();
  }

  @override
  Widget build(BuildContext context) {
     screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text("Your Order/s",
      style: GoogleFonts.manrope(fontWeight: FontWeight.bold)
      )),
      body: 
        Column(
                  children: [
                    SizedBox(
                      width: screenWidth,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                        child: Row(
                          children: [
                            Flexible(
                                flex: 7,
                                child: Row(
                                  children: [
                                    Text("Hello, ",
                                    style: GoogleFonts.manrope(fontSize: 18)),
                                    Text(
                                      "${widget.user.name}!",
                                      style: GoogleFonts.manrope(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )),
                            
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Your Current Order/s (${orderList.length})",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: const Icon(Icons.menu),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: orderList.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () async {
                                  Order myorder =
                                      Order.fromJson(orderList[index].toJson());
                                  // await Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (content) =>
                                  //             SellerOrderDetailsScreen(
                                  //               order: myorder,
                                  //             )));
                                  loadsellerorders();
                                },
                                leading: CircleAvatar(
                                    child: Text((index + 1).toString())),
                                title: Text(
                                    "Receipt: ${orderList[index].orderBill}"),
                                trailing: const Icon(Icons.arrow_forward),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "Order ID: ${orderList[index].orderId}"),
                                          const Text(
                                              "Status: Paid")
                                        ]),
                                    Column(
                                      children: [
                                        Text(
                                          "RM ${double.parse(orderList[index].orderPaid.toString()).toStringAsFixed(2)}",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const Text("")
                                      ],
                                    )
                                  ],
                                ),
                              );
                            })),
                  ],
                ),
     
    );
  }
  
  void loadsellerorders() {
    http.post(
        Uri.parse("${MyConfig().SERVER}/barterlt/php/load_seller_order.php"),
        body: {
          "sellerid": widget.user.id
          }).then((response) {
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          orderList.clear();
          var extractdata = jsondata['data'];
          extractdata['orders'].forEach((v) {
            orderList.add(Order.fromJson(v));
          });
        } else {
          Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No order Available")));
          // status = "Please register an account first";
          // setState(() {});
        }
        setState(() {});
      }
    });
  }
}