
class UserModel{
  final String ?id;

  final String Name;
  final String Email;
  final String Password;
  final String Phone;

const  UserModel(
     {this.id,
 required this.Name,  required  this.Email, required  this.Password, required  this.Phone});
 toJason(){
return {
  "Name": Name,
  "Email" : Email,
  "Phone": Phone,
  "Password": Password,
};
 }
}