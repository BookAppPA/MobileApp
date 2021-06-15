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
  static final String login =
      // 'https://europe-west3-bombr-9f62f.cloudfunctions.net/dateServer';
      "http://10.0.2.2:5001/book-app-7f51e/us-central1/app/api/auth/login";

  static final String signup =
      "http://10.0.2.2:5001/book-app-7f51e/us-central1/app/api/auth/signup";

  static final String logout =
      "http://10.0.2.2:5001/book-app-7f51e/us-central1/app/api/auth/logout";

  static final String getUserById =
      "http://10.0.2.2:5001/book-app-7f51e/us-central1/app/api/bdd/getUserById";

  static final String updateUser =
      "http://10.0.2.2:5001/book-app-7f51e/us-central1/app/api/auth/updateUser";

  static final String popularBooks =
      "http://10.0.2.2:5001/book-app-7f51e/us-central1/app/api/bdd/popularBooks";

  static final String userListBooks =
      "http://10.0.2.2:5001/book-app-7f51e/us-central1/app/api/bdd/userListBooks";

  static final String addBookToGallery =
      "http://10.0.2.2:5001/book-app-7f51e/us-central1/app/api/bdd/addBookToGallery";

  static final String deleteBookFromGallery =
      "http://10.0.2.2:5001/book-app-7f51e/us-central1/app/api/bdd/deleteBookFromGallery";
  
  static final String bookDetail =
      "http://10.0.2.2:5001/book-app-7f51e/us-central1/app/api/bdd/bookDetail";
  
  static final String searchBook =
      "http://10.0.2.2:5001/book-app-7f51e/us-central1/app/api/bdd/searchBook";

  static final String searchBooksByAuthor =
      "http://10.0.2.2:5001/book-app-7f51e/us-central1/app/api/bdd/searchBooksByAuthor";

  static final String searchUsers =
      "http://10.0.2.2:5001/book-app-7f51e/us-central1/app/api/bdd/searchUsers";

  static final String ratingByBook =
      "http://10.0.2.2:5001/book-app-7f51e/us-central1/app/api/bdd/ratingByBook";

  static final String userListRatings =
      "http://10.0.2.2:5001/book-app-7f51e/us-central1/app/api/bdd/userListRatings";

  static final String getInitListBookSeller =
      "http://10.0.2.2:5001/book-app-7f51e/us-central1/app/api/bdd/getInitListBookSeller";

  static final String searchBookSeller =
      "http://10.0.2.2:5001/book-app-7f51e/us-central1/app/api/bdd/searchBookSeller";

}
