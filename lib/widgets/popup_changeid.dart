import 'package:defest23_checkin/apis/chechinapis.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void popupChangeId(String oldcode, String newcode, BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return FutureBuilder(
          future: Devfestapis.change(oldcode, newcode),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const AlertDialog(
                content: Center(
                  child: SizedBox(
                      height: 200,
                      width: 200,
                      child: CircularProgressIndicator()),
                ),
              );
            } else if (snapshot.data == false) {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset('lib/assets/failure.json'),
                    const Text("QR Code is not valid"),
                  ],
                ),
              );
            } else {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset('lib/assets/success.json', height: 200),
                    Text(
                      snapshot.data['name'],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        );
      });
}
