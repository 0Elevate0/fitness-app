import 'package:fitness_app/utils/common_widgets/blurred_layer_view.dart';
import 'package:fitness_app/utils/common_widgets/custom_app_bar.dart';
import 'package:fitness_app/utils/common_widgets/loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlurredLayerView(
      child: SafeArea(
        child: Column(
          children: [
            const RSizedBox(height: 12),
            const CustomAppBar(automaticallyImplyLeading: true),
            Expanded(
              child: LoadingCircle(
                circleColor: theme.colorScheme.primary,
                width: 30.r,
                height: 30.r,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
