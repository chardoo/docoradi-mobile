/*
{
  email: "",
  firstName: "",
  lastName: "",
  telephone: "",
  password: "",
  
}
*/

class Registration {
  String email = "";
  String firstName = "";
  String lastName = "";
  String telephone = "";
  String password = "";

  Registration(
      this.email, this.firstName, this.lastName, this.telephone, this.password);

  Registration.empty() {
    email = "";
    firstName = "";
    lastName = "";
    telephone = "";
    password = "";
  }

  //deserialization
  factory Registration.fromJson(Map<String, dynamic> json) {
    return Registration(
      json["email"] as String,
      json["firstName"] as String,
      json["lastName"] as String,
      json["telephone"] as String,
      json["password"] as String,
    );
  }

  //serialization
  Map<String, dynamic> toJson() {
    var map = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "telephone": telephone,
      "password": password,
    };
    return map;
  }

  @override
  String toString() {
    return "SignupPaypal = [ email: $email, firstName: $firstName, lastName: $lastName, totalAmount: $telephone "
        "amountPerDoor: $password]";
  }
}
