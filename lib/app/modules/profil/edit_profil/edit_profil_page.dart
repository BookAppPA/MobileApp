import 'package:book_app/app/modules/profil/edit_profil/edit_profil_controller.dart';
import 'package:book_app/app/modules/profil/widgets/modify_open_hour.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfilPage extends StatelessWidget {
  final List<Widget> listEdit = [
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
          maxLength: EditProfilController.to.isBookSeller ? 500 : 300,
          placeholder: EditProfilController.to.isBookSeller
              ? "Ajouter une description"
              : "Ajouter une bio",
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
                "${_.nbBio}/${_.isBookSeller ? "500" : "300"}",
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
  ];

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
                    children: EditProfilController.to.isBookSeller
                        ? _buildEditBookSeller()
                        : listEdit,
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

  _buildEditBookSeller() {
    var list = listEdit.toList();
    list.addAll([
      Padding(
        padding: EdgeInsets.only(top: 8, bottom: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, bottom: 5),
              child: Text(
                "N° TELEPHONE",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: ConstantColor.greyDark,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 20),
              child: Row(
                children: [
                  GetBuilder<EditProfilController>(
                    builder: (_) {
                      return CountryCodePicker(
                        onChanged: (value) => _.changeCountryCode(value),
                        // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                        initialSelection: _.countryCode,
                        favorite: [_.countryCode],
                        // optional. Shows only country name and flag
                        showCountryOnly: false,
                        // optional. Shows only country name and flag when popup is closed.
                        showOnlyCountryWhenClosed: false,
                        // optional. aligns the flag and the Text left
                        alignLeft: false,
                      );
                    },
                  ),
                  Expanded(
                    child: GetBuilder<EditProfilController>(
                      builder: (_) => CupertinoTextField(
                        controller: _.phoneController,
                        cursorColor: ConstantColor.black,
                        maxLength: 20,
                        keyboardType: TextInputType.phone,
                        placeholder: "Ajouter un numéro de téléphone",
                        padding: EdgeInsets.all(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 20, bottom: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, bottom: 5),
              child: Text(
                "HORAIRES",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: ConstantColor.greyDark,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: _buildListHours(),
              ),
            ),
          ],
        ),
      ),
    ]);
    return list;
  }

  _buildListHours() {
    List<Widget> list = [];
    for (int i = 0; i < 7; i++) {
      list.add(ModifyOpenHour(
        day: EditProfilController.to.days[i],
        dayHours: EditProfilController.to.hoursOfDays[i],
        onModify: (newDayHours) => EditProfilController.to
            .changeHoursDay(EditProfilController.to.days[i], newDayHours),
      ));
    }
    return list;
  }
}
