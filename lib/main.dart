import 'package:assignment_address_form/bloc/select_address_cubit.dart';
import 'package:assignment_address_form/repository/address_data_repository.dart';
import 'package:assignment_address_form/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SelectAddressCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: 'FC Orbit Rounded',
        ),
        home: HomeScreen(AddressDataRepository(httpClient: http.Client())),
      ),
    );
  }
}
