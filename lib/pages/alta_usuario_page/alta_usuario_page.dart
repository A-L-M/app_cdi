import 'package:app_cdi/pages/alta_usuario_page/widgets/header.dart';
import 'package:app_cdi/pages/alta_usuario_page/widgets/input_field_label.dart';
import 'package:app_cdi/pages/alta_usuario_page/widgets/rol_dropdown.dart';
import 'package:app_cdi/pages/widgets/top_menu/top_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';

import 'package:app_cdi/pages/widgets/side_menu/side_menu.dart';
import 'package:app_cdi/provider/usuarios_provider.dart';
import 'package:app_cdi/theme/theme.dart';

class AltaUsuarioPage extends StatefulWidget {
  const AltaUsuarioPage({Key? key}) : super(key: key);

  @override
  State<AltaUsuarioPage> createState() => _AltaUsuarioPageState();
}

class _AltaUsuarioPageState extends State<AltaUsuarioPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final UsuariosProvider provider = Provider.of<UsuariosProvider>(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).primaryBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                //MENU
                const TopMenuWidget(
                  title: 'Alta de Usuario',
                ),

                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SideMenuWidget(),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                          child: Column(
                            children: [
                              //HEADER ALTA DE USUARIOS
                              AltaUsuarioHeader(formKey: formKey),

                              //Formulario
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(150, 30, 150, 0),
                                child: Form(
                                  key: formKey,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 500,
                                              padding: const EdgeInsets.only(top: 20),
                                              child: Stack(
                                                children: [
                                                  if (provider.nombreController.text.isEmpty)
                                                    const InputFieldLabel(
                                                      label: 'Nombre',
                                                    ),
                                                  TextFormField(
                                                    controller: provider.nombreController,
                                                    keyboardType: TextInputType.name,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter.allow(
                                                        RegExp(r"^[a-zA-ZÀ-ÿ´ ]+"),
                                                      )
                                                    ],
                                                    onChanged: (_) {
                                                      setState(() {});
                                                    },
                                                    validator: (value) {
                                                      if (value == null || value.isEmpty) {
                                                        return 'El nombre es obligatorio';
                                                      }
                                                      return null;
                                                    },
                                                    decoration: InputDecoration(
                                                      labelStyle: AppTheme.of(context).bodyText2,
                                                      enabledBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: AppTheme.of(context).primaryColor,
                                                          width: 1.5,
                                                        ),
                                                      ),
                                                      focusedBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: AppTheme.of(context).primaryColor,
                                                          width: 1.5,
                                                        ),
                                                      ),
                                                    ),
                                                    style: AppTheme.of(context).bodyText2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(top: 20),
                                              width: 500,
                                              child: Stack(
                                                children: [
                                                  if (provider.apellidosController.text.isEmpty)
                                                    const InputFieldLabel(
                                                      label: 'Apellidos',
                                                    ),
                                                  TextFormField(
                                                    controller: provider.apellidosController,
                                                    keyboardType: TextInputType.name,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter.allow(
                                                        RegExp(r"^[a-zA-ZÀ-ÿ´ ]+"),
                                                      )
                                                    ],
                                                    onChanged: (_) {
                                                      setState(() {});
                                                    },
                                                    validator: (value) {
                                                      if (value == null || value.isEmpty) {
                                                        return 'Los apellidos son obligatorios';
                                                      }
                                                      return null;
                                                    },
                                                    decoration: InputDecoration(
                                                      labelStyle: AppTheme.of(context).bodyText2,
                                                      enabledBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: AppTheme.of(context).primaryColor,
                                                          width: 1.5,
                                                        ),
                                                      ),
                                                      focusedBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: AppTheme.of(context).primaryColor,
                                                          width: 1.5,
                                                        ),
                                                      ),
                                                    ),
                                                    style: AppTheme.of(context).bodyText2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(top: 20),
                                              width: 500,
                                              child: Stack(
                                                children: [
                                                  if (provider.correoController.text.isEmpty)
                                                    const InputFieldLabel(
                                                      label: 'Correo',
                                                    ),
                                                  TextFormField(
                                                    controller: provider.correoController,
                                                    keyboardType: TextInputType.emailAddress,
                                                    onChanged: (_) {
                                                      setState(() {});
                                                    },
                                                    validator: (value) {
                                                      if (value == null || value.isEmpty) {
                                                        return 'El correo es obligatorio';
                                                      } else if (!EmailValidator.validate(value)) {
                                                        return 'El correo no es válido';
                                                      }
                                                      return null;
                                                    },
                                                    decoration: InputDecoration(
                                                      labelStyle: AppTheme.of(context).bodyText2,
                                                      enabledBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: AppTheme.of(context).primaryColor,
                                                          width: 1.5,
                                                        ),
                                                      ),
                                                      focusedBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: AppTheme.of(context).primaryColor,
                                                          width: 1.5,
                                                        ),
                                                      ),
                                                    ),
                                                    style: AppTheme.of(context).bodyText2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                                              child: RolDropDown(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
