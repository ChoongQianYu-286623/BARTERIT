import 'dart:convert';
import 'dart:io';
import 'package:barterlt/models/user.dart';
import 'package:barterlt/myconfig.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class AddItemScreen extends StatefulWidget {
  final User user;
  const AddItemScreen({super.key, required this.user});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  List<File> selectedImages = [];
  List<XFile>? images = [];
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
    "Shoe",    
    "Smart gadgets",
    "Sports",
    "Stationary",
    "Others",
  ];
  
  late Position _currentPosition;
  String curaddress = "";
  String curstate = "";
  String prlat = "";
  String prlong = "";


  @override
  void initState() {
    super.initState();
    _determinePosition();
  }
 
 @override
  Widget build(BuildContext context) {
     screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return  Scaffold(
      appBar: AppBar(title: const Text("Insert New Item"),actions: [
        IconButton(
            onPressed: () {
              _determinePosition();
            },
            icon: const Icon(Icons.refresh))
      ]),
      body: Column(
        children: [
           Flexible(
            flex: 4,
            // height: screenHeight / 2.5,
            // width: screenWidth,
            child: GestureDetector(
              onTap: () {
                _showSelectionDialog(context);
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                child: Card(
                  child: SizedBox(
                    width: screenWidth,
                    child: selectedImages.isEmpty
                    ? Image.asset(pathAsset,
                    fit: BoxFit.contain,)
                    : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: selectedImages.length,
                      itemBuilder: (context, index){
                        return Image.file(selectedImages[index]);
                      },
                    )
                    // decoration: BoxDecoration(
                    //   image: DecorationImage(
                    //     image: _image == null
                    //     ? AssetImage(pathAsset)
                    //     : FileImage(_image!) as ImageProvider,
                    //     fit: BoxFit.contain),
                    // ),
                  ),
                ),
              ),
            )),
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
                              insertDialog();
                            }, 
                            child: const Text("Insert New Item")),
                        ),
                    ],
                    ),
                  ),
                ),))
        ],),
    );
  }

  Future<void>_showSelectionDialog(BuildContext context){
    return showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20))),
          title: const Text("From where do you want to take the photo?"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                IconButton(
                  onPressed: _selectFromCamera, 
                  icon: const Icon(Icons.add_a_photo)),
                  const Text("Camera"),
                
                const SizedBox(
                  height: 10,
                ),
                IconButton(
                  onPressed: _selectFromGallery, 
                  icon: const Icon(Icons.add_photo_alternate)),
                  const Text("Gallery"),
              ],
            ),
          ),
        );
      }
      );
  }

  Future<void> _selectFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera, //gallery
      maxHeight: 1200,
      maxWidth: 800,
    );

    List<XFile> xFilePick = pickedFile as List<XFile>; //
    setState(() {
    if(xFilePick.isNotEmpty){
      for(var i = 0; i < xFilePick.length; i++){
        selectedImages.add(File(xFilePick[i].path));
      //cropImage();
      }
    }else {
    print('No image selected.');
  }
  });
    Navigator.of(context).pop();
  }

  Future<void> _selectFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickMultiImage(
      maxHeight: 1200,
      maxWidth: 800,
    );
    List<XFile> xfilePick = pickedFile;
    setState(() {
      if (xfilePick.isNotEmpty) {
        for (var i = 0; i < xfilePick.length; i++) {
          selectedImages.add(File(xfilePick[i].path));
        }
      } else {
        print('No image selected.');
      }
    });

    List<File>? croppedImages = await cropImages(selectedImages);
    if (croppedImages != null) {
      setState(() {
        selectedImages = croppedImages;
      });
    }
  }

  Future<List<File>?> cropImages(List<File> images) async {
    List<File> croppedImages = [];

    for (var image in images) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9,
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.ratio3x2,
              lockAspectRatio: true),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );

      if (croppedFile != null) {
        croppedImages.add(File(croppedFile.path));
      }
    }

    return croppedImages.isNotEmpty ? croppedImages:null;
}

  void insertDialog() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Please fill in all the input")));
      return;
    }
    if (selectedImages.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Please take picture")));
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: const Text(
            "Insert new item?",
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
                insertItem();
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

    void insertItem() async {
      String itemname = _itemnameEditingController.text;
      String itemdesc = _itemdescEditingController.text;
      String itemprice = _itempriceEditingController.text;
      String itemqty = _itemqtyEditingController.text;
      String state = _prstateEditingController.text;
      String locality = _prlocalEditingController.text;
     List<String> base64Images = [];
      for (var image in selectedImages) {
      List<int> imageBytes = await image.readAsBytes();
      print(base64Images.length);
      String base64Image = base64Encode(imageBytes);
      base64Images.add(base64Image);
    }

      http.post(Uri.parse("${MyConfig().SERVER}/barterlt/php/insert_item.php"),
       body: {
        "userid":widget.user.id.toString(),
        "itemname": itemname,
        "itemdesc": itemdesc,
        "itemprice": itemprice,
        "itemqty": itemqty,
        "itemtype": selectedType,
        "latitude": prlat,
        "longitude": prlong,
        "state": state,
        "locality": locality,
        "images": jsonEncode(base64Images),
       }).then((response){
        print(response.body);
        if (response.statusCode == 200){
          var jsondata = jsonDecode(response.body);
          if (jsondata['status'] == 'success'){
            ScaffoldMessenger.of(context).showSnackBar(
             const SnackBar(content: Text("Insert Success")));
          }else{
            ScaffoldMessenger.of(context).showSnackBar(
             const SnackBar(content: Text("Insert Failed")));
          }
          // Navigator.pop(context);
        } else{
          ScaffoldMessenger.of(context).showSnackBar(
             const SnackBar(content: Text("Insert Failed")));
          // Navigator.pop(context);
        }
       });
    }
  
  void _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }
    _currentPosition = await Geolocator.getCurrentPosition();

    _getAddress(_currentPosition);
    //return await Geolocator.getCurrentPosition();
  }
  
   _getAddress(Position pos) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(pos.latitude, pos.longitude);
    if (placemarks.isEmpty) {
      _prlocalEditingController.text = "Sri Petaling";
      _prstateEditingController.text = "Kuala Lumpur";
      prlat = "3.1385026606702393"; //3.1385026606702393, 101.6911047183765
      prlong = "101.6911047183765";
    } else {
      _prlocalEditingController.text = placemarks[0].locality.toString();
      _prstateEditingController.text =
          placemarks[0].administrativeArea.toString();
      prlat = _currentPosition.latitude.toString();
      prlong = _currentPosition.longitude.toString();
    }
    setState(() {});
   }
}
