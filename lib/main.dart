import 'package:flutter/material.dart';

import 'core/router/app_router.src.dart';
import 'modules/authentication_kyc/nfc_kyc/nfc_kyc.src.dart';
import 'modules/sdk/sdk.src.dart';
import 'shares/shares.src.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      // initialRoute: AppRoutes.initApp,
      getPages: RouteAppPage.route,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // translationsKeys: AppTranslation.translations,
      locale: const Locale('vi', 'VN'),

      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ứng dụng NFC và EKYC'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  // Gọi hàm đọc NFC khi nhấn nút
                  await ModulesEkyc.readOnlyNFC().then((onValue) {
                    if (onValue is SendNfcRequestModel) {
                      SendNfcRequestModel sendNfcRequestModel = onValue;
                      print('NFC: ${sendNfcRequestModel.toJson()}');
                    }
                  });
                },
                child: const Text('Đọc NFC'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Gọi hàm kiểm tra EKYC khi nhấn nút
                  SdkRequestModel sdkRequestModel = SdkRequestModel(
                    merchantKey: "89f797ab-ec41-446a-8dc1-1dfda5e7e93d",
                    secretKey: "63f81c69722acaa42f622ec16d702fdb",
                    method: "INTEGRITY",
                    isProd: false,
                  );
                  await ModulesEkyc.checkEKYC(sdkRequestModel).then((onValue) {
                    if (onValue is SendNfcRequestModel) {
                      SendNfcRequestModel sendNfcRequestModel = onValue;
                      print('EKYC: ${sendNfcRequestModel.toJsonFull()}');
                    }
                  });
                },
                child: const Text('Xác thực EKYC'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Gọi hàm chỉ đọc NFC và liveless

                  await ModulesEkyc.scanEKYC().then((onValue) {
                    if (onValue is SendNfcRequestModel) {
                      SendNfcRequestModel sendNfcRequestModel = onValue;
                      print('Scan EKYC: ${sendNfcRequestModel.toJsonFull()}');
                    }
                  });
                },
                child: const Text('Quét EKYC'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
