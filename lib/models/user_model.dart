class UserModel
{
   String? uid;
  final String name;
  final String email;
  final String? image;

  UserModel( {this.image, this.uid, required this.name, required this.email});

  Map<String,String?> toMap()
  {
    return {
      'uid':uid,
      'emailaddress':email,
      'image':image,
      'name':name,
    };
  }
   
}