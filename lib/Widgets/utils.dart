import '../libraries.dart';

toastMessage({required String message, Color? color}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: color ?? AppColors.primaryColor,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

InputDecoration textInputDecoration = InputDecoration(
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  hintText: "abc123",
);
