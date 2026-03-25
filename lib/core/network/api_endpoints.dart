class ApiEndpoints {
  static const String baseUrl =
      "http://192.168.7.12:4001/";
  static const String register = 'api/auth/register';
   static const String login = 'api/auth/login';

   static const String registration = 'api/auth/register';
   static const String library = 'api/library/categories';
   static const String verifyOtp = 'api/auth/check-otp';
   static const String forgotPass = 'api/auth/forgot-password';
   static const String verifyEmail = 'api/auth/verify-email';
   static const String resetPassWord = 'api/auth/reset-password';
   static const String getMe = 'api/auth/me';
   static const String updateUser= 'api/auth/update';
   static const String  suggestedVideo= 'api/library';
   static const String  prescriptionResume= 'api/prescription/resume';
   static const String  prescribe= 'api/prescription';
  static String prescribedDetails(String id) => 'api/library/$id';
  static const String favourite = 'api/library/favorites';
  static  String favouriteId(String id) => 'api/library/$id/favorite';
  static String libraryProgress(String id) => 'api/library/$id/progress';
  static  const String watchHistory = 'api/library/watch-history';



}
