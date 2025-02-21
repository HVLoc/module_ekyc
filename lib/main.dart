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
                    apiKey:
                        "eyJ4NXQjUzI1NiI6Ik5XUXdPVFJrTWpBNU9XRmpObVUyTnpCbE5UTTNaRFV3T0RVellqWXdabUpsWlROa1pEQTRPRFU0WlRVd1pHSXdObVV5TW1abVpUTmhaRGt5TmpRMlpBPT0iLCJraWQiOiJnYXRld2F5X2NlcnRpZmljYXRlX2FsaWFzIiwidHlwIjoiSldUIiwiYWxnIjoiUlMyNTYifQ==.eyJzdWIiOiJhZG1pbkBjYXJib24uc3VwZXIiLCJhcHBsaWNhdGlvbiI6eyJpZCI6MSwidXVpZCI6Ijk3M2I2Mjg1LWNiNmYtNDIxYi1iMzg0LTlhNDIyN2FhMzRiOSJ9LCJpc3MiOiJodHRwczpcL1wvdWF0LWFwaW0uMmlkLnZuOjQ0M1wvb2F1dGgyXC90b2tlbiIsImtleXR5cGUiOiJTQU5EQk9YIiwicGVybWl0dGVkUmVmZXJlciI6IiIsInRva2VuX3R5cGUiOiJhcGlLZXkiLCJwZXJtaXR0ZWRJUCI6IiIsImlhdCI6MTczNzI3OTcxNCwianRpIjoiYTM2MGNmMDctZTQ1My00MTc1LWEwOTAtNWE3ODU4NWZiY2NkIn0=.smuXRLDclnOrc1oBWnVMhgXrOodww6ht3oPTZq-nHnDtspZKKYKoAwJCBrXDy18JweqZWFciZJJ-iLL0pKX_svl0qiddGXO4uxKiaZUbHvzFCtQ7kLYYCKWKqXqB1A8cGM8w0VoKp_VUPtwDj8Ren3adjyM6uF2rxx5ubVeXfxxuaAgpwTBEUTTFgI35VUQeiYHVaJPnN23LwzO6O2eX6YucF7p6OGg_XLs7NedlJnAEsp_LC15mnZnK6IJCzvrnKQAdeW16tXYFT-FGJdVqlyaQwBIStfhJpeQglOZ43FfvjtWdt0G-nYucevoywqeTBpkdvHvjjzDJPX9Xs8FaLw==",
                    isProd: false,
                  );
                  await ModulesEkyc.checkEKYC(sdkRequestModel).then((onValue) {
                    if (onValue is SendNfcRequestModel) {
                      SendNfcRequestModel sendNfcRequestModel = onValue;
                      print('EKYC: ${sendNfcRequestModel.toJson()}');
                    }
                  });
                },
                child: const Text('Xác thực EKYC'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
