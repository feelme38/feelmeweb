import 'package:feelmeweb/core/enum/auth_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:feelmeweb/presentation/buttons/base_text_button.dart';
import 'package:feelmeweb/presentation/theme/theme_colors.dart';
import 'package:feelmeweb/presentation/widgets/base_text_field.dart';
import 'package:feelmeweb/provider/network/log_writer_interceptor.dart';
import '../../presentation/base_screen/base_screen.dart';
import '../../presentation/theme/dimen.dart';
import '../../presentation/theme/drawables.dart';
import 'auth_view_model.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  static Widget create() => ChangeNotifierProvider(
      create: (context) => AuthViewModel(), child: const AuthPage());

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<AuthViewModel>();
    var consumableVm = context.watch<AuthViewModel>();
    return BaseScreen<AuthViewModel>(
        needBackButton: false,
        needAppBar: false,
        child: Container(
            decoration: const BoxDecoration(color: AppColor.background),
            child: SafeArea(
                child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CupertinoButton(
                                    child: SvgPicture.asset(
                                        Drawables.settings),
                                    onPressed: () {})
                              ]),
                          Column(mainAxisSize: MainAxisSize.min, children: [
                            GestureDetector(
                                onTap: () => readLog(context: context),
                                child: SvgPicture.asset(Drawables.logo)),
                          ]),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: Dimen.size16),
                            child: Column(children: [
                              BaseTextField(
                                hasFocus: consumableVm.loginHasFocus,
                                helperText: "Логин",
                                node: viewModel.loginNode,
                                background: AppColor.background2,
                                borderColor: AppColor.basicLightGrey,
                                textColor: Colors.black.withOpacity(0.5),
                                maxLines: 1,
                                danger: consumableVm.authFailed,
                                controller: viewModel.loginController,
                                onSubmit: (_) =>
                                    viewModel.passwordNode.requestFocus(),
                                onTextChange: (String value) {
                                  viewModel.textControllerChange();
                                },
                              ),
                              const SizedBox(height: Dimen.size12),
                              BaseTextField(
                                  hasFocus: context
                                      .watch<AuthViewModel>()
                                      .passHasFocus,
                                  node: viewModel.passwordNode,
                                  background: AppColor.background2,
                                  borderColor: AppColor.basicLightGrey,
                                  textColor: Colors.black.withOpacity(0.5),
                                  maxLines: 1,
                                  dangerText: "Неверный логин и/или пароль",
                                  danger: consumableVm.authFailed,
                                  obscure: consumableVm.obscurePassword,
                                  onObscureToggle: viewModel.updateObscure,
                                  onSubmit: (s) async {},
                                  helperText: "Пароль",
                                  controller: viewModel.passwordController,
                                  onTextChange: (String value) {
                                    viewModel.textControllerChange();
                                  }),
                              const SizedBox(height: Dimen.size2),
                            ]),
                          ),
                          const SizedBox(),
                          const SizedBox(),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(Dimen.size16),
                                child: BaseTextButton(
                                    buttonText: "Войти",
                                    onTap: () async {
                                      var result = await viewModel.authenticate();
                                      if(result == AuthResult.success) {
                                        context.pushReplacement("/home");
                                      }
                                    },
                                    weight: FontWeight.w500,
                                    fontSize: 18,
                                    enabled: consumableVm.isLoginEnabled,
                                    textColor: Colors.white,
                                    buttonColor: AppColor.primary),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: Dimen.size16),
                                child: Text(consumableVm.versionName,
                                    style: GoogleFonts.notoSans(
                                      color: AppColor.basicDarkGrey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ),
                            ],
                          ),
                        ])))));
  }
}
