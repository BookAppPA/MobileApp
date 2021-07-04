import 'package:flutter/material.dart';
import 'en_US/en_us_translation.dart';
import 'es_ES/es_es_translation.dart';
import 'fr_FR/fr_fr_translation.dart';

abstract class AppTranslation {

  static final List<Locale> languages = [
    Locale("fr", "FR"),
    Locale("en", "US"),
    Locale("es", "ES"),
  ];

  static Map<String, Map<String, String>> translations = {
    'fr_FR': frFR,
    'en_US': enUS,
    'es_ES': esES,
  };

  static const String noPermission = "no_permission";
  static const String accountBlocked = "account_blocked";
  static const String emailNotExist = "email_not_exist";
  static const String passwordError = "password_error";
  static const String emailAlreadyUse = "email_already_use";
  static const String welcome = "welcome";
  static const String welcomeBack = "welcome_back";
  static const String enterPseudo = "enter_pseudo";
  static const String enterEmail = "enter_email";
  static const String enterPassword = "enter_password";
  static const String termConditionBegin = "term_condition_begin";
  static const String termConditionMiddle = "term_condition_middle";
  static const String termConditionEnd = "term_condition_end";
  static const String login = "login";
  static const String signup = "signup";
  static const String newQuestion = "new_question";
  static const String alreadySignupQuestion = "already_signup_question";
  static const String previewBook = "preview_book";
  static const String noPreviewBook = "no_preview_book";
  static const String bookHasAddToGallery = "book_has_add_to_gallery";
  static const String alreadyAddBook = "already_add_book";
  static const String bookHasDeleteFromGallery = "book_has_delete_from_gallery";
  static const String alreadyDeleteBook = "already_delete_book";
  static const String preview = "preview";
  static const String deleteBook = "delete_book";
  static const String finishThisBook = "finish_this_book";
  static const String averageRating = "average_rating";
  static const String noReviews = "no_reviews";
  static const String ratingWithNumber = "rating_with_number";
  static const String contact = "contact";
  static const String follow = "follow";
  static const String openHours = "open_hours";
  static const String allDays = "all_days";
  static const String description = "description";
  static const String lastBookWeek = "last_book_week";
  static const String address = "address";
  static const String findBookStore = "find_bookstore";
  static const String noBookStoreFound = "no_bookstore_found";
  static const String favoriteCategoryQuestion = "favorite_category_question";
  static const String finish = "finish";
  static const String leave = "leave";
  

  static const String serverError = 'servor_error';
  static const String siretError = "siret_error";
  static const String addReview = "add_review";
  static const String changeReview = "change_review";
  static const String addTitle = "add_title";
  static const String add = "add";
  static const String doNotSend = 'do_not_send';
  static const String titleMustThreeLength = 'title_must_be_three_length';
  static const String descMustbeThreeLength = "desc_must_be_three_length";
  static const String addingBookWithoutReview = 'adding_book_without_review';
  static const String confirmAddingBookToLibraryWithoutReview = 'adding_book_to_library';
  static const String viewRemoved = 'view_removed';
  static const String noCategories = "no_categories";
  static const String subscriberMustAddReview = "subscriber_must_add_review";
  static const String wantLeaveApp = "want_leave_app";
  static const String yes = "yes";
  static const String no = "no";
  static const String logout = "logout";
  static const String logoutQuestion = "logout_question";
  static const String finishBook = "finish_book";
  static const String addBookToGalleryQuestion = "add_book_to_gallery_question";
  static const String deleteBookFromGalleryQuestion = "delete_book_from_gallery_question";
  static const String searchBookAuthorUser = "search_book_author_user";
  static const String bookSellerChoice = "bookseller_choice";
  static const String mostPopular = "most_popular";
  static const String youWouldLike = "you_would_like";
  static const String gotIt = "got_it";

  // a ajouter
  static const String findNuggets = "find_nuggets";
  static const String discoverNewBook = "discover_new_book";
  static const String shareRating = "share_rating";

  // ici
  static const String rateYourGallery = "rate_your_gallery";
  static const String errorSync = "error_sync";
  static const String editProfil = "edit_profil";
  static const String aboutMe = "about_me";
  static const String addBio = "add_bio";
  static const String noBio = "no_bio";
  static const String books = "books";
  static const String followers = "followers";
  static const String edit = "edit";



  static const String finishABook = "finish_a_book";

  static const String locationCheckTitle = "location_check";

  // EXCEPTION API
  static const String errorAPIdefault = "error_api_default";
  static const String errorAPInetwork = "error_api_network";
}
