import 'package:module_ekyc/core/core.src.dart';

extension GetSizeDesignScreen on num {
  /// Tỉ lệ chiều ngang(width) của màn hình hiện tại so với màn hình thiết kế
  double get w {
    return ratioWidth * this;
  }

  /// Tỉ lệ chiều cao(height)
  double get h {
    return ratioHeight * this;
  }

  /// Tỉ lệ fontSize của các textStyle
  // double get sp {
  //   return this * scaleFontsize;
  // }
}
