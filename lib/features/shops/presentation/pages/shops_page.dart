import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop/core/utils/debouncer.dart';
import 'package:shop/features/shops/presentation/bloc/shops_cubit/shop_cubit.dart';
import 'package:shop/features/shops/presentation/widgets/shop_card.dart';



class ShopsPage extends StatefulWidget {
  const ShopsPage({super.key});

  @override
  State<ShopsPage> createState() => _ShopsPageState();
}

class _ShopsPageState extends State<ShopsPage> {

  final debouncer = Debouncer(milliseconds: 400);
  bool openOnly = false;

  @override
  Widget build(BuildContext context) {

    final cubit = context.read<ShopCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Grocery Shops"),
        centerTitle: true,
      ),

      body: Padding(
        padding: EdgeInsets.all(16.w),

        child: Column(
          children: [

            /// SEARCH FIELD
            TextField(
              decoration: InputDecoration(
                hintText: "Search shops...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
              onChanged: (value) {
                debouncer.run(() {
                  cubit.search(value);
                });
              },
            ),

            SizedBox(height: 12.h),

            /// FILTER + SORT ROW
            Row(
              children: [

                /// OPEN FILTER
                Expanded(
                  child: Row(
                    children: [
                      Switch(
                        value: openOnly,
                        onChanged: (value) {
                          setState(() => openOnly = value);
                          cubit.filterOpen(value);
                        },
                      ),
                      const Text("Open only"),
                    ],
                  ),
                ),

                /// SORT DROPDOWN
                DropdownButton<String>(
                  hint: const Text("Sort"),
                  items: const [
                    DropdownMenuItem(
                      value: "eta",
                      child: Text("ETA"),
                    ),
                    DropdownMenuItem(
                      value: "order",
                      child: Text("Minimum Order"),
                    ),
                  ],
                  onChanged: (value) {
                    if (value == "eta") {
                      cubit.sortByETA();
                    } else {
                      cubit.sortByMinimumOrder();
                    }
                  },
                ),

                SizedBox(width: 8.w),

                /// CLEAR BUTTON
                ElevatedButton(
                  onPressed: () {
                    cubit.clearFilters();
                  },
                  child: const Text("Clear"),
                )
              ],
            ),

            SizedBox(height: 12.h),

            /// SHOPS LIST
            Expanded(
              child: BlocBuilder<ShopCubit, ShopState>(
                builder: (context, state) {

                  if (state is ShopLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is ShopError) {
                    return Center(
                      child: Text(state.message),
                    );
                  }

                  if (state is ShopLoaded) {

                    if (state.shops.isEmpty) {
                      return const Center(
                        child: Text("No Results Found"),
                      );
                    }

                    return ListView.separated(
                      itemCount: state.shops.length,
                      separatorBuilder: (_, __) =>
                          SizedBox(height: 12.h),
                      itemBuilder: (context, index) {
                        return ShopCard(
                          shop: state.shops[index],
                        );
                      },
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}