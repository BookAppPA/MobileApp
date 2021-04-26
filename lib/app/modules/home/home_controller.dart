import 'package:book_app/app/data/repository/user_repository.dart';
import 'package:book_app/app/routes/app_pages.dart';
import 'package:book_app/app/utils/constant/constant.dart';
import 'package:book_app/app/utils/functions.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:meta/meta.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  final UserRepository repository;
  HomeController({@required this.repository}) : assert(repository != null);

  DateTime _dateServer;
  bool _loadData = true;
  bool get loadData => this._loadData;
  bool _showBadgeMsg = false;
  bool get showBadgeMsg => this._showBadgeMsg;


  updateShowBadgeMsgAppBar(bool show) {
    _showBadgeMsg = show;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    initApp();
  }

  initApp({bool updateVisibility: false}) async {
    //_loadData = false;
    //update(["appbar"]);
    await Jiffy.locale("fr");
    //var user = UserController.to.user;
    await _initDateServer();
    repository.listenCallbackNotification();
    // Run SwipeController
    //_loadData = true;
    //update(["appbar"]);
  }

  _initDateServer() async {
    _dateServer = await getDateServer();
    Constant.today = _dateServer;
  }
}
