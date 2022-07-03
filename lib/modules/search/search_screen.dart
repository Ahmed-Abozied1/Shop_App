// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/component/component_screen.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();
    return BlocProvider(
        create: (context) => SearchCubit(),
        child: BlocConsumer<SearchCubit, SearchStates>(
            builder: (context, state) {
              return Scaffold(
                  appBar: AppBar(),
                  body: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(children: [
                        defaultFormFeild(
                            prefixIcon: Icons.search,
                            controller: searchController,
                            onSubmit: (String? text) {
                              SearchCubit.get(context).search(text!);
                            },
                            validator: (String? text) {
                              if (text!.isEmpty) {
                                return 'Please enter text to search';
                              }
                              return null;
                            },
                            label: 'Search',
                            type: TextInputType.text),
                        SizedBox(
                          height: 15,
                        ),
                        if (state is SearchLoadingState)
                          LinearProgressIndicator(),
                           SizedBox(
                          height: 15,
                        ),
                        if (State is SearchSuccessState) 
                          
                        
                           Expanded(
                             child: ListView.separated(
                                         physics: BouncingScrollPhysics(),
                                         itemBuilder: (context, index) => buildListProduct(SearchCubit.get(context).searchModel.data!.data[index],context,isOldPrice: true),
                                         
                                             
                                         separatorBuilder: (context, index) => Divider(),
                                         itemCount: SearchCubit.get(context).searchModel.data!.data.length),
                           ),
                      ]),
                    ),
                  ));
            },
            listener: (context, state) {}));
  }
}
