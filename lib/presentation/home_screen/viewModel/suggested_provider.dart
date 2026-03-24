import 'package:riverpod/legacy.dart';
import 'package:touralie33_fo222668a7688/core/network/api_clients.dart';
import 'package:touralie33_fo222668a7688/data/models/suggested_model.dart';
import 'package:touralie33_fo222668a7688/data/repositories/suggest_repository.dart';
import 'package:touralie33_fo222668a7688/data/sources/remote/suggested_api_service.dart';

class SuggestedState {
  final bool isLoading;
  final String? errorMessage;
  final SuggestedModel? suggestedData;

  static const _noErrorMessage = Object();
  static const _noSuggestedData = Object();

  SuggestedState({
    this.errorMessage,
    required this.isLoading,
    this.suggestedData,
  });

  SuggestedState copyWith({
    bool? isLoading,
    Object? errorMessage = _noErrorMessage,
    Object? suggestedData = _noSuggestedData,
  }) {
    return SuggestedState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: identical(errorMessage, _noErrorMessage)
          ? this.errorMessage
          : errorMessage as String?,
      suggestedData: identical(suggestedData, _noSuggestedData)
          ? this.suggestedData
          : suggestedData as SuggestedModel?,
    );
  }
}

class SuggestedProvider extends StateNotifier<SuggestedState> {
  final SuggestRepository repository;

  SuggestedProvider({required this.repository})
      : super(SuggestedState(isLoading: false));

  Future<void> getSuggested() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final response = await repository.suggested();

      state = state.copyWith(
        isLoading: false,
        suggestedData: response,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }
}
final suggestedNotifierProvider = StateNotifierProvider<SuggestedProvider, SuggestedState>((ref) {
  final repository = SuggestRepository(
    resource: SuggestedApiService(apiClient: ApiClient())
  );
  return SuggestedProvider(repository: repository);
});
