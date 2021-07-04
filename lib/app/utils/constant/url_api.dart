abstract class UrlAPI {
  static final String dateServer =
      "https://europe-west3-book-app-7f51e.cloudfunctions.net/dateServer";

  static final String login =
      "https://europe-west3-book-app-7f51e.cloudfunctions.net/app/auth/login";
  // "http://${GetPlatform.isAndroid ? "10.0.2.2" : "localhost"}:5001/book-app-7f51e/us-central1/app/api/auth/login";

  static final String signup =
      "https://europe-west3-book-app-7f51e.cloudfunctions.net/app/auth/signup";

  static final String checkSiret =
      "https://europe-west3-book-app-7f51e.cloudfunctions.net/app/auth/checkSiret";

  static final String checkSiren =
      "https://europe-west3-book-app-7f51e.cloudfunctions.net/app/auth/checkSiren";

  static final String signupBookSeller =
      "https://europe-west3-book-app-7f51e.cloudfunctions.net/app/auth/signupBookSeller";

  static final String logout =
      "https://europe-west3-book-app-7f51e.cloudfunctions.net/app/auth/logout";

  static final String getUserById =
      "https://europe-west3-book-app-7f51e.cloudfunctions.net/app/user/getUserById";

  static final String updateUser =
      "https://europe-west3-book-app-7f51e.cloudfunctions.net/app/user/updateUser";

  static final String popularBooks =
      "https://europe-west3-book-app-7f51e.cloudfunctions.net/app/book/popularBooks";

  static final String userListBooks =
      "https://europe-west3-book-app-7f51e.cloudfunctions.net/app/book/userListBooks";

  static final String addBookToGallery =
      "https://europe-west3-book-app-7f51e.cloudfunctions.net/app/user/addBookToGallery";

  static final String addBookWeek =
      "https://europe-west3-book-app-7f51e.cloudfunctions.net/app/bookseller/addBookWeek";

  static final String deleteBookFromGallery =
      "https://europe-west3-book-app-7f51e.cloudfunctions.net/app/user/deleteBookFromGallery";

  static final String bookDetail =
      "https://europe-west3-book-app-7f51e.cloudfunctions.net/app/book/bookDetail";

  static final String searchBook =
      "https://europe-west3-book-app-7f51e.cloudfunctions.net/app/search/searchBook";

  static final String searchBooksByAuthor =
      "https://europe-west3-book-app-7f51e.cloudfunctions.net/app/search/searchBooksByAuthor";

  static final String searchBooksByCategories =
      "https://europe-west3-book-app-7f51e.cloudfunctions.net/app/search/searchBooksByCategories";

  static final String searchUsers =
      "https://europe-west3-book-app-7f51e.cloudfunctions.net/app/search/searchUsers";

  static final String ratingByBook =
      "https://europe-west3-book-app-7f51e.cloudfunctions.net/app/rating/ratingByBook";

  static final String userListRatings =
      "https://europe-west3-book-app-7f51e.cloudfunctions.net/app/rating/userListRatings";

  static final String getInitListBookSeller =
      "https://europe-west3-book-app-7f51e.cloudfunctions.net/app/bookseller/getInitListBookSeller";

  static final String getBookSellerById =
      "https://europe-west3-book-app-7f51e.cloudfunctions.net/app/bookseller/getBookSellerById";

  static final String getLastBooksWeek = 
      "https://europe-west3-book-app-7f51e.cloudfunctions.net/app/bookseller/getLastBooksWeek";

  static final String searchBookSeller =
      "https://europe-west3-book-app-7f51e.cloudfunctions.net/app/search/searchBookSeller";

  static final String getListBooksWeek =
      "https://europe-west3-book-app-7f51e.cloudfunctions.net/app/bookseller/getListBooksWeek";

  static final String followUser =
      "https://europe-west3-book-app-7f51e.cloudfunctions.net/app/user/followUser";

  static final String getListFollowers =
      "https://europe-west3-book-app-7f51e.cloudfunctions.net/app/user/getListFollowers";

  static final String getListFollowing =
      "https://europe-west3-book-app-7f51e.cloudfunctions.net/app/user/getListFollowing";

  static final String unFollowUser =
      "https://europe-west3-book-app-7f51e.cloudfunctions.net/app/user/unFollowUser";

  static final String isFollow =
      "https://europe-west3-book-app-7f51e.cloudfunctions.net/app/user/isFollow";

  static final String addRating =
      "https://europe-west3-book-app-7f51e.cloudfunctions.net/app/rating/addRating";

  static final String modifyRating =
      "https://europe-west3-book-app-7f51e.cloudfunctions.net/app/rating/modifyRating";

  static final String deleteRating =
      "https://europe-west3-book-app-7f51e.cloudfunctions.net/app/rating/deleteRating";

   static final String getFeed =
      "https://europe-west3-book-app-7f51e.cloudfunctions.net/app/feed/getFeed";
    
    static final String getRecommendationBooks =
      "https://europe-west3-book-app-7f51e.cloudfunctions.net/app/recommendation";
}
