import 'dart:math';

class UserModel{
  late String id;
  late String email;
  late String firstName;
  late String lastName;
  late String mobile;

  String get fullName{
    return "$firstName $lastName";
  }

  UserModel.fromJson(Map<String, dynamic> jsonData){
    id = jsonData["_id"];
    email = jsonData["email"];
    firstName = jsonData["firstName"];
    lastName = jsonData["lastName"];
    mobile = jsonData["mobile"];
  }

  Map<String, dynamic> toJson(){
    return {
      "_id" : id,
      "email" : email,
      "firstName" : firstName,
      "lastName" :lastName,
      "mobile" : mobile,
    };
  }





  // "_id": "672ddc84ea7d73dfecf4e384",
  // "email": "email@gmail.com",
  // "firstName": "Shajibul Hasan",
  // "lastName": "Soaib",
  // "mobile": "01716874981",
  // "createdDate": "2024-11-01T12:20:25.401Z",
  // "photo": ""
}