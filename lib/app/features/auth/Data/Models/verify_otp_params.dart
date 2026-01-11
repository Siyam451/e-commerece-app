class VerifyOtpParams{
  final String email;
  final String otp;

  VerifyOtpParams({

    required this.otp,
    required this.email,

  });

  Map<String, dynamic> toJson() {
    return
      {
        "email": email,
        "otp": otp,
      };
  }
}