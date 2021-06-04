import 'package:book_app/app/modules/widgets_global/back_button_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BookPreviewPage extends StatelessWidget {
  final bookId = Get.arguments as String ?? "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackButtonAppBar(
        textTitle: "Aperçu du livre",
      ),
      body: Container(
        child: bookId != ""
            ? WebView(
                initialUrl: Uri.dataFromString(
                        '<html><body><iframe frameborder="0" scrolling="no" style="border:0px;width:100%;height:100%;top:0;left:0;position:absolute;" src="https://books.google.fr/books?id=$bookId&lpg=PP1&pg=PP1&output=embed"></iframe></body></html>',
                        mimeType: 'text/html')
                    .toString(),
                javascriptMode: JavascriptMode.unrestricted,

              )
            : Center(
                child: Text("Pas d'aperçu disponible pour ce livre"),
              ),
      ),
    );
  }
}
