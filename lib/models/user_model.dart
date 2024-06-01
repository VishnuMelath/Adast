class UserModel
{
  final String name;
  final String email;
  final String? image;

  UserModel( {this.image,  required this.name, required this.email});

  Map<String,String?> toMap()
  {
    return {
      'emailaddress':email,
      'image':image,
      'name':name,
    };
  }
   
}