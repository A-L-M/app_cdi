import 'package:app_cdi/helpers/globals.dart';
import 'package:app_cdi/pages/widgets/hover_icon_widget.dart';
import 'package:app_cdi/pages/widgets/top_menu/editar_perfil_popup/editar_perfil_popup.dart';
import 'package:app_cdi/provider/providers.dart';
import 'package:app_cdi/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopMenuWidget extends StatefulWidget {
  const TopMenuWidget({
    Key? key,
    this.title = '',
    this.titleSize = 0.0255,
  }) : super(key: key);

  final String title;
  final double titleSize;

  @override
  State<TopMenuWidget> createState() => _TopMenuWidgetState();
}

class _TopMenuWidgetState extends State<TopMenuWidget> {
  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);

    if (currentUser == null) {
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.22,
              ),
              Expanded(
                child: Text(
                  widget.title,
                  style: AppTheme.of(context).title1.override(
                        useGoogleFonts: false,
                        fontSize: 26,
                        fontFamily: 'Bicyclette-Light',
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(width: 0.0065 * MediaQuery.of(context).size.width),
                  SizedBox(width: 0.0065 * MediaQuery.of(context).size.width),
                  InkWell(
                    child: Tooltip(
                      message: 'Cerrar Sesión',
                      child: HoverIconWidget(
                        icon: Icons.power_settings_new_outlined,
                        size: 0.05 * MediaQuery.of(context).size.height,
                      ),
                    ),
                    onTap: () async {
                      await userState.logout();
                    },
                  ),
                  SizedBox(width: 0.0065 * MediaQuery.of(context).size.width),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 17, vertical: 10),
                        child: Text(
                          currentUser!.nombreCompleto,
                          style: AppTheme.of(context).bodyText1.override(
                                fontFamily: 'Gotham-Light',
                                fontSize:
                                    0.02 * MediaQuery.of(context).size.height,
                                fontWeight: FontWeight.w400,
                                useGoogleFonts: false,
                              ),
                        ),
                      ),
                      onTap: () async {
                        userState.initPerfilUsuario();
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return const EditarPerfilPopup();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(
            height: 2,
            thickness: 1,
            color: Color(0XFFB6B6B6),
          ),
        ],
      ),
    );
  }
}
