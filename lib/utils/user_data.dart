String? email;
String? name;
String? rollNo;
String? phoneNo;
String? room;
String? branch;
String? image;
dynamic token;

void setUserInfo(Map<String, dynamic> decodedToken, dynamic mytoken) {
  email = decodedToken['email'];
  name = decodedToken['name'];
  rollNo = decodedToken['rollNo'];
  phoneNo = decodedToken['phoneNo'];
  room = decodedToken['room'];
  branch = decodedToken['branch'];
  image = decodedToken['image'];
  token = mytoken;
}
