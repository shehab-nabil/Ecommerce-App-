import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gap/gap.dart';
import 'package:tut/app/app_prefs.dart';
import 'package:tut/app/di.dart';
import 'package:tut/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:tut/presentation/forgot_password/view_model/forget_passsword_view_model.dart';
import 'package:tut/presentation/login/view_model/login_view_model.dart';
import 'package:tut/presentation/resource/assets_manager.dart';
import 'package:tut/presentation/resource/routes_manager.dart';
import 'package:tut/presentation/resource/strings_manager.dart';
import 'package:tut/presentation/resource/values_manager.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _LoginViewState();
}

class _LoginViewState extends State<ForgotPasswordView> {
  final ForgetPasswordViewModel _viewModel =
      instance<ForgetPasswordViewModel>();

  final TextEditingController _emailController = TextEditingController();
  // final AppPreferences _appPreferences = instance<AppPreferences>();

  final _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start(); // tell viewmodel, start ur job
    _emailController
        .addListener(() => _viewModel.setEmail(_emailController.text));

    // _viewModel.isUserLoggedInSuccessfullyStreamController.stream
    //     .listen((isLoggedIn) {
    //   if (isLoggedIn) {
    //     SchedulerBinding.instance.addPostFrameCallback((_) {
    //       _appPreferences.setUserLoggedIn();
    //       Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
    //     });
    //   }
    // });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                    () {
                  _viewModel.fogetPassword();
                }) ??
                _getContentWidget();
          }),
    );
  }

  Widget _getContentWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: AppPadding.p100),
      child: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: Image.asset(ImageAssets.splashLogo),
                ),
                const Gap(AppSize.s28),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                      stream: _viewModel.outIsEmailValid,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: AppStrings.emailHint,
                            labelText: AppStrings.emailHint,
                            errorText: (snapshot.data ?? true)
                                ? null
                                : AppStrings.usernameError,
                          ),
                        );
                      }),
                ),
                const Gap(AppSize.s60),
                Padding(
                  padding: const EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<bool>(
                      stream: _viewModel.outAreAllInputsValid,
                      builder: (context, snapshot) {
                        return SizedBox(
                          width: double.infinity,
                          height: AppSize.s40,
                          child: ElevatedButton(
                            onPressed: (snapshot.data ?? false)
                                ? () {
                                    _viewModel.fogetPassword();
                                  }
                                : null,
                            child: const Text(AppStrings.resetPassword),
                          ),
                        );
                      }),
                ),
                const Gap(AppSize.s28),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    AppStrings.resendEmail,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            )),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
