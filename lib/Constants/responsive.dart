import 'package:reminder_app/libraries.dart';

getHeight(BuildContext context, double height) {
  return MediaQuery.sizeOf(context).height * height;
}

getWidth(BuildContext context, double width) {
  return MediaQuery.sizeOf(context).width * width;
}
