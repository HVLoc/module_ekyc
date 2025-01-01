import 'package:hive/hive.dart';
import 'package:module_ekyc/modules/authentication_kyc/verify_profile_ca/models/login_ca_model/login_ca_model.src.dart';

void registerAdapters() {
  Hive.registerAdapter(LoginCaRequestModelAdapter());
}
