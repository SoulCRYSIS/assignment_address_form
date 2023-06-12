import 'package:assignment_address_form/bloc/select_address_cubit.dart';
import 'package:assignment_address_form/model/address.dart';
import 'package:assignment_address_form/screen/province_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/address_data_repository.dart';
class HomeScreen extends StatelessWidget {
  
  const HomeScreen(this.addressDataRepository, {super.key});

  final AddressDataRepository addressDataRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home'),
      ),
      body: InkWell(
        key: const Key('editAddress'),
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProvinceScreen(addressDataRepository))),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: const BorderRadius.all(
              Radius.circular(20), // Border radius
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocBuilder<SelectAddressCubit, Address>(
                builder: (context, address) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('ที่อยู่ติดต่อได้'),
                      Text(address.subdistrict),
                      Text(address.district),
                      Text(address.province),
                    ],
                  );
                },
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}
