import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SnackBarService {
  BuildContext _buildContext;

  static SnackBarService instance = SnackBarService();

  SnackBarService() {}

  set buildContext(BuildContext _context) {
    _buildContext = _context;
  }

  void showSnackBarError(String _message) {
    Get.snackbar(
      'Error',
      'Message',
      duration: Duration(seconds: 3),
      messageText: Text(
        _message,
        style: TextStyle(
            color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.red,
    );
  }

  void showSnackBarSuccess(String _message) {
    Get.snackbar(
      'Success',
      'Message',
      duration: Duration(seconds: 2),
      messageText: Text(
        _message,
        style: TextStyle(
            color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.green,
    );
  }
}