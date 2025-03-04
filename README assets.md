
Nơi chứa toàn bộ assets của dự án 

Để gen `assets.dart` và khai báo toàn bộ assets trong `pubspec.yaml`:

1. Active assets_generator:

```dart
dart pub global activate -s git https://github.com/HVLoc/assets_generator_by_lochv.git
```

2. Run command:

```dart
<!-- agen -f lib/assets -t d -s -r uwu --no-watch -->
lochv_agen -s -t d --const-array --rule uwu --package --no-watch

```

- `-t`: `f`: The type in pubsepec.yaml: `file`
- `-s`: Whether save the arguments into the local, file name: `gp_assets_generator_arguments`
- `-r`: The rule for the names of assets' consts

  - `lwu`: (lowercase_with_underscores) : e.g: `assets_images_xxx_jpg`
  - `uwu`: (uppercase_with_underscores) : e.g: `ASSETS_IMAGES_XXX_JPG`
  - `lcc`: (lowerCamelCase)             : e.g: `assetsImagesXxxJpg`

[Link commands available](https://github.com/toannmdev/gp_assets_generator#all-commands)

3. Terminal sau khi chạy sẽ tiếp tục watch việc thay đổi files trong folders `lib`. Nếu có sự thay đổi, sẽ tự động cập nhật lại file `assets.dart` và khai báo resources tương ứng trong `pubspec.yaml`

## Quy tắc đặt tên biến trong `assets.dart`

- Hiện tại đang replace các ký tự đặc biệt như:
  - ' ' -> ''
  - '=' -> '_equals_'
- Ví dụ: fileName 'File type=Excel.png', tên String sẽ là: `LIB_IMAGES_FILE_TYPE_EXCEL_PNG` khi dùng argument: `-r uwu`