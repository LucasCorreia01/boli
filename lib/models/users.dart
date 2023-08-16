import 'package:boli/models/user.dart';
import 'package:flutter/material.dart';

class Users extends ChangeNotifier{
  List<User> users;

  Users({required this.users});
}