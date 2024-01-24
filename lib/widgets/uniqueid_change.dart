import 'package:defest23_checkin/widgets/popup_changeid.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../screens/drawer.dart';

class ChangeUniqueId extends StatefulWidget {
  final String oldqr;
  final String newqr;
  const ChangeUniqueId(
      {super.key, this.oldqr = "Not Found", this.newqr = "Not Found"});

  @override
  State<ChangeUniqueId> createState() => _ChangeUniqueIdState();
}

class _ChangeUniqueIdState extends State<ChangeUniqueId> {
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
        width: double.infinity,
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
              Text(
                "Old Qr: ${widget.oldqr}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "New Qr: ${widget.newqr}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton.icon(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xFF4184F7)),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: () {
                  popupChangeId(widget.oldqr, widget.newqr, context);
                },
                icon: const Icon(Icons.check),
                label: const Text("Change Unique ID"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
