import 'dart:convert';
import 'dart:io';
import 'package:barterlt/models/item.dart';
import 'package:barterlt/models/user.dart';
import 'package:barterlt/myconfig.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class EditItemScreen extends StatefulWidget {
  final User user;
  final Item useritem;
  
  const EditItemScreen({super.key, required this.user, required this.useritem});

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  File? _image;
  var pathAsset = "assets/images/camera.jpeg";
  final _formKey = GlobalKey<FormState>();
  late double screenHeight, screenWidth, cardwitdh;
  final TextEditingController _itemnameEditingController = TextEditingController();
  final TextEditingController _itemdescEditingController = TextEditingController();
  final TextEditingController _itempriceEditingController = TextEditingController();
  final TextEditingController _itemqtyEditingController = TextEditingController();
  final TextEditingController _prstateEditingController = TextEditingController();
  final TextEditingController _prlocalEditingController = TextEditingController();
  String selectedType = "Others";
  List<String> itemList = [
    "Accessories",
    "Babies",
    "Book",
    "Clothing",    
    "Computer",
    "Cosmestic",
    "Electrical",    
    "Gaming",
    "Grocery",
    "Home & Living",
    "Shoe",    
    "Smart gadgets",
    "Sports",
    "Stationary",
    "Others",
  ];
  
  String curaddress = "";
  String curstate = "";
  String prlat = "";
  String prlong = "";

  @override
  void initState() {
    super.initState();
    _itemnameEditingController.text = widget.useritem.itemName.toString();
    _itemdescEditingController.text = widget.useritem.itemDesc.toString();
    _itempriceEditingController.text =
        double.parse(widget.useritem.itemPrice.toString()).toStringAsFixed(2);
    _itemqtyEditingController.text = widget.useritem.itemQty.toString();
    _prstateEditingController.text = widget.useritem.userState.toString();
    _prlocalEditingController.text = widget.useritem.userLocality.toString();
    selectedType = widget.useritem.itemType.toString();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Catch",
        style: GoogleFonts.manrope(fontWeight: FontWeight.bold)),
      ),
      body: Column
      (children: [
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
            ),)),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                            Row(
                              children: [
                                const Icon(Icons.category_outlined),
                            const SizedBox(
                              width: 16,
                            ),
                            SizedBox(
                              height: 50,
                              child: DropdownButton(
                                value: selectedType,
                                onChanged: (newValue){
                                  setState(() {
                                    selectedType = newValue!;
                                    print(selectedType);
                                  });
                                },
                                items: itemList.map((selectedType){
                                  return DropdownMenuItem(
                                    value: selectedType,
                                    child: Text(selectedType),);
                                } ).toList()),
                            ),
                            ],
                            ),
                            const SizedBox(
                                height: 10,
                                ),
                             TextFormField(
                                textInputAction: TextInputAction.next,
                                validator: (val) =>
                                val!.isEmpty || (val.length <3)
                                ?"Item name must be longer than 3"
                                :null,
                                onFieldSubmitted: (v){},
                                controller: _itemnameEditingController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: 'Item Name',
                                  labelStyle: const TextStyle(),
                                  border:OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(29)),
                                  filled: true,
                                  fillColor: const Color.fromRGBO(255, 230, 143, 50),
                                  icon: const Icon(Icons.abc),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(29)
                                  )
                                  )
                                ),
                                const SizedBox(
                                height: 10,
                                ),
                                TextFormField(
                          textInputAction: TextInputAction.next,
                          validator: (val) =>
                                val!.isEmpty 
                                ?"Item desciption must be longer than 10"
                                :null,
                                onFieldSubmitted: (v){},
                                maxLines: 4,
                                controller: _itemdescEditingController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: 'Item Description',
                                  alignLabelWithHint: true,
                                  labelStyle: const TextStyle(),
                                   border:OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20)),
                                  filled: true,
                                  fillColor: const Color.fromRGBO(255, 230, 143, 50),
                                  icon: const Icon(Icons.description),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20)
                                  )
                                ),
                        ),
                        const SizedBox(
                                height: 10,
                                ),
                        TextFormField(
                                textInputAction: TextInputAction.next,
                                validator: (val) =>
                                val!.isEmpty 
                                ?"Item price must contain value"
                                :null,
                                onFieldSubmitted: (v){},
                                controller: _itempriceEditingController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: 'Item Price',
                                  labelStyle: const TextStyle(),
                                   border:OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20)),
                                  filled: true,
                                  fillColor: const Color.fromRGBO(255, 230, 143, 50),
                                  icon: const Icon(Icons.price_check_outlined),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20)
                                  )
                                ),
                              ),
                               const SizedBox(
                                height: 10,
                                ),
                              TextFormField(
                                textInputAction: TextInputAction.next,
                                validator: (val) =>
                                val!.isEmpty 
                                ?"Quantity should be more than 0"
                                :null,
                                controller: _itemqtyEditingController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: 'Item Quantity',
                                  labelStyle: const TextStyle(),
                                  border:OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20)),
                                  filled: true,
                                  fillColor: const Color.fromRGBO(255, 230, 143, 50),
                                  icon: const Icon(Icons.numbers),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20)
                                  )
                                )
                                ),
                                const SizedBox(
                                height: 10,
                                ),
                          Row(children: [
                            Flexible(
                              flex: 5,
                              child: TextFormField(
                              textInputAction: TextInputAction.next,
                              validator: (val) => val!.isEmpty || (val.length < 3)
                                ? "Current State"
                                : null,
                              enabled: false,
                              controller: _prstateEditingController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: 'Current State',
                                labelStyle: const TextStyle(),
                                border:OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20)),
                                  filled: true,
                                  fillColor: const Color.fromRGBO(255, 230, 143, 50),
                                icon: const Icon(Icons.flag_rounded),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20)
                                  )
                                  )
                                  ),
                          ),
                            const SizedBox(
                                width: 15,
                                ),
                      Flexible(
                        flex: 5,
                        child: TextFormField(
                            textInputAction: TextInputAction.next,
                            enabled: false,
                            validator: (val) => val!.isEmpty || (val.length < 3)
                                ? "Current Locality"
                                : null,
                            controller: _prlocalEditingController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: 'Current Locality',
                                labelStyle: const TextStyle(),
                                border:OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20)),
                                  filled: true,
                                  fillColor: const Color.fromRGBO(255, 230, 143, 50),
                                icon: const Icon(Icons.location_on_sharp),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(20)
                                ))),
                      ),
                    ]),     
                         const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          width: screenWidth / 1.2,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: (){
                              updateDialog();
                            }, 
                            child: const Text("Update Item")),
                        ),
                    ],
                    ),
                  ),
                ),))
      ]),
    );
  }
  
  void updateDialog() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Check your input")));
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Text(
            "Update your item?",
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
                updateItem();
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
  
  void updateItem() {
    String itemname = _itemnameEditingController.text;
    String itemdesc = _itemdescEditingController.text;
    String itemprice = _itempriceEditingController.text;
    String itemqty = _itemqtyEditingController.text;
  
    http.post(Uri.parse("${MyConfig().SERVER}/barterlt/php/update_item.php"),
    body: {
      "itemid":widget.useritem.userId,
      "itemname":itemname,
      "itemdesc":itemdesc,
      "itemprice":itemprice,
      "itemqty":itemqty,
      "type": selectedType,
    }).then((response) {
      print(response.body);
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == 'success') {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Update Success")));
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Update Failed")));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Update Failed")));
        Navigator.pop(context);
      }
    });
  }
}