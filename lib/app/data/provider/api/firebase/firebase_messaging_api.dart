import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class FirebaseMessagingAPI {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  getToken() async {
    return await _firebaseMessaging.getToken();
  }

  /*configureCallback() {
    // Android: data field, pas sur IOS
    // => var notif = message['data'] ?? message;

    _firebaseMessaging.configure(
      // 1er plan quand app ouverte
      // onMessage notif: {notification: {body: VictorNotif vient de t'envoyer une bombe 💣, title: Bombr}, data: {status: bomb, senderId: 1kySAq6nfWh1BxqtT2Zp1WvDa652}}
      //TODO: ICI AFFICHER BAR NOTIF HAUT IN APP
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage notif: $message");
        /* CustomSnackbar.snackbar(
          "onMessage: $message",
          shortDuration: false,
        );*/
        var data = message['data'] ?? message;
        //TODO: show snack top info et si clique -> handleNotif
        var senderID = data['senderId']?.toString();
        if (senderID != null && data['status'] != null) {
          // BOMB
          if (data['status'] == "bomb") {
            print("BOMB RECEIVE NOTIF: $senderID");
            //TODO: snapshot sur bomb / match / chat / likedby => notif juste redirection car update data deja fait
            Get.toNamed(Routes.CHAT, arguments: "bomb");
          }

          // MATCH
          else if (data['status'] == "match") {
            print("MATCH RECEIVE NOTIF: $senderID");
          }

          // CHAT
          else if (data['status'] == "chat") {
            //AFFICHER SNACKBAR SEULEMENT SI USER TJRS DANS MATCH OU RECENT CHAT
            print("CHAT RECEIVE NOTIF: $senderID");
          }
        }
      },
      // App close and click notif
      // onLaunch: {data: {google.sent_time: 1605294075417, google.original_priority: high, status: bomb, collapse_key: fr.bombr.bombr, google.delivered_priority: high, senderId: 61JIQIYI4gMLsN0mK4avZXIZeh1, from: 107184302059, google.message_id: 122222, google.ttl: 86400}, notification: {}}
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch notif: $message");
        /* CustomSnackbar.snackbar(
          "onLaunch: $message",
          seconds: 15,
        );*/
        var data = message['data'] ?? message;
        var senderID = data['senderId']?.toString();
        CustomSnackbar.snackbar(
          "senderID: $senderID\n Bomb lenght: ${SwipeController.to.listBombProfil.length}",
          seconds: 10,
        );
        if (senderID != null && data['status'] != null) {
          // BOMB
          if (data['status'] == "bomb") {
            print("BOMB RECEIVE NOTIF: $senderID");

            print("Bomb lenght: ${SwipeController.to.listBombProfil.length}");
            Get.toNamed(Routes.CHAT, arguments: "bomb");
          }

          // MATCH
          else if (data['status'] == "match") {
            print("MATCH RECEIVE NOTIF: $senderID");
          }

          // CHAT
          else if (data['status'] == "chat") {
            print("CHAT RECEIVE NOTIF: $senderID");
          }
        }
      },
      // App background
      // Quand click notif =>
      // onResume notif: {data: {google.sent_time: 1605294075417, google.original_priority: high, status: bomb, collapse_key: fr.bombr.bombr, google.delivered_priority: high, senderId: 61jiQIYi4gMLsN0mK4avZXViZeh1, from: 107184302059, google.message_id: 0:1605294075439572%49fc469049fc4690, google.ttl: 86400}, notification: {}}

      // Quand reouvre app multitache =>
      // ???
      //TODO: ICI AFFICHER BAR NOTIF HAUT IN APP
      onResume: (Map<String, dynamic> message) async {
        print("onResume notif: $message");
        /*CustomSnackbar.snackbar(
          "onResume: $message",
          shortDuration: false,
        );*/
        var data = message['data'] ?? message;
        var senderID = data['senderId']?.toString();
        if (senderID != null && data['status'] != null) {
          // BOMB
          if (data['status'] == "bomb") {
            print("BOMB RECEIVE NOTIF: $senderID");
            print("Bomb lenght: ${SwipeController.to.listBombProfil.length}");
            Get.toNamed(Routes.CHAT, arguments: "bomb");
          }

          // MATCH
          else if (data['status'] == "match") {
            print("MATCH RECEIVE NOTIF: $senderID");
          }

          // CHAT
          else if (data['status'] == "chat") {
            print("CHAT RECEIVE NOTIF: $senderID");
          }
        }
      },
    );
  }*/
}
