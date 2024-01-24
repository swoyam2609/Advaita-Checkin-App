import 'package:defest23_checkin/widgets/qrscanner_change.dart';
import 'package:defest23_checkin/widgets/qrscanner_checkin.dart';
import 'package:defest23_checkin/widgets/qrscanner_lunch.dart';
import 'package:defest23_checkin/widgets/qrscanner_swag.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class CustomDrawer extends StatelessWidget {
  final MobileScannerController controller;
  const CustomDrawer({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: double.infinity,
        width: 250,
        color: Colors.grey[900],
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 25,
              ),
              child: Image.asset("lib/assets/logo.png"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () {
                        controller.dispose();
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CheckinScanner()));
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                      ),
                      icon: const Icon(Icons.check_circle),
                      label: const Text("Checkin"),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () {
                        controller.dispose();
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ChangeQrPage()));
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.yellow[800],
                      ),
                      icon: const Icon(Icons.qr_code),
                      label: const Text("Change QR"),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () {
                        controller.dispose();
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LunchScanner()));
                      },
                      icon: const Icon(Icons.food_bank),
                      label: const Text("Lunch"),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () {
                        controller.dispose();
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SwagScanner()));
                      },
                      icon: const Icon(Icons.star),
                      label: const Text("Swags"),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
