import 'package:defest23_checkin/widgets/uniqueid_change.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../screens/drawer.dart';

class ChangeQrPage extends StatefulWidget {
  final String oldqr;
  final String newqr;
  const ChangeQrPage(
      {super.key,
      this.oldqr = "Scan Existing QR",
      this.newqr = "Scan QR on ID CARD"});

  @override
  State<ChangeQrPage> createState() => _ChangeQrPageState();
}

class _ChangeQrPageState extends State<ChangeQrPage> {
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
      drawer: CustomDrawer(controller: controller),
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
                "lib/assets/changeId.png",
              ),
              Text("Existing Qr: ${widget.oldqr}"),
              Text("New Qr: ${widget.newqr}"),
              SizedBox(
                width: double.infinity,
                height: 250,
                child: MobileScanner(
                  startDelay: true,
                  controller: controller,
                  onDetect: (capture) async {
                    controller.stop();
                    final List<Barcode> barcodes = capture.barcodes;
                    for (final barcode in barcodes) {
                      debugPrint('Barcode found! ${barcode.rawValue}');
                      if (barcode.rawValue != null) {
                        if (widget.oldqr == "Scan Existing QR") {
                          controller.dispose();
                          await Future.delayed(
                              const Duration(milliseconds: 3000), () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChangeQrPage(
                                  oldqr: barcode.rawValue!,
                                ),
                              ),
                            );
                          });
                          // ignore: use_build_context_synchronously
                        } else {
                          controller.dispose();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangeUniqueId(
                                newqr: barcode.rawValue!,
                                oldqr: widget.oldqr,
                              ),
                            ),
                          );
                        }
                      }
                    }
                  },
                ),
              ),
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
            ],
          ),
        ),
      ),
    );
  }
}
