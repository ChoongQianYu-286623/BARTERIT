import 'dart:convert';
import 'package:barterlt/buyer/buyercartscreen.dart';
import 'package:barterlt/buyer/receiptscreen.dart';
import 'package:barterlt/models/cart.dart';
import 'package:barterlt/models/item.dart';
import 'package:barterlt/models/user.dart';
import 'package:barterlt/myconfig.dart';
import 'package:barterlt/buyer/buyerdetailsscreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class BuyerTabScreen extends StatefulWidget {
  final User user;
  const BuyerTabScreen({super.key, required this.user});

  @override
  State<BuyerTabScreen> createState() => _BuyerTabScreenState();
}

class _BuyerTabScreenState extends State<BuyerTabScreen> {
  List<Cart> cartList = <Cart>[];
  String maintitle = "Buyer";
  List<Item> itemList = <Item>[];
  late double screenHeight, screenWidth;
  late int axiscount = 2;
  int numofpage = 1, curpage = 1;
  int numberofresult = 0;
  var color;
  int cartqty = 0;


  TextEditingController searchController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    loadItem(1);
    print("Buyer");
  }

   @override
  void dispose() {
    super.dispose();
    print("dispose");
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
      appBar:  AppBar(
        title: Text(maintitle,
        style: GoogleFonts.manrope(fontWeight: FontWeight.bold)),
        actions: [IconButton(onPressed: (){
          showSearchDialog();
        }, 
        icon: const Icon(Icons.search)),
        
        // TextButton.icon(
        //   icon: const Icon(Icons.shopping_basket_outlined), 
        //   label: Text(cartList.length.toString()),
        //   onPressed: () async {
        //     if(cartList.isNotEmpty){
        //       await Navigator.push(
        //         context, MaterialPageRoute(
        //           builder: (content) => BuyerCartScreen(user: widget.user)));
        //     loadItem(1);
        //     } else{
        //       ScaffoldMessenger.of(context).showSnackBar(
        //         const SnackBar(content: Text("No item in cart"))
        //       );
        //     }
        //   }, )
          
          IconButton(
            onPressed: ()  {
              Navigator.push(
                context, MaterialPageRoute(
                  builder: (content) => BuyerCartScreen(user: widget.user)));
            }, 
            icon: const Icon(Icons.shopping_bag_outlined)),
            PopupMenuButton(
              // add icon, by default "3 dot" icon
              // icon: Icon(Icons.book)
              itemBuilder: (context) {
            return [
              const PopupMenuItem<int>(
                value: 0,
                child: Text("My Order"),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text("New"),
              ),
            ];
          }, onSelected: (value) async {
            if (value == 0) {
              if (widget.user.id.toString() == "na") {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Please login/register an account")));
                return;
              }
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (content) => ReceiptScreen(
                            user: widget.user,
                          )));
            } else if (value == 1) {
            } else if (value == 2) {}
          }),
          ],
        ),
        body: itemList.isEmpty
        ? const Center(
          child: Text("No Data"),
        )
        :Column(children: [
              Expanded(
                  child: GridView.count(
                    childAspectRatio: (1/1.2),
                      crossAxisCount: axiscount,
                      children: List.generate(
                        itemList.length,
                        (index) {
                          return Card(
                            child: InkWell(
                              onTap: () async {
                                Item useritem=
                                    Item.fromJson(itemList[index].toJson());
                                if(widget.user.id.toString() == 'na'){
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text("Please login/register an account")));
                                return;
                                }else{
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (content) =>
                                            BuyerDetailsScreen(
                                              user: widget.user,
                                              useritem: useritem,
                                            )));
                                }
                                loadItem(1);
                              },
                              child: Column(children: [
                                CachedNetworkImage(
                                  width: screenWidth,
                                  height: screenHeight*0.2,
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      "${MyConfig().SERVER}/barterlt/assets/item_list/${itemList[index].itemId}a.png",
                                  placeholder: (context, url) =>
                                      const LinearProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  itemList[index].itemName.toString(),
                                  style: GoogleFonts.manrope(fontSize: 17,fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "RM ${double.parse(itemList[index].itemPrice.toString()).toStringAsFixed(2)}",
                                  style: const TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "${itemList[index].itemQty} available",
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ]),
                            ),
                          );
                        },
                      ))),
              SizedBox(
                height: 30,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: numofpage,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if ((curpage - 1) == index) {
                      color = Colors.amber;
                    } else {
                      color = Colors.black26;
                    }
                    return TextButton(
                        onPressed: () {
                          curpage = index + 1;
                          loadItem(index + 1);
                        },
                        child: Text(
                          (index + 1).toString(),
                          style: TextStyle(color: color, fontSize: 15),
                        ));
                  },
                ),
              ),
            ]),
    );
  }

  void loadItem(int pg) {
    http.post(Uri.parse("${MyConfig().SERVER}/barterlt/php/load_item.php"),
        body: {
          "pageno":pg.toString()
          }).then((response) {
      print(response.body);
      itemList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          numofpage = int.parse(jsondata['numofpage']); 
          numberofresult = int.parse(jsondata['numberofresult']);
          print(numberofresult);
          var extractdata = jsondata['data'];
          // cartqty = int.parse(jsondata['cartqty'].toString());
          extractdata['item'].forEach((v) {
            itemList.add(Item.fromJson(v));
          });
          print(itemList[0].itemName);
        }
        setState(() {});
      }
    });
  }

  void showSearchDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Text(
            "Search?",
            style: TextStyle(fontSize: 20),
          ),
          content: Column( mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 30,
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                    labelText: 'Search',
                    labelStyle: TextStyle(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.5),
                    ))),),
            const SizedBox(
              height: 2,
           ),
            SizedBox(
              height: 25,
              child: ElevatedButton(
                  onPressed: () {
                    String search = searchController.text;
                    searchItem(search);
                    Navigator.of(context).pop();
                  },
                  child: const Text("Search")),
            ) 
          ]),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Close",
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

  void searchItem(String search) {
    http.post(Uri.parse("${MyConfig().SERVER}/barterlt/php/load_item.php"),
    body: {
          "search": search
        }).then((response) {
      print(response.body);
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