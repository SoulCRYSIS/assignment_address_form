import 'package:assignment_address_form/bloc/select_province/select_province_bloc.dart';
import 'package:assignment_address_form/widget/not_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/address_data_repository.dart';
import 'district_screen.dart';

class ProvinceScreen extends StatelessWidget {
  const ProvinceScreen(this.addressDataRepository, {super.key});

  final AddressDataRepository addressDataRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Select Province'),
      ),
      body: BlocProvider(
        create: (_) => SelectProvinceBloc(addressDataRepository)
          ..add(const SelectProvinceSearch('')),
        child: ProvinceView(addressDataRepository),
      ),
    );
  }
}

class ProvinceView extends StatefulWidget {
  const ProvinceView(this.addressDataRepository, {super.key});

  final AddressDataRepository addressDataRepository;
  @override
  State<ProvinceView> createState() => _ProvinceViewState();
}

class _ProvinceViewState extends State<ProvinceView> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: TextField(
            key: const Key('searchBox'),
            controller: _controller,
            onChanged: (value) => context
                .read<SelectProvinceBloc>()
                .add(SelectProvinceSearch(value)),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                key: const Key('clearButton'),
                onPressed: () {
                  _controller.clear();
                  context
                      .read<SelectProvinceBloc>()
                      .add(const SelectProvinceSearch(''));
                },
                icon: const Icon(Icons.clear),
              ),
            ),
          ),
        ),
        const Divider(thickness: 1),
        Expanded(
          child: BlocBuilder<SelectProvinceBloc, SelectProvinceState>(
            builder: (context, state) {
              if (state is SelectProvinceSearchResultState) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                      thickness: 1,
                    ),
                    itemCount: state.results.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DistrictScreen(
                                  state.results[index].id,
                                  state.results[index].name_th,
                                  widget.addressDataRepository)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: Text(state.results[index].name_th),
                        ),
                      );
                    },
                  ),
                );
              } else if (state is SelectProvinceNoResultState) {
                return const NotFound();
              } else {
                return Container();
              }
            },
          ),
        ),
      ],
    );
  }
}
