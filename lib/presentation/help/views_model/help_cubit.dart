import 'package:fitness_app/api/client/api_result.dart';
import 'package:fitness_app/core/state_status/state_status.dart';
import 'package:fitness_app/domain/entities/account/help/help_entity.dart';
import 'package:fitness_app/domain/use_cases/help/help_use_case.dart';
import 'package:fitness_app/presentation/help/views_model/help_intent.dart';
import 'package:fitness_app/presentation/help/views_model/help_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HelpCubit extends Cubit<HelpState> {
  final HelpUseCase _helpUseCase;
  HelpCubit(this._helpUseCase) : super(const HelpState());

  Future<void> doIntent({required HelpIntent intent}) async {
    switch (intent) {
      case FetchHelpDataIntent():
        await _fetchHelpData();
        break;
    }
  }

  Future<void> _fetchHelpData() async {
    emit(state.copyWith(helpStatus: const StateStatus.loading()));
    final result = await _helpUseCase.invoke();
    if (isClosed) return;
    switch (result) {
      case Success<HelpEntity>():
        emit(state.copyWith(helpStatus: StateStatus.success(result.data)));
        break;
      case Failure<HelpEntity>():
        emit(
          state.copyWith(
            helpStatus: StateStatus.failure(result.responseException),
          ),
        );
        break;
    }
  }
}
