class PlaceDetail{

  String placeName;
  String hotelName;
  String totPrice;
  String description;
  String longDesc;

  PlaceDetail(this.placeName, this.hotelName, this.totPrice, this.description, this.longDesc);
}


List<PlaceDetail> placeDetails = [

PlaceDetail(
'Canteen Food Ordering and Management System',
'Cyber Infrastructure Inc.',
'Web Development',
'automate the existing manual system with \nthe help of advance computerized software',
"The main objective of online food ordering system is to automate the existing manual system with the help of advance computerized software so, that valuable data can be stored for longer period with easy accessing and manipulation of the same.The registered user can access the account with valid credentials. User can surf the food items according to categories, Cart and online payment options are available to user. User can track their orders with the food details.In Online Food Ordering System Admin can handle the functionalities like add new food items, edit/delete food items, Enable/Disable the food items according to season and availability. Admin have authority to view order details and update the delivery status of food. The payment transaction and user details are also viewable to admin."
),
];