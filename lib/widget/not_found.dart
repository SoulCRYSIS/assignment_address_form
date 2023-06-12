import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  const NotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.close),
          Text('ไม่พบคำที่คุณค้นหา'),
          Text('กรุณาตรวจสอบตัวสะกด หรือค้นหาด้วยคำอื่น'),
        ],
      ),
    );
  }
}
