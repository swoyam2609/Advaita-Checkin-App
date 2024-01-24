import 'package:defest23_checkin/widgets/popup.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../screens/drawer.dart';

class LunchScanner extends StatefulWidget {
  const LunchScanner({super.key});

  @override
  State<LunchScanner> createState() => _LunchScannerState();
}

class _LunchScannerState extends State<LunchScanner> {
  MobileScannerController controller2 = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
    torchEnabled: false,
  );

  @override
  void dispose() {
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(
        controller: controller2,
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: Image.asset(
            "lib/assets/logo.png",
            height: 50,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage("lib/assets/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                "lib/assets/lunch.png",
              ),
              SizedBox(
                width: double.infinity,
                height: 250,
                child: MobileScanner(
                  controller: controller2,
                  onDetect: (capture) {
                    controller2.stop();
                    final List<Barcode> barcodes = capture.barcodes;
                    for (final barcode in barcodes) {
                      debugPrint('Barcode found! ${barcode.rawValue}');
                      if (barcode.rawValue != null) {
                        popup(2, barcode.rawValue!, context);
                      }
                    }
                  },
                ),
              ),
              TextButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(const Color(0xFF4184F7)),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: () {
                  controller2.start();
                },
                icon: const Icon(Icons.qr_code),
                label: const Text("Scan"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
