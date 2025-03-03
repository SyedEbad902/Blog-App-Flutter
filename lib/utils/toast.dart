import 'package:blog_app/utils/Theme/app_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String text) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: AppColors.gradiant1,
    textColor: AppColors.whiteColor,
    fontSize: 17.0,
  );
}
