import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/entities/shop.dart';

class ShopCard extends StatelessWidget {

  final Shop shop;

  const ShopCard({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8.r,
            offset: const Offset(0, 4),
          )
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// IMAGE
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(18.r),
            ),
            child: CachedNetworkImage(
              imageUrl: shop.coverPhoto,
              height: 150.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: EdgeInsets.all(12.w),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// NAME + STATUS
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

                  children: [

                    Expanded(
                      child: Text(
                        shop.name,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: shop.isOpen
                            ? Colors.green
                            : Colors.red,
                        borderRadius:
                        BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        shop.isOpen ? "Open" : "Closed",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                        ),
                      ),
                    )
                  ],
                ),

                SizedBox(height: 6.h),

                Text(
                  shop.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[700],
                  ),
                ),

                SizedBox(height: 10.h),

                Row(
                  children: [

                    Icon(Icons.timer,
                        size: 16.sp, color: Colors.grey),

                    SizedBox(width: 4.w),

                    Text("${shop.eta} min"),

                    SizedBox(width: 16.w),

                    Icon(Icons.shopping_bag,
                        size: 16.sp, color: Colors.grey),

                    SizedBox(width: 4.w),

                    Text("Min ${shop.minimumOrder}"),

                  ],
                ),

                SizedBox(height: 6.h),

                Row(
                  children: [

                    Icon(Icons.location_on,
                        size: 16.sp,
                        color: Colors.grey),

                    SizedBox(width: 4.w),

                    Expanded(
                      child: Text(
                        shop.location,
                        style: TextStyle(fontSize: 13.sp),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}