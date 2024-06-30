import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthData  {

  String name = '';
  String id = '';
  String role = '';
  String email = '';
  String firstname = '';
  String lastname = '';
  String phone = '';
  String address = '';
  String country = '';
  String city = '';
  String language = '';
  String gender = '';
  // Firestore

AuthData({
  required this.email,
  required this.id,
  required this.name,
  required this.role,
  required this.firstname,
  required this.lastname,
});

}