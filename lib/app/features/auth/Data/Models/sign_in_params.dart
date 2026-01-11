class SignInParams{
  final String email;
  final String password;

  SignInParams({

    required this.password,
    required this.email,

  });

  Map<String, dynamic> toJson() {
    return
      {
        "email": email,
        "password": password,
      };
  }
}