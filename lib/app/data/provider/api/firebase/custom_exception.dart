
import 'package:meta/meta.dart';

class CustomException {

  final String code, message;
  CustomException({@required this.code, @required this.message}) : assert(code != null && code != ""), assert(message != null && message != "");
  
}