import 'dart:convert';
import 'package:barterlt/models/item.dart';
import 'package:barterlt/models/user.dart';
import 'package:barterlt/myconfig.dart';
import 'package:barterlt/screens/additemscreen.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;


class SellerTabScreen extends StatefulWidget {
  final User user;
  const SellerTabScreen({super.key, required this.user});

  @override
  State<SellerTabScreen> createState() => _SellerTabScreenState();
}

class _SellerTabScreenState extends State<SellerTabScreen> {
  late double screenHeight, screenWidth;
  late int axiscount = 2;
  late List<Widget> tabchildren;
   List<Item> itemList = <Item>[];
  
   @override
  void initState() {
    super.initState();
    loadsellerItems();
    print("Seller");
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      axiscount = 3;
    } else {
      axiscount = 2;
    }
    return Scaffold(
      body: RefreshIndicator(
         onRefresh: ()async{
          loadsellerItems();
        },
      child: itemList.isEmpty
          ? const Center(
              child: Text("No Data"),
            )
          : Column(children: [
              Expanded(
                  child: GridView.count(
                      crossAxisCount: axiscount,
                      children: List.generate(
                        itemList.length,
                        (index) {
                          return Card(
                            child: InkWell(
                              onLongPress: () {
                                //onDeleteDialog(index);
                              },
                              onTap: ()  {
              
                                //loadsellerItems();
                              },
                              child: Column(children: [
                                CachedNetworkImage(
                                  width: screenWidth,
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      "${MyConfig().SERVER}/barterlt/assets/item_list/${itemList[index].itemId}.png",
                                  placeholder: (context, url) =>
                                      const LinearProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                                Text(
                                  itemList[index].itemName.toString(),
                                  style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                ),
                                // Text(
                                //   "RM ${double.parse(itemList[index].itemPrice.toString()).toStringAsFixed(2)}",
                                //   style: const TextStyle(fontSize: 14),
                                // ),
                                // Text(
                                //   "${itemList[index].itemQty} available",
                                //   style: const TextStyle(fontSize: 14),
                                //),
                              ]),
                            ),
                          );
                        },
                      )))
            ]),
       ),
       floatingActionButton: 
      FloatingActionButton(
        onPressed: () async {
          if(widget.user.id !="na"){
            await Navigator.push(
              context, MaterialPageRoute(builder: (content) => AddItemScreen(user: widget.user,)));
          
          } else{
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please login/register an account")));
          }
        },
        child: const Text("+",
        style: TextStyle(fontSize: 27),),
        ),
   
    );
  }
  
  void loadsellerItems() {
     if (widget.user.id == "na") {
      setState(() {
      });
      return;
    }
    http.post(Uri.parse("${MyConfig().SERVER}/barterlt/php/load_item.php"),
        body: {
          "userid": widget.user.id})
          .then((response) {
            //print(response.body);
      //log(response.body);
      itemList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          var extractdata = jsondata['data'];
          extractdata['item'].forEach((v) {
            itemList.add(Item.fromJson(v));
          });
          print(itemList[0].itemName);
        }
        setState(() {});
      }
    });
  }
  }
  
  void onDeleteDialog(int index) {

  }
