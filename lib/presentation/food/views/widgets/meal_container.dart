import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/presentation/food/views/widgets/meal_error_container.dart';
import 'package:fitness_app/utils/common_widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class MealContainer extends StatelessWidget{
  final String mealType;
  final String mealPhotoUrl;

  const MealContainer({super.key, required this.mealType, required this.mealPhotoUrl});
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData=Theme.of(context);
   return InkWell(
     child: Container(
       decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(20.sp),
        // image: DecorationImage(
          // image: CachedNetworkImageProvider(mealPhotoUrl,
          // )//NetworkImage(mealPhotoUrl),

         ),

      // ),
       child: ClipRRect(
         borderRadius: BorderRadius.circular(20.sp),
         child: Stack(
           fit: StackFit.expand,
           children: [
             CachedNetworkImage(imageUrl: mealPhotoUrl,
             fit: BoxFit.cover,
             placeholder: (context,url)=>Center(
               child: ShimmerEffect(width: 104.r, height: 104.r, radius: 20.r),
             ),
             errorWidget: (context,url,error)=>MealErrorContainer(),)
             ,Align(
             alignment: Alignment.bottomCenter,
             child: Text(mealType,
               style: themeData.textTheme.bodyLarge!.copyWith(
                 color: Colors.white,
                 fontWeight: FontWeight.w700,

               ),
               maxLines: 2,
               overflow: TextOverflow.ellipsis,
               textAlign: TextAlign.center,
             ),
           ),]
         ),
       ),
     ),
   );
  }

}