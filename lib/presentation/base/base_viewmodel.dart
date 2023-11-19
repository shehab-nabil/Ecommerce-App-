abstract class BaseViewModel extends BaseViewMoedlInput
    with BaseViewModelOutput {}

abstract class BaseViewMoedlInput {
  void start();
  void dispose();
}

mixin BaseViewModelOutput {}
