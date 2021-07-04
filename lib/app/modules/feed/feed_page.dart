import 'package:book_app/app/data/repository/user_repository.dart';
import 'package:book_app/app/modules/feed/feed_controller.dart';
import 'package:book_app/app/modules/widgets_global/custom_circular_progress.dart';
import 'package:book_app/app/modules/widgets_global/rating_item.dart';
import 'package:book_app/app/translations/app_translations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: Get.width,
          height: Get.height,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: GetBuilder<FeedController>(
              init: FeedController(repository: UserRepository()),
              builder: (_) {
                if (_.searching)
                  return Center(
                    child: CustomCircularProgress(),
                  );
                if (_.listRatings.length == 0)
                  return Center(
                      child: Text(
                    AppTranslation.subscriberMustAddReview.tr,
                    textAlign: TextAlign.center,
                  ));
                return ListView.separated(
                  itemCount: _.listRatings.length,
                  itemBuilder: (ctx, index) => RatingItem(_.listRatings[index]),
                  separatorBuilder: (ctx, index) => SizedBox(height: 10),
                );
              },
            ),
          )),
    );
  }
}