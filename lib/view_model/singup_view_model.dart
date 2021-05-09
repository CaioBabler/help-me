class SingupViewModel {
  String email;
  String name;
  String password;

  Map<String, dynamic> toJson() {
    return {
      "email": this.email,
      "name": this.name,
      "password": this.password,
    };
  }
}
