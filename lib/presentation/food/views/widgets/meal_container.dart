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
         image: DecorationImage(
           image: NetworkImage(mealPhotoUrl),
           fit: BoxFit.cover,
         ),
       ),
       child: Align(
         alignment: Alignment.bottomCenter,
         child: Text(mealType,
           style: themeData.textTheme.bodyLarge!.copyWith(
             color: Colors.white,
             fontWeight: FontWeight.w700,

           ),
         ),
       ),
     ),
   );
  }

}