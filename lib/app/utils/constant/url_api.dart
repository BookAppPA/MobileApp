import 'package:get/get.dart';

abstract class UrlAPI {
  // FIREBASE FUNCTION API
  static final String readBookID =
      'https://europe-west3-book-app-7f51e.cloudfunctions.net/app/api/readBookID/';

  //TODO: SI EXECUTION EMULATEUR ANDROID + API en localhost => mettre 10.0.2.2
  // + supprimer plus tard android:usesCleartextTraffic="true" dans Manifest
  /* + 
    <key>NSAppTransportSecurity</key>
    <dict>
      <key>NSAllowsArbitraryLoads</key>
        <true/>
    </dict>
  */
  // Dans Info.plist

  static final String dateServer =
      "http://${GetPlatform.isAndroid ? "10.0.2.2" : "localhost"}:5001/book-app-7f51e/us-central1/app/api/dateServer";

  static final String login =
      // 'https://europe-west3-bombr-9f62f.cloudfunctions.net/dateServer';
      "http://${GetPlatform.isAndroid ? "10.0.2.2" : "localhost"}:5001/book-app-7f51e/us-central1/app/api/auth/login";

  static final String signup =
      "http://${GetPlatform.isAndroid ? "10.0.2.2" : "localhost"}:5001/book-app-7f51e/us-central1/app/api/auth/signup";

  static final String checkSiret =
      "http://${GetPlatform.isAndroid ? "10.0.2.2" : "localhost"}:5001/book-app-7f51e/us-central1/app/api/auth/checkSiret";

  static final String checkSiren =
      "http://${GetPlatform.isAndroid ? "10.0.2.2" : "localhost"}:5001/book-app-7f51e/us-central1/app/api/auth/checkSiren";

  static final String signupBookSeller =
      "http://${GetPlatform.isAndroid ? "10.0.2.2" : "localhost"}:5001/book-app-7f51e/us-central1/app/api/auth/signupBookSeller";

  static final String logout =
      "http://${GetPlatform.isAndroid ? "10.0.2.2" : "localhost"}:5001/book-app-7f51e/us-central1/app/api/auth/logout";

  static final String getUserById =
      "http://${GetPlatform.isAndroid ? "10.0.2.2" : "localhost"}:5001/book-app-7f51e/us-central1/app/api/bdd/getUserById";

  static final String updateUser =
      "http://${GetPlatform.isAndroid ? "10.0.2.2" : "localhost"}:5001/book-app-7f51e/us-central1/app/api/auth/updateUser";

  static final String popularBooks =
      "http://${GetPlatform.isAndroid ? "10.0.2.2" : "localhost"}:5001/book-app-7f51e/us-central1/app/api/bdd/popularBooks";

  static final String userListBooks =
      "http://${GetPlatform.isAndroid ? "10.0.2.2" : "localhost"}:5001/book-app-7f51e/us-central1/app/api/bdd/userListBooks";

  static final String addBookToGallery =
      "http://${GetPlatform.isAndroid ? "10.0.2.2" : "localhost"}:5001/book-app-7f51e/us-central1/app/api/bdd/addBookToGallery";

  static final String addBookWeek =
      "http://${GetPlatform.isAndroid ? "10.0.2.2" : "localhost"}:5001/book-app-7f51e/us-central1/app/api/bdd/addBookWeek";

  static final String deleteBookFromGallery =
      "http://${GetPlatform.isAndroid ? "10.0.2.2" : "localhost"}:5001/book-app-7f51e/us-central1/app/api/bdd/deleteBookFromGallery";

  static final String bookDetail =
      "http://${GetPlatform.isAndroid ? "10.0.2.2" : "localhost"}:5001/book-app-7f51e/us-central1/app/api/bdd/bookDetail";

  static final String searchBook =
      "http://${GetPlatform.isAndroid ? "10.0.2.2" : "localhost"}:5001/book-app-7f51e/us-central1/app/api/bdd/searchBook";

  static final String searchBooksByAuthor =
      "http://${GetPlatform.isAndroid ? "10.0.2.2" : "localhost"}:5001/book-app-7f51e/us-central1/app/api/bdd/searchBooksByAuthor";

  static final String searchUsers =
      "http://${GetPlatform.isAndroid ? "10.0.2.2" : "localhost"}:5001/book-app-7f51e/us-central1/app/api/bdd/searchUsers";

  static final String ratingByBook =
      "http://${GetPlatform.isAndroid ? "10.0.2.2" : "localhost"}:5001/book-app-7f51e/us-central1/app/api/bdd/ratingByBook";

  static final String userListRatings =
      "http://${GetPlatform.isAndroid ? "10.0.2.2" : "localhost"}:5001/book-app-7f51e/us-central1/app/api/bdd/userListRatings";

  static final String getInitListBookSeller =
      "http://${GetPlatform.isAndroid ? "10.0.2.2" : "localhost"}:5001/book-app-7f51e/us-central1/app/api/bdd/getInitListBookSeller";

  static final String searchBookSeller =
      "http://${GetPlatform.isAndroid ? "10.0.2.2" : "localhost"}:5001/book-app-7f51e/us-central1/app/api/bdd/searchBookSeller";

  static final String getListBooksWeek =
      "http://${GetPlatform.isAndroid ? "10.0.2.2" : "localhost"}:5001/book-app-7f51e/us-central1/app/api/bdd/getListBooksWeek";

  static final String followUser =
      "http://${GetPlatform.isAndroid ? "10.0.2.2" : "localhost"}:5001/book-app-7f51e/us-central1/app/api/bdd/followUser";

  static final String getListFollowers =
      "http://${GetPlatform.isAndroid ? "10.0.2.2" : "localhost"}:5001/book-app-7f51e/us-central1/app/api/bdd/getListFollowers";

  static final String getListFollowing =
      "http://${GetPlatform.isAndroid ? "10.0.2.2" : "localhost"}:5001/book-app-7f51e/us-central1/app/api/bdd/getListFollowing";

  static final String unFollowUser =
      "http://${GetPlatform.isAndroid ? "10.0.2.2" : "localhost"}:5001/book-app-7f51e/us-central1/app/api/bdd/unFollowUser";

  static final String isFollow =
      "http://${GetPlatform.isAndroid ? "10.0.2.2" : "localhost"}:5001/book-app-7f51e/us-central1/app/api/bdd/isFollow";
      
}
