import 'package:book_app/app/data/model/user.dart';
import 'package:book_app/app/modules/profil/user_controller.dart';
import 'package:book_app/app/modules/search/search_user_item.dart';
import 'package:book_app/app/modules/widgets_global/back_button_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'list_followers_controller.dart';

class ListFollowersPage extends StatelessWidget {

  final bool isFollowing;
  ListFollowersPage({this.isFollowing: false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackButtonAppBar(
        textTitle: isFollowing ? "Liste de vos abonnements" : "Liste de vos abonnés",
      ),
      body: SingleChildScrollView(
        child: Container(
            width: Get.width,
            height: Get.height,
            child: GetBuilder<UserController>(
              builder: (_) {
                var length = isFollowing ? _.user.listFollowing.length : _.user.listFollowers.length;
                if (length == 0 && !ListFollowersController.to.afterLoading)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                if (length == 0 && ListFollowersController.to.afterLoading)
                  return Center(
                    child: Text(isFollowing ? "Aucun abonnements" : "Aucun abonnés"),
                  );
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: ListView.builder(
                    itemCount: length,
                    itemBuilder: (ctx, index) {
                      UserModel user = isFollowing ? _.user.listFollowing[index] : _.user.listFollowers[index];
                      return SearchUserItem(
                        user,
                        showInfos: false,
                        onFollow: () => ListFollowersController.to.followUser(index, user),
                        onUnFollow: () => _.unFollowUser(user),
                      );
                    },
                  ),
                );
              },
            )),
      ),
    );
  }
}
