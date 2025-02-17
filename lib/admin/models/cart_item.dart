
class CartItemModel {
  static const ID = "id";
  static const NAME = "name";
  static const IMAGE = "image";
  static const PRODUCT_ID = "productId";
  static const QUANTITY = "quantity";
  static const PRICE = "price";
  static const RESTAURANT_ID = "restaurantId";
  static const TOTAL_RESTAURANT_SALES = "totalRestaurantSale";



  String _id;
  String _name;
  String _image;
  String _productId;
  String _restaurantId;
  String _numberCus;
  String _numberSubb;
  int _totalRestaurantSale;
  int _quantity;
  int _price;
  int _date;




  //  getters
  String get id => _id;

  String get name => _name;

  String get image => _image;

  String get productId => _productId;

  String get restaurantId => _restaurantId;

  String get numberCus => _numberCus;

  String get numberSubb => _numberSubb;

  int get price => _price;

  int get totalRestaurantSale => _totalRestaurantSale;

  int get quantity => _quantity;

  int get date => _date;



  CartItemModel.fromMap(Map data, int createdAt, String userId, String numberSub){
    _id = data[ID];
    _name =  data[NAME];
    _image =  data[IMAGE];
    _productId = data[PRODUCT_ID];
    _price = data[PRICE];
    _quantity = data[QUANTITY];
    _totalRestaurantSale = data[TOTAL_RESTAURANT_SALES];
    _restaurantId = data[RESTAURANT_ID];
    _date = createdAt;
    _numberCus = userId;
    _numberSubb = numberSub;
  }


  Map toMap() => {
    ID: _id,
    IMAGE: _image,
    NAME: _name,
    PRODUCT_ID: _productId,
    QUANTITY: _quantity,
    PRICE: _price,
    RESTAURANT_ID: _restaurantId,
    TOTAL_RESTAURANT_SALES: _totalRestaurantSale,
  };

}
