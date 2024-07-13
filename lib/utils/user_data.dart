String? email;
String? name;
String? rollNo;
String? phoneNo;
String? room;
String? branch;
String? image;

void setUserInfo(Map<String, dynamic> decodedToken){
    email = decodedToken['email'];
    name = decodedToken['name'];
    rollNo = decodedToken['rollNo'];
    phoneNo = decodedToken['phoneNo'];
    room = decodedToken['room'];
    branch = decodedToken['branch'];
    image = decodedToken['image'];
}