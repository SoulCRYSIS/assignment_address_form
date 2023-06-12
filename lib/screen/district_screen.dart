import 'package:assignment_address_form/bloc/select_district/select_district_bloc.dart';
import 'package:assignment_address_form/screen/subdistrict_screen.dart';
import 'package:assignment_address_form/widget/not_found.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/address_data_repository.dart';

class DistrictScreen extends StatelessWidget {
  const DistrictScreen(
      this.provinceId, this.province, this.addressDataRepository,
      {super.key});
  final int provinceId;
  final String province;
  final AddressDataRepository addressDataRepository;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Select District'),
      ),
      body: BlocProvider(
        create: (_) => SelectDistrictBloc(provinceId, addressDataRepository)
          ..add(const SelectDistrictSearch('')),
        child: DistrictView(provinceId, province, addressDataRepository),
      ),
    );
  }
}

class DistrictView extends StatefulWidget {
  const DistrictView(this.provinceId, this.province, this.addressDataRepository,
      {super.key});

  final int provinceId;
  final String province;
  final AddressDataRepository addressDataRepository;

  @override
  State<DistrictView> createState() => _DistrictViewState();
}

class _DistrictViewState extends State<DistrictView> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _controller,
            onChanged: (value) => context
                .read<SelectDistrictBloc>()
                .add(SelectDistrictSearch(value)),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                onPressed: () {
                  _controller.clear();
                  context
                      .read<SelectDistrictBloc>()
                      .add(const SelectDistrictSearch(''));
                },
                icon: const Icon(Icons.clear),
              ),
            ),
          ),
        ),
        const Divider(thickness: 1),
        Expanded(
          child: BlocBuilder<SelectDistrictBloc, SelectDistrictState>(
            builder: (context, state) {
              if (state is SelectDistrictSearchResultState) {
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
                              builder: (context) => SubdistrictScreen(
                                  state.results[index].id,
                                  state.results[index].name_th,
                                  widget.province,
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
              } else if (state is SelectDistrictNoResultState) {
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
