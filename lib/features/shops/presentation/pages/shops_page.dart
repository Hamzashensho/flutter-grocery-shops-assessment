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

  final TextEditingController _searchController = TextEditingController();

  bool _openOnly = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search shops...",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    cubit.search("");
                    setState(() {});
                  },
                )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
              onChanged: (value) {
                setState(() {});
                debouncer.run(() => cubit.search(value));
              },
            ),

            SizedBox(height: 12.h),

            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Switch(
                        value: _openOnly,
                        onChanged: (value) {
                          setState(() => _openOnly = value);
                          cubit.filterOpen(value);
                        },
                      ),
                      const Text("Open only"),
                    ],
                  ),
                ),

                DropdownButton<String>(
                  underline: const SizedBox(), // Cleaner look
                  hint: const Text("Sort"),
                  icon: const Icon(Icons.sort),
                  items: const [
                    DropdownMenuItem(value: "eta", child: Text("ETA")),
                    DropdownMenuItem(value: "order", child: Text("Min Order")),
                  ],
                  onChanged: (value) {
                    if (value == "eta") {
                      cubit.sortByETA();
                    } else if (value == "order") {
                      cubit.sortByMinimumOrder();
                    }
                  },
                ),

                SizedBox(width: 8.w),

                TextButton(
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _openOnly = false;
                    });
                    cubit.clearFilters();
                  },
                  child: const Text("Clear"),
                )
              ],
            ),

            SizedBox(height: 12.h),

            Expanded(
              child: BlocBuilder<ShopCubit, ShopState>(
                builder: (context, state) {
                  if (state is ShopLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is ShopError) {
                    return Center(child: Text(state.message));
                  }
                  if (state is ShopLoaded) {
                    if (state.shops.isEmpty) {
                      return const Center(child: Text("No Results Found"));
                    }
                    return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.shops.length,
                      separatorBuilder: (_, __) => SizedBox(height: 12.h),
                      itemBuilder: (context, index) {
                        return ShopCard(
                          key: ValueKey(state.shops[index].id), // Key for performance
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