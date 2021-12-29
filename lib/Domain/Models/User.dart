class AppUser {
  String name, email;
  int phoneNumber;
  AppUser(this.name, this.email,this.phoneNumber);

  Map<String, dynamic> get personalData => {"Name": this.name, "Email": this.email , "Phone":this.phoneNumber};
}
