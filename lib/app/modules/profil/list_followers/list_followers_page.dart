import 'package:book_app/app/modules/profil/list_followers/follower_item.dart';
import 'package:book_app/app/modules/widgets_global/back_button_appbar.dart';
import 'package:book_app/app/translations/app_translations.dart';
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
        textTitle:
            isFollowing ? AppTranslation.listFollowing.tr : AppTranslation.listFollowers.tr,
      ),
      body: SingleChildScrollView(
        child: Container(
            width: Get.width,
            height: Get.height,
            child: GetBuilder<ListFollowersController>(
              builder: (_) {
                var length = _.listUser.length;
                if (length == 0 && !ListFollowersController.to.afterLoading)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                if (length == 0 && ListFollowersController.to.afterLoading)
                  return Center(
                    child: Text(
                        isFollowing ? AppTranslation.noFollowing.tr : AppTranslation.noFollower.tr),
                  );
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                  child: ListView.separated(
                    itemCount: length,
                    itemBuilder: (ctx, index) {
                      return FollowerItem(_.listUser[index]);
                    },
                    separatorBuilder: (ctx, index) => SizedBox(height: 10),
                  ),
                );
              },
            )),
      ),
    );
  }
}
