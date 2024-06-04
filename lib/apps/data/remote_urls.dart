class RemoteUrls {
  // static const String rootUrl = 'https://stagging.dhakasoftwares.com/';
  static const String rootUrl = 'https://ekayzone.co.uk/';
  static const String baseUrl = '${rootUrl}api/';

  static const String userLogin = '${baseUrl}auth/login';
  static String forgotPassWord = "${baseUrl}auth/password/email";
  static const String socialLogin = '${baseUrl}auth/social-login';
  static const String userRegistration = '${baseUrl}auth/register';
  static const String home = '${baseUrl}home?country_code=uk';

  static const String userProfile = '${baseUrl}auth/me';

  static String adsList(
          String searchText,
          String selectedCity,
          String location,
          String minPrice,
          String maxPrice,
          String sortingValue,
          String categoryValue,
          String page) =>
      '${baseUrl}ads?'
      'search=$searchText&'
      'sort_by=$sortingValue&'
      'category=$categoryValue&'
      'location=$location&'
      'km=$selectedCity&'
      'subcategory=&'
      'country_code=uk&'
      'paginate=10&'
      'page=$page&'
      'price_max=$maxPrice&'
      'price_min=$minPrice';

  static String adDetails(String slug) => '${baseUrl}ads/$slug?country_code=uk';

  static String adEdit(String id) => '${baseUrl}ads/$id/edit';

  static String editProfile = "${baseUrl}auth/profile";
  static String getCategoriesData = "${baseUrl}categories";
  static String getSettingsData = "${baseUrl}settings";

  static String publicProfile(String userName, String page) =>
      "${baseUrl}seller/$userName?page=$page&paginate=10";

  //static String userTransaction = "${baseUrl}customer/transactions";
  static String userTransaction = "${baseUrl}customer/recent-invoices";
  static String changePassword = "${baseUrl}auth/password";

  static String deleteAccountApi(delete) =>
      "${baseUrl}customer/account-delete?confirm=$delete";
  static String wishlist = "${baseUrl}customer/favourite-list";

  static String userAdsList(int index) => "${baseUrl}customer/ads?page=$index";

  static String setUnSetWishlist(String id) => "${baseUrl}ads/$id/favourite";

  //static String postAds = "${baseUrl}ads/create";
  static String postAds = "${baseUrl}ads";
  static String paypalPaymentSuccess = "${baseUrl}payment-success";
  static String postReport = "${baseUrl}report/ads";

  static String updateAds(String id) => "${baseUrl}ads/$id/update";

  static String editAds(String id) => "${baseUrl}ads/edit/$id";

  static String adDelete(String id) => "${baseUrl}customer/ads/$id/delete";
  static String dashboard = "${baseUrl}customer/dashboard-overview";
  static String settingApi = "${baseUrl}settings";
  static String compare = "${baseUrl}ads/compare";
  static String chatList = "${baseUrl}message";

  static String chatDetails(String user) => "${baseUrl}message/$user";

  static String getLanguages = '${baseUrl}language/sync';

  static String getSingleLanguage(String code) => '${baseUrl}language/$code';

  static String sellerRating(String userName) =>
      '${baseUrl}seller/review/$userName';

  static String registerWithToken(String token, {String? userId}) =>
      "${baseUrl}storeToken?token=$token&user_id=$userId";

  static String userPlan = "${baseUrl}customer/plan";
  static String pricePlaning = "${baseUrl}pricing-plans";
  static String privacyPolicy = "${rootUrl}privacy-policy";
  static String termsAndCondition = "${rootUrl}terms-condition";
}
