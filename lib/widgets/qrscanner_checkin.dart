import 'package:defest23_checkin/screens/drawer.dart';
import 'package:defest23_checkin/widgets/popup.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class CheckinScanner extends StatefulWidget {
  const CheckinScanner({super.key});

  @override
  State<CheckinScanner> createState() => _CheckinScannerState();
}

class _CheckinScannerState extends State<CheckinScanner> {
  MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
    torchEnabled: false,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                "lib/assets/checkin.png",
              ),
              SizedBox(
                width: double.infinity,
                height: 250,
                child: MobileScanner(
                  controller: controller,
                  onDetect: (capture) {
                    controller.stop();
                    final List<Barcode> barcodes = capture.barcodes;
                    for (final barcode in barcodes) {
                      debugPrint('Barcode found! ${barcode.rawValue}');
                      if (barcode.rawValue != null) {
                        popup(1, barcode.rawValue!, context);
                      }
                    }
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFF4184F7)),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    onPressed: () {
                      controller.start();
                    },
                    icon: const Icon(Icons.qr_code),
                    label: const Text("Scan"),
                  ),
                  TextButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 255, 0, 0)),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    onPressed: () {
                      controller.stop();
                    },
                    icon: const Icon(Icons.stop),
                    label: const Text("Stop"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
