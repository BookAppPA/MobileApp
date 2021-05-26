import 'package:book_app/app/data/repository/user_repository.dart';
import 'package:book_app/app/modules/profil/edit_profil/edit_profil_controller.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Modifies ton profil",
          style: TextStyle(
            fontFamily: 'Work Sans',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: ConstantColor.black,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsets.only(left: 10),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: ConstantColor.grey,
            ),
            onPressed: () => EditProfilController.to.validateModif(),
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          EditProfilController.to.validateModif();
          return true;
        },
        child: Container(
          width: Get.width,
          height: Get.height,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ListBody(
                    mainAxis: Axis.vertical,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 8, bottom: 4),
                        child: ListTile(
                          title: Padding(
                            padding: EdgeInsets.only(left: 4, bottom: 5),
                            child: Text(
                              "A PROPOS DE MOI",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: ConstantColor.greyDark,
                              ),
                            ),
                          ),
                          subtitle: CupertinoTextField(
                            controller: EditProfilController.to.bioController,
                            cursorColor: ConstantColor.black,
                            maxLines: 5,
                            minLines: 3,
                            maxLength: 150,
                            placeholder: "Ajouter une bio",
                            padding: EdgeInsets.all(10),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            GetBuilder<EditProfilController>(
                              id: "nbBio",
                              builder: (_) {
                                return Text(
                                  "${_.nbBio}/300",
                                  style: TextStyle(
                                    color: ConstantColor.greyDark,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 75),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
