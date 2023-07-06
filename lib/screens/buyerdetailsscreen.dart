import 'package:barterlt/models/item.dart';
import 'package:barterlt/models/user.dart';
import 'package:barterlt/myconfig.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class BuyerDetailsScreen extends StatefulWidget {
  final Item useritem;
  final User user;
  const BuyerDetailsScreen({super.key, required this.useritem, required this.user});

  @override
  State<BuyerDetailsScreen> createState() => _BuyerDetailsScreenState();
}

class _BuyerDetailsScreenState extends State<BuyerDetailsScreen> {
  int qty = 0;
  int userqty = 1;
  double totalprice = 0.0;
  double singleprice = 0.0;
  
   @override
  void initState() {
    super.initState();
    qty = int.parse(widget.useritem.itemQty.toString());
    totalprice = double.parse(widget.useritem.itemPrice.toString());
    singleprice = double.parse(widget.useritem.itemPrice.toString());
  }

  final df = DateFormat('dd-MM-yyyy hh:mm a');
  late double screenHeight, screenWidth, cardwitdh;
  
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text(
        "Item Details",
      style: GoogleFonts.manrope(fontWeight: FontWeight.bold),)),
      body: Column(
        children: [
          Flexible(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
              child: Card(
                child: PageView(
                  controller: PageController(viewportFraction: 0.7),
                  children: [
                    Padding(
                     padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: SizedBox(
                    width: screenWidth,
                    child: CachedNetworkImage(
                      width: screenWidth*1,
                      fit: BoxFit.cover,
                      imageUrl: "${MyConfig().SERVER}/barterlt/assets/item_list/${widget.useritem.itemId}a.png",
                      placeholder: (context, url) =>
                          const LinearProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: SizedBox(
                    width: screenWidth,
                    child: CachedNetworkImage(
                      width: screenWidth*1,
                      fit: BoxFit.cover,
                      imageUrl: "${MyConfig().SERVER}/barterlt/assets/item_list/${widget.useritem.itemId}b.png",
                      placeholder: (context, url) =>
                          const LinearProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: SizedBox(
                    width: screenWidth,
                    child: CachedNetworkImage(
                      width: screenWidth*1,
                      fit: BoxFit.cover,
                      imageUrl: "${MyConfig().SERVER}/barterlt/assets/item_list/${widget.useritem.itemId}c.png",
                      placeholder: (context, url) =>
                          const LinearProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                          ),
                  ),
                ),
                  ],
                ),
              ),
              )),
              Container(
                padding: const EdgeInsets.all(8),
                child: Text(widget.useritem.itemName.toString(),
                style: GoogleFonts.manrope(
                  fontSize: 24, fontWeight: FontWeight.bold,color: const Color.fromRGBO(63, 35, 5, 1),
                  ),
              ),),
              Expanded(
                flex: 6,
                child: SingleChildScrollView(
                  child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: Column(
                    children: [
                      Table(
                        columnWidths: const{
                          0: FlexColumnWidth(4),
                          1: FlexColumnWidth(6),
                        },
                        children: [
                          TableRow(
                            children: [
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Description",
                                  style: GoogleFonts.manrope(fontWeight: FontWeight.bold, fontSize: 17,color: const Color.fromRGBO(63, 35, 5, 1)),
                                  ),
                                )),
                                TableCell(
                                  verticalAlignment: TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(widget.useritem.itemDesc.toString(),
                                      style: GoogleFonts.barlow(fontSize: 15),
                                    )),
                                  ),)
                            ]
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Quantity Available",
                                  style: GoogleFonts.manrope(fontWeight: FontWeight.bold,fontSize: 17,color: const Color.fromRGBO(63, 35, 5, 1)),
                                  ),
                                )),
                                TableCell(
                                  verticalAlignment: TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(widget.useritem.itemQty.toString(),
                                      style: GoogleFonts.barlow(fontSize: 15),
                                    )),
                                  ),)
                            ]
                          ),
                          TableRow(
                            children: [
                              TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Price",
                                  style: GoogleFonts.manrope(fontWeight: FontWeight.bold,fontSize: 17,color: const Color.fromRGBO(63, 35, 5, 1)),
                                  ),
                                ),),
                              TableCell(
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "RM ${double.parse(widget.useritem.itemPrice.toString()).toStringAsFixed(2)}",
                                      style: GoogleFonts.barlow(fontSize: 15),
                                      ),
                                  ),),
                              )
                            ]),
                          TableRow(children: [
                             TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Location",
                                style: GoogleFonts.manrope(fontWeight: FontWeight.bold,fontSize: 17,color: const Color.fromRGBO(63, 35, 5, 1)),
                                ),
                              ),
                            ),
                            TableCell(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${widget.useritem.userLocality}/${widget.useritem.userState}",
                                  style: GoogleFonts.barlow(fontSize: 15),
                                  ),
                              ),),
                            )
                          ]),
                        TableRow(children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Insert Date",
                              style: GoogleFonts.manrope(fontWeight: FontWeight.bold,fontSize: 17,color: const Color.fromRGBO(63, 35, 5, 1)),
                              ),
                            ),
                        ),
                        TableCell(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                              df.format(DateTime.parse(
                                  widget.useritem.insertDate.toString())),
                                  style: GoogleFonts.barlow(fontSize: 15),
                              ),
                            ),),
                        )
                      ]),
                        ],
                      ),
                   
              Container(
          padding: const EdgeInsets.all(3),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            IconButton(
                onPressed: () {
                  if (userqty <= 1) {
                    userqty = 1;
                    totalprice = singleprice * userqty;
                  } else {
                    userqty = userqty - 1;
                    totalprice = singleprice * userqty;
                  }
                  setState(() {});
                },
                icon: const Icon(Icons.remove,color: Color.fromARGB(100, 117, 88, 0),)),
            Text(
              userqty.toString(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Color.fromRGBO(117, 88, 0, 1),),
            ),
            IconButton(
                onPressed: () {
                  if (userqty >= qty) {
                    userqty = qty;
                    totalprice = singleprice * userqty;
                    ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text("Please check the quantity available!")));
                  } else {
                    userqty = userqty + 1;
                    totalprice = singleprice * userqty;
                  }
                  setState(() {});
                },
                icon: const Icon(Icons.add,color: Color.fromARGB(100, 117, 88, 0),)),
          ]),
        ),
        Text(
          "RM ${totalprice.toStringAsFixed(2)}",
          style: GoogleFonts.manrope(fontSize: 20, fontWeight: FontWeight.bold,color: const Color.fromRGBO(63, 35, 5, 1),),
        ),
        ElevatedButton(
            onPressed: () {
              addtocartdialog();
            },
            child: const Text("Add to Cart")),
            ],
          ),
          ), )),
        ],
      ),
    );
  }
  
  void addtocartdialog() {}
}