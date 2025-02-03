import 'package:base_class_gen/core/ext/build_context_ext.dart';
import 'package:feelmeweb/data/models/response/roles_response.dart';
import 'package:feelmeweb/presentation/buttons/base_text_button.dart';
import 'package:feelmeweb/presentation/widgets/base_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/models/request/create_user_body.dart';

typedef CreateUserCallback = void Function(CreateUserBody);

class CreateUserDialog extends StatefulWidget {
  const CreateUserDialog(
      {super.key, required this.roles, required this.createUserCallback});

  final CreateUserCallback createUserCallback;
  final List<RolesResponse> roles;

  @override
  State<CreateUserDialog> createState() => _CreateUserDialogState();
}

class _CreateUserDialogState extends State<CreateUserDialog> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late var selectedRole = widget.roles.first;
  bool _obscure = true;

  void toggleShowPassword() {
    setState(() {
      _obscure = !_obscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BaseTextField(
                controller: nameController, helperText: 'Имя пользователя'),
            const SizedBox(height: 12),
            BaseTextField(controller: emailController, helperText: 'E-mail'),
            const SizedBox(height: 12),
            BaseTextField(
                controller: passwordController,
                helperText: 'Пароль',
                obscure: _obscure,
                onObscureToggle: toggleShowPassword),
            const SizedBox(height: 12),
            Row(
              children: [
                Text('Выберите роль: ',
                    style: TextStyle(fontSize: 16, color: Colors.grey[400])),
                Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0, 8.0, 0),
                    child: DropdownButton(
                        value: selectedRole.id,
                        onChanged: (newValue) {
                          setState(() {
                            selectedRole = widget.roles
                                .firstWhere((e) => e.id == newValue);
                          });
                        },
                        items: widget.roles.map((e) {
                          return DropdownMenuItem(
                              value: e.id,
                              child: SizedBox(width: 200, child: Text(e.name)));
                        }).toList(),
                        focusColor: Colors.white,
                        dropdownColor: Colors.white,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16)))
              ],
            ),
            const SizedBox(height: 12),
            Flexible(
              child: SizedBox(
                width: context.currentSize.width * 0.33,
                child: Row(children: [
                  Expanded(
                      child: BaseTextButton(
                          buttonText: 'Отмена',
                          onTap: () {
                            context.navigateUp(arg: true);
                          },
                          enabled: true,
                          buttonColor: Colors.redAccent)),
                  const SizedBox(width: 20),
                  Expanded(
                      child: BaseTextButton(
                          buttonText: 'Добавить',
                          onTap: () async {
                            widget.createUserCallback(CreateUserBody(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                typeId: selectedRole.id));
                            context.navigateUp();
                          },
                          enabled: true))
                ]),
              ),
            )
          ]),
    );
  }
}
