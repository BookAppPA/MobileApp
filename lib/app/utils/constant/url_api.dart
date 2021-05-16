abstract class UrlAPI {

  // FIREBASE FUNCTION API
    static final String readBookID =
        'https://europe-west3-book-app-7f51e.cloudfunctions.net/app/api/readBookID/';

    static final String login =
     // 'https://europe-west3-bombr-9f62f.cloudfunctions.net/dateServer';
     "http://localhost:5001/book-app-7f51e/us-central1/app/api/auth/login";

    static final String signup =
     "http://localhost:5001/book-app-7f51e/us-central1/app/api/auth/signup";

}