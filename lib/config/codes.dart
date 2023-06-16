// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:tyldc_finaalisima/models/auth_code_model.dart';

import '../logic/local_storage_service.dart/local_storage.dart';

const EMAIL_ALREADY_IN_USE =
    'A user with this email already exist, contact your admin for clarity';
const WEAK_PASSWORD =
    'this password does not meat the minimum requirements (A-Z,a-z,0-9,!@#/\$%^&*().,;)';
const CONTACT_ADMIN = 'AN UNKNOWN ERROR OCCURED PLEASE CONTACT YOUR ADMIN';

var ADMIN_AUTH_CODE =' toModel().adminCode';
// var SUPER_ADMIN_AUTH_CODE =  TokenService().getSuperAdminCode();
// var VIEWER_ADMIN_AUTH_CODE = TokenService().getViewerCode();

