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
}
