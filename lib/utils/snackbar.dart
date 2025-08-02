import 'package:fluttertoast/fluttertoast.dart';

import '../constants/color.dart';

void errorToast({required String msg}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    backgroundColor: AppColors.red,
  );
}
