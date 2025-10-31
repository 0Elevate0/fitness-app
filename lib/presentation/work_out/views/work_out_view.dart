import 'package:fitness_app/core/constants/app_images.dart';
import 'package:fitness_app/core/di/di.dart';
import 'package:fitness_app/domain/entities/muscle_with_group_argument/muscle_with_group_argument.dart';
import 'package:fitness_app/presentation/work_out/views/widgets/work_out_view_body.dart';
import 'package:fitness_app/presentation/work_out/views_model/work_out_cubit.dart';
import 'package:fitness_app/presentation/work_out/views_model/work_out_intent.dart';
import 'package:fitness_app/utils/common_widgets/blurred_layer_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkOutView extends StatelessWidget {
  const WorkOutView({super.key, this.groupArgument});

  final MuscleWithGroupArgument? groupArgument;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WorkOutCubit>(
      create: (context) =>
          getIt.get<WorkOutCubit>()
            ..doIntent(intent: InitWorkOutIntent(groupArgument)),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.homeBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: const BlurredLayerView(
          child: RPadding(
            padding: EdgeInsets.all(8.0),
            child: WorkOutViewBody(),
          ),
        ),
      ),
    );
  }
}
