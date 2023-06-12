class Item {
  String? itemId;
  String? userId;
  String? itemName;
  String? itemType;
  String? itemDesc;
  String? itemPrice;
  String? itemQty;
  String? userLat;
  String? userLong;
  String? userState;
  String? userLocality;
  String? insertDate;

  Item(
      {this.itemId,
      this.userId,
      this.itemName,
      this.itemType,
      this.itemDesc,
      this.itemPrice,
      this.itemQty,
      this.userLat,
      this.userLong,
      this.userState,
      this.userLocality,
      this.insertDate});

  Item.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    userId = json['user_id'];
    itemName = json['item_name'];
    itemType = json['item_type'];
    itemDesc = json['item_desc'];
    itemPrice = json['item_price'];
    itemQty = json['item_qty'];
    userLat = json['user_lat'];
    userLong = json['user_long'];
    userState = json['user_state'];
    userLocality = json['user_locality'];
    insertDate = json['insert_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_id'] = itemId;
    data['user_id'] = userId;
    data['item_name'] = itemName;
    data['item_type'] = itemType;
    data['item_desc'] = itemDesc;
    data['item_price'] = itemPrice;
    data['item_qty'] = itemQty;
    data['user_lat'] = userLat;
    data['user_long'] = userLong;
    data['user_state'] = userState;
    data['user_locality'] = userLocality;
    data['insert_date'] = insertDate;
    return data;
  }
}
