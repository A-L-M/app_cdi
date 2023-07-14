import 'dart:convert';
import 'dart:developer';

import 'package:app_cdi/helpers/globals.dart';
import 'package:app_cdi/models/models.dart';
import 'package:app_cdi/models/seccion_palabras_cdi2.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

class CDI2Provider extends ChangeNotifier {
  List<SeccionPalabrasCDI2> seccionesPalabras = [];

  CDI2Provider() {
    // for (var palabra in seccionesPalabras.first.palabras) {
    //   print('${palabra.nombre},${palabra.sombreada},${palabra.subrayada},1');
    // }
  }

  Future<void> getSeccionesPalabras() async {
    if (seccionesPalabras.isNotEmpty) return;

    try {
      final res = await supabase.from('secciones_palabras_cdi2').select();

      seccionesPalabras = (res as List<dynamic>)
          .map((palabra) => SeccionPalabrasCDI2.fromJson(jsonEncode(palabra)))
          .toList();

      notifyListeners();
    } catch (e) {
      log('Error en getPalabrasSeccion - $e');
    }
  }

  Future<void> getPalabrasSeccion(int seccion) async {
    if (seccionesPalabras[seccion].palabras.isNotEmpty) return;

    try {
      final res = await supabase
          .from('palabra_cdi2_inventario')
          .select()
          .eq('seccion_fk', seccionesPalabras[seccion].seccionId);

      seccionesPalabras[seccion].palabras = (res as List<dynamic>)
          .map((palabra) => PalabraCDI2.fromJson(jsonEncode(palabra)))
          .toList();

      notifyListeners();
    } catch (e) {
      log('Error en getPalabrasSeccion - $e');
    }
  }

  List<PalabraCDI2> palabrasSeccion2 = [
    PalabraCDI2(nombre: 'Abeja', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Águila', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Alacrán', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Animal', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Araña', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Ardilla', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Ballena', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Bicho', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Borrego', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Buey', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Búho', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Burro', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Caballo', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Canario', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Cangrejo', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Caracol', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Cebra', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Cocodrilo', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Conejo', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Elefante', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Foca', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Gallina', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Ganso', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Gato', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Guajolote', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Gusano/lombriz', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Hipopótamo', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Hormiga', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Jirafa', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Oso', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'León', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Lobo', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Mariposa', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Mono', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Mosca', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Mosco', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Paloma', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Pájaro', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Panda', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Pato', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Perico', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Perro', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Pescado', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Pingüino', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Pollito', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Puerco', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Rana', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Rata', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Ratón/hámster', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Tiburón', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Tigre', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Toro', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Tortuga', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Vaca', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Venado', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Víbora', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Zorro', sombreada: true, subrayada: true),
  ];

  List<PalabraCDI2> palabrasSeccion3 = [
    PalabraCDI2(nombre: 'Autobús', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Avión', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Barco', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Bicicleta', sombreada: false, subrayada: true),
    PalabraCDI2(
        nombre: 'Camión de bomberos', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Camión', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Camioneta', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Carreola', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Carro/Coche', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Helicóptero', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Lancha', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Metro', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Moto', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Nave', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Pesero', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Taxi', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Tractor', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Tráiler', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Tren', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Triciclo', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Trineo', sombreada: false, subrayada: false),
  ];

  List<PalabraCDI2> palabrasSeccion4 = [
    PalabraCDI2(nombre: 'Agua', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Arroz', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Atole', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Atún', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Avena', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Azúcar', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Cacahuate/maní', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Café', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Calabaza', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Carne', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Cereal', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Chícharo', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Chicharrón', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Chicle', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Chile', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Chocolate', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Comida', sombreada: false, subrayada: true),
    PalabraCDI2(
        nombre: 'Crema de cacahuate', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Dulce', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Durazno', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Ejotes', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Elote', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Espagueti', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Fresa', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Frijoles', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Galleta', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Gelatina', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Hamburguesa', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Helado/nieve', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Hielo', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Hot cakes', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Huevo', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Jamón', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Jugo', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Leche', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Licuado', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Limonada', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Limón', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Mango', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Mantequilla', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Manzana', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Melón', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Mermelada', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Miel', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Naranja', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Paleta', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Palomitas', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Pan', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Pan dulce', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Papas', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Papitas/frituras', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Pasas', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Pastel', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Pescado', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Piña', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Pizza', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Plátano/bananas', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Pollo', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Quesadilla', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Queso', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Refresco/soda', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Sal', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Salchicha', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Salsa', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Sandía', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Sándwich', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Sopa', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Tacos', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Té', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Torta', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Tortilla', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Uvas', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Vainilla', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Verduras', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Vitaminas', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Yogur', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Zanahoria', sombreada: false, subrayada: false),
  ];

  List<PalabraCDI2> palabrasSeccion5 = [
    PalabraCDI2(nombre: 'Abrigo', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Aretes', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Babero', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Bolsa', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Botas', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Botón', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Bufanda', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Calceta/calcetín', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Calzón', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Camisa', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Camiseta', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Chaleco', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Chamarra', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Chancla/sandalia', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Cierre', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Collar', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Falda', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Gorra', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Guantes', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Lentes', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Medias', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Pantalón', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Pañal', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Pijama', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Playera', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Ropa', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Shorts', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Sombrero', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Sudadera', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Suéter', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Tenis', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Vestido', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Zapato', sombreada: false, subrayada: true),
  ];

  List<PalabraCDI2> palabrasSeccion6 = [
    PalabraCDI2(nombre: 'Barba', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Bigote', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Boca', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Brazo', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Cabeza', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Caca/popo', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Cachete', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Cara', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Ceja', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Chichi/pecho', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Chis/pipi', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Cola', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Dedo', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Dientes', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Garganta/anginas', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Hombro', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Labios', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Lengua', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Mano', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Nalgas/pompas', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Nariz', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Ojos', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Ombligo', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Oreja', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Panza', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Pelo/cabello', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Pene', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Pestañas', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Piernas', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Pies', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Rodilla', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Uña', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Vagina', sombreada: false, subrayada: false),
  ];

  List<PalabraCDI2> palabrasSeccion7 = [
    PalabraCDI2(nombre: 'Andadera', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Bat', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Burbujas', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Colores', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Crayolas', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Cubo', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Cuento', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Globo/bomba', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Hoja/papel', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Juego de té', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Juguete', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Lápiz', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Libro', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Muñeca/o', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Osito', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Patines', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Pelota', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Peluche', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Pinturas', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Piñata', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Pistola', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Plastilina', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Pluma/plumones', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Robot', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Tambor', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Triciclo', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Trompo', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Yoyo', sombreada: true, subrayada: true),
  ];

  List<PalabraCDI2> palabrasSeccion8 = [
    PalabraCDI2(nombre: 'Almohada', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Aspiradora', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Basura', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Bolsa', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Bote', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Botella/mamila', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Caja', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Cámara', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Canasta', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Casete', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Cepillo', sombreada: false, subrayada: true),
    PalabraCDI2(
        nombre: 'Cepillo de dientes', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Cerillos', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Chupón/chupete', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Cigarros', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Clavo', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Cobija', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Cortina', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Cuadro', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Cubeta', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Cuchara', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Cuchillo', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Dinero', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Escoba', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Espejo', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Foco', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Fotos', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Jabón', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Jaula', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Lámpara', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Llave', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Luz', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Martillo', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Medicina', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Mochila', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Olla', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Pañuelo', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Papel', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Peine', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Pasta de dientes', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Película', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Periódico', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Planca', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Plato', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Radio', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Reloj', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Servilleta', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Tapete', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Taza', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Teléfono', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Tenedor', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Tijeras', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Toalla', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Trapo', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Vaso', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Vela', sombreada: false, subrayada: false),
  ];

  List<PalabraCDI2> palabrasSeccion9 = [
    PalabraCDI2(nombre: 'Alacena', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Bacinica', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Banco', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Baño', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Cajón', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Cama', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Champú', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Cochera/garaje', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Cocina', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Comedor', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Computadora', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Cuarto', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Cuna', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Escaleras', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Escritorio', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Estufa', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Horno', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Lavabo', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Lavadora', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Librero', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Mesa', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Mueble', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Patio', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Puerta', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Recámara', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Refrigerador', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Regadera/ducha', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Ropero/clóset', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Sala', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Secadora', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Silla', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Sillón', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Sofá', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Televisión', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Tina', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Ventana', sombreada: false, subrayada: true),
  ];

  List<PalabraCDI2> palabrasSeccion10 = [
    PalabraCDI2(nombre: 'Alberca/piscina', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Árbol', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Bandera', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Cielo', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Coladera', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Columpio', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Estrella', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Flor', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Fuego', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Hojas', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Leña', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Lluvia', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Luna', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Maceta', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Manguera', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Muñeco de nieve', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Nieve', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Nube', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Pala', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Palo', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Pasto', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Piedra', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Planta', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Reja', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Resbaladilla', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Sol', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Tanque', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Techo', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Tierra', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Timbre', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Viento/aire', sombreada: false, subrayada: true),
  ];

  List<PalabraCDI2> palabrasSeccion11 = [
    PalabraCDI2(nombre: 'Autobús', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Avión', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Barco', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Bicicleta', sombreada: false, subrayada: true),
    PalabraCDI2(
        nombre: 'Camión de bomberos', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Camión', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Camioneta', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Carreola', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Carro/Coche', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Helicóptero', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Lancha', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Metro', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Moto', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Nave', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Pesero', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Taxi', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Tractor', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Tráiler', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Tren', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Triciclo', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Trineo', sombreada: false, subrayada: false),
  ];

  List<PalabraCDI2> palabrasSeccion12 = [
    PalabraCDI2(nombre: 'Autobús', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Avión', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Barco', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Bicicleta', sombreada: false, subrayada: true),
    PalabraCDI2(
        nombre: 'Camión de bomberos', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Camión', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Camioneta', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Carreola', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Carro/Coche', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Helicóptero', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Lancha', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Metro', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Moto', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Nave', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Pesero', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Taxi', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Tractor', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Tráiler', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Tren', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Triciclo', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Trineo', sombreada: false, subrayada: false),
  ];

  List<PalabraCDI2> palabrasSeccion13 = [
    PalabraCDI2(nombre: 'Autobús', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Avión', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Barco', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Bicicleta', sombreada: false, subrayada: true),
    PalabraCDI2(
        nombre: 'Camión de bomberos', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Camión', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Camioneta', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Carreola', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Carro/Coche', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Helicóptero', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Lancha', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Metro', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Moto', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Nave', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Pesero', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Taxi', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Tractor', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Tráiler', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Tren', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Triciclo', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Trineo', sombreada: false, subrayada: false),
  ];

  List<PalabraCDI2> palabrasSeccion14 = [
    PalabraCDI2(nombre: 'Autobús', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Avión', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Barco', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Bicicleta', sombreada: false, subrayada: true),
    PalabraCDI2(
        nombre: 'Camión de bomberos', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Camión', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Camioneta', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Carreola', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Carro/Coche', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Helicóptero', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Lancha', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Metro', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Moto', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Nave', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Pesero', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Taxi', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Tractor', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Tráiler', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Tren', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Triciclo', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Trineo', sombreada: false, subrayada: false),
  ];

  List<PalabraCDI2> palabrasSeccion15 = [
    PalabraCDI2(nombre: 'Autobús', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Avión', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Barco', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Bicicleta', sombreada: false, subrayada: true),
    PalabraCDI2(
        nombre: 'Camión de bomberos', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Camión', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Camioneta', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Carreola', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Carro/Coche', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Helicóptero', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Lancha', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Metro', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Moto', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Nave', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Pesero', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Taxi', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Tractor', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Tráiler', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Tren', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Triciclo', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Trineo', sombreada: false, subrayada: false),
  ];

  List<PalabraCDI2> palabrasSeccion16 = [
    PalabraCDI2(nombre: 'Autobús', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Avión', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Barco', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Bicicleta', sombreada: false, subrayada: true),
    PalabraCDI2(
        nombre: 'Camión de bomberos', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Camión', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Camioneta', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Carreola', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Carro/Coche', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Helicóptero', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Lancha', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Metro', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Moto', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Nave', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Pesero', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Taxi', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Tractor', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Tráiler', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Tren', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Triciclo', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Trineo', sombreada: false, subrayada: false),
  ];

  List<PalabraCDI2> palabrasSeccion17 = [
    PalabraCDI2(nombre: 'Autobús', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Avión', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Barco', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Bicicleta', sombreada: false, subrayada: true),
    PalabraCDI2(
        nombre: 'Camión de bomberos', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Camión', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Camioneta', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Carreola', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Carro/Coche', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Helicóptero', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Lancha', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Metro', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Moto', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Nave', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Pesero', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Taxi', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Tractor', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Tráiler', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Tren', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Triciclo', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Trineo', sombreada: false, subrayada: false),
  ];

  List<PalabraCDI2> palabrasSeccion18 = [
    PalabraCDI2(nombre: 'Autobús', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Avión', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Barco', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Bicicleta', sombreada: false, subrayada: true),
    PalabraCDI2(
        nombre: 'Camión de bomberos', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Camión', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Camioneta', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Carreola', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Carro/Coche', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Helicóptero', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Lancha', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Metro', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Moto', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Nave', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Pesero', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Taxi', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Tractor', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Tráiler', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Tren', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Triciclo', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Trineo', sombreada: false, subrayada: false),
  ];

  List<PalabraCDI2> palabrasSeccion19 = [
    PalabraCDI2(nombre: 'Autobús', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Avión', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Barco', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Bicicleta', sombreada: false, subrayada: true),
    PalabraCDI2(
        nombre: 'Camión de bomberos', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Camión', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Camioneta', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Carreola', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Carro/Coche', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Helicóptero', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Lancha', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Metro', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Moto', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Nave', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Pesero', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Taxi', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Tractor', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Tráiler', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Tren', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Triciclo', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Trineo', sombreada: false, subrayada: false),
  ];

  List<PalabraCDI2> palabrasSeccion20 = [
    PalabraCDI2(nombre: 'Autobús', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Avión', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Barco', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Bicicleta', sombreada: false, subrayada: true),
    PalabraCDI2(
        nombre: 'Camión de bomberos', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Camión', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Camioneta', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Carreola', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Carro/Coche', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Helicóptero', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Lancha', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Metro', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Moto', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Nave', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Pesero', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Taxi', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Tractor', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Tráiler', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Tren', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Triciclo', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Trineo', sombreada: false, subrayada: false),
  ];

  List<PalabraCDI2> palabrasSeccion21 = [
    PalabraCDI2(nombre: 'Autobús', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Avión', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Barco', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Bicicleta', sombreada: false, subrayada: true),
    PalabraCDI2(
        nombre: 'Camión de bomberos', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Camión', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Camioneta', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Carreola', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Carro/Coche', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Helicóptero', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Lancha', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Metro', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Moto', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Nave', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Pesero', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Taxi', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Tractor', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Tráiler', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Tren', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Triciclo', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Trineo', sombreada: false, subrayada: false),
  ];

  List<PalabraCDI2> palabrasSeccion22 = [
    PalabraCDI2(nombre: 'Autobús', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Avión', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Barco', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Bicicleta', sombreada: false, subrayada: true),
    PalabraCDI2(
        nombre: 'Camión de bomberos', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Camión', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Camioneta', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Carreola', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Carro/Coche', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Helicóptero', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Lancha', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Metro', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Moto', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Nave', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Pesero', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Taxi', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Tractor', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Tráiler', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Tren', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Triciclo', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Trineo', sombreada: false, subrayada: false),
  ];

  List<PalabraCDI2> palabrasSeccion23 = [
    PalabraCDI2(nombre: 'Autobús', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Avión', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Barco', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Bicicleta', sombreada: false, subrayada: true),
    PalabraCDI2(
        nombre: 'Camión de bomberos', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Camión', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Camioneta', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Carreola', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Carro/Coche', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Helicóptero', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Lancha', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Metro', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Moto', sombreada: false, subrayada: true),
    PalabraCDI2(nombre: 'Nave', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Pesero', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Taxi', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Tractor', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Tráiler', sombreada: true, subrayada: true),
    PalabraCDI2(nombre: 'Tren', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Triciclo', sombreada: false, subrayada: false),
    PalabraCDI2(nombre: 'Trineo', sombreada: false, subrayada: false),
  ];

  void setOpcionPalabra(Opcion opcion, PalabraCDI2 palabra) {
    palabra.opcion = opcion;
    notifyListeners();
  }

  int getTotalC(List<PalabraCDI2> palabras) {
    int total = 0;
    for (var palabra in palabras) {
      if (palabra.subrayada && palabra.opcion == Opcion.comprende) total += 1;
    }
    return total;
  }

  int getTotalCD(List<PalabraCDI2> palabras) {
    int total = 0;
    for (var palabra in palabras) {
      if (palabra.subrayada && palabra.opcion == Opcion.comprendeYDice) {
        total += 1;
      }
    }
    return total;
  }

  int getTotalD(List<PalabraCDI2> palabras) {
    int total = 0;
    for (var palabra in palabras) {
      if (palabra.opcion == Opcion.comprendeYDice) {
        total += 1;
      }
    }
    return total;
  }

  Future<bool> generarReporteExcel(String bebeId) async {
    //Crear excel
    Excel excel = Excel.createExcel();

    List<String> nombreSheets = [
      'ONOMATOPEYAS',
      'ANIMALES',
      'VEHICULOS',
      'ALIMENTOS',
      'ROPA',
      'CUERPO',
      'JUGUETES',
      'ART. HOGAR',
      'MUEBLES',
      'HOGAR',
    ];

    for (var nombre in nombreSheets) {
      excel.copy(excel.getDefaultSheet() ?? 'Sheet1', nombre);
    }

    List<Sheet?> sheets = [];

    excel.delete(excel.getDefaultSheet() ?? 'Sheet1');

    for (var nombre in nombreSheets) {
      sheets.add(excel.sheets[nombre]);
    }

    //1
    List<String> nombresSeccion1 =
        seccionesPalabras[0].palabras.map((e) => e.nombre).toList();

    List<dynamic> row = [];

    for (var palabra in seccionesPalabras[0].palabras) {
      int coding = 0;
      if (palabra.opcion == Opcion.comprende) {
        coding = 1;
      } else if (palabra.opcion == Opcion.comprendeYDice) {
        coding = 2;
      }
      row.add(coding);
    }

    sheets[0]!.appendRow(['ID', ...nombresSeccion1]);
    sheets[0]!.appendRow([bebeId, ...row]);

    //Descargar
    final List<int>? fileBytes = excel.save(fileName: "resultados.xlsx");
    if (fileBytes == null) return false;

    return true;
  }
}
