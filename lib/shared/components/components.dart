import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultTextForm({
  required TextEditingController controller,
  required String labelText,
  required IconData prefixIcon,
  required TextInputType keyboardType,
  IconButton? suffixIcon,
  ValueChanged<String>? onFieldSubmitted,
  ValueChanged<String>? onChanged,
  FormFieldValidator<String>? validator,
  GestureTapCallback? onTap,
  bool obscureText = false,
}) => TextFormField(
  decoration: InputDecoration(
    labelText: labelText,
    prefixIcon: Icon(prefixIcon),
    suffixIcon: suffixIcon,
    border: const OutlineInputBorder(),
  ),
  controller: controller,
  keyboardType: keyboardType,
  obscureText: obscureText,
  onFieldSubmitted: onFieldSubmitted,
  onChanged: onChanged,
  validator: validator,
  onTap: onTap,
);

Widget defaultButton({
  double width = double.infinity,
  double height = 40,
  double radius = 10.0,
  Color color = Colors.blue,

  required VoidCallback? onPressed,
  required String text,

}) => Container(
  width: width,
  height: height,
  decoration: BoxDecoration(
    color: color,
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  ),
  child: MaterialButton(
    onPressed: onPressed,
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 16.0,
        color: Colors.white,
      ),
    ),
  ),
);


Widget divideBy() => Padding(
  padding: const EdgeInsets.symmetric(
    horizontal: 5,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey,
  ),
);


void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
        (route) => false,
  );
}

Future buildToast({
  required String message,
  required Cases state,
})  async => await Fluttertoast.showToast(
  msg: message,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  backgroundColor: buildColorToast(state),
  textColor: Colors.white,
  fontSize: 16.0,
);


enum Cases {SUCCESS, WARNING, ERROR}

Color? buildColorToast(state) {
  Color? color;
  switch (state) {
    case Cases.SUCCESS : return Colors.green;
    case Cases.ERROR : return Colors.red;
    case Cases.WARNING : return Colors.yellow;
  }
  return color;
}

