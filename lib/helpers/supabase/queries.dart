import 'dart:convert';
import 'dart:developer';

import 'package:app_cdi/helpers/globals.dart';
import 'package:app_cdi/models/models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseQueries {
  static Future<Usuario?> getCurrentUserData() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) return null;

      final PostgrestFilterBuilder query =
          supabase.from('users').select().eq('perfil_usuario_id', user.id);

      final res = await query;

      final userProfile = res[0];
      userProfile['id'] = user.id;
      userProfile['email'] = user.email!;

      final usuario = Usuario.fromJson(jsonEncode(userProfile));

      return usuario;
    } catch (e) {
      log('Error en getCurrentUserData() - $e');
      return null;
    }
  }

  static Future<Configuration?> getDefaultTheme(int themeId) async {
    try {
      final res =
          await supabase.from('theme').select('light, dark').eq('id', themeId);

      return Configuration.fromJson(jsonEncode(res[0]));
    } catch (e) {
      log('Error en getDefaultTheme() - $e');
      return null;
    }
  }

  static Future<Configuration?> getUserTheme() async {
    try {
      if (currentUser == null) return null;
      final res = await supabase
          .from('perfil_usuario')
          .select('configuracion')
          .eq('perfil_usuario_id', currentUser!.id);
      return Configuration.fromJson(jsonEncode(res[0]['configuracion']));
    } catch (e) {
      log('Error en getUserTheme() - $e');
      return null;
    }
  }

  static Future<Assets> getAssets() async {
    Map<String, String> assetMap = {
      'logoColor': 'assets/images/LogoColor.png',
      'logoBlanco': 'assets/images/LogoBlanco.png',
      'bg1': 'assets/images/bg1.png',
      'bgLogin': 'assets/images/bgLogin.png',
    };
    try {
      //Logo Color
      assetMap['logoColor'] =
          supabase.storage.from('assets').getPublicUrl('LogoColor.png');

      assetMap['logoBlanco'] =
          supabase.storage.from('assets').getPublicUrl('LogoBlanco.png');

      //BG 1
      assetMap['bg1'] = supabase.storage.from('assets').getPublicUrl('bg1.png');

      //BG Login
      assetMap['bgLogin'] =
          supabase.storage.from('assets').getPublicUrl('bgLogin.png');

      return Assets.fromMap(assetMap);
    } catch (e) {
      return Assets.fromMap(assetMap);
    }
  }
}
