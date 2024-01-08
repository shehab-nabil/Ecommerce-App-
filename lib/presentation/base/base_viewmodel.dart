import 'dart:async';

import 'package:tut/presentation/common/state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel extends BaseViewMoedlInput
    with BaseViewModelOutput {
  final StreamController _inputstreamController =
      StreamController<FlowState>.broadcast();
  @override
  void dispose() {
    _inputstreamController.close();
  }

  @override
  Sink get inputState => _inputstreamController.sink;

  @override
  Stream<FlowState> get outputState =>
      _inputstreamController.stream.map((flowState) => flowState);
}

abstract class BaseViewMoedlInput {
  void start();
  void dispose();

  Sink get inputState;
}

mixin BaseViewModelOutput {
  Stream<FlowState> get outputState;
}
