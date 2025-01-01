import 'package:flutter/material.dart';
import 'package:module_ekyc/core/core.src.dart';

class ClientCollection {
  static const int pageIndex = 1;
  static Map<String, Color> mapSignType = {
    "Hợp lệ": AppColors.colorSuccess,
    "Không hợp lệ": AppColors.colorNotSuccess,
  };
  static const Map<int, String> listFilter = {
    0: "Tất cả",
    1: "7 ngày gần nhất",
    2: "1 tháng gần nhất",
    3: "3 tháng gần nhất",
    4: "Tùy chọn",
  };
}
