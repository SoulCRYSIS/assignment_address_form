import 'package:assignment_address_form/bloc/select_address_cubit.dart';
import 'package:assignment_address_form/model/address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/select_subdistrict/select_subdistrict_bloc.dart';
import '../repository/address_data_repository.dart';
import '../widget/not_found.dart';

class SubdistrictScreen extends StatelessWidget {
  const SubdistrictScreen(
      this.districtId, this.district, this.province, this.addressDataRepository,
      {super.key});
  final int districtId;
  final String district;
  final String province;
  final AddressDataRepository addressDataRepository;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Select Subdistrict'),
      ),
      body: BlocProvider(
        create: (_) => SelectSubdistrictBloc(districtId, addressDataRepository)
          ..add(const SelectSubdistrictSearch('')),
        child: SubdistrictView(districtId, district, province),
      ),
    );
  }
}

class SubdistrictView extends StatefulWidget {
  const SubdistrictView(this.districtId, this.district, this.province,
      {super.key});

  final int districtId;
  final String district;
  final String province;

  @override
  State<SubdistrictView> createState() => _SubdistrictViewState();
}

class _SubdistrictViewState extends State<SubdistrictView> {
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
                .read<SelectSubdistrictBloc>()
                .add(SelectSubdistrictSearch(value)),
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
                      .read<SelectSubdistrictBloc>()
                      .add(const SelectSubdistrictSearch(''));
                },
                icon: const Icon(Icons.clear),
              ),
            ),
          ),
        ),
        const Divider(thickness: 1),
        Expanded(
          child: BlocBuilder<SelectSubdistrictBloc, SelectSubdistrictState>(
            builder: (context, state) {
              if (state is SelectSubdistrictSearchResultState) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                      thickness: 1,
                    ),
                    itemCount: state.results.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          context.read<SelectAddressCubit>().setAddress(Address(
                              widget.province,
                              widget.district,
                              state.results[index].name_th));

                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: Text(state.results[index].name_th),
                        ),
                      );
                    },
                  ),
                );
              } else if (state is SelectSubdistrictNoResultState) {
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
