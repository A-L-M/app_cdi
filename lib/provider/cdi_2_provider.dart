import 'package:app_cdi/models/models.dart';
import 'package:flutter/material.dart';

class CDI2Provider extends ChangeNotifier {
  List<Palabra> palabrasSeccion1 = [
    Palabra(nombre: '¡Am!', icplim: false, subrayada: false),
    Palabra(nombre: '¡Auch!', icplim: true, subrayada: true),
    Palabra(nombre: '¡Ay!', icplim: false, subrayada: true),
    Palabra(nombre: 'Bee / me', icplim: false, subrayada: true),
    Palabra(nombre: 'Chuu-chuu', icplim: true, subrayada: true),
    Palabra(nombre: 'Cua-cuá', icplim: false, subrayada: true),
    Palabra(nombre: 'Gordogordo', icplim: true, subrayada: true),
    Palabra(nombre: 'Grrr', icplim: true, subrayada: true),
    Palabra(nombre: 'Gua-guá', icplim: false, subrayada: true),
    Palabra(nombre: 'Miau', icplim: false, subrayada: true),
    Palabra(nombre: 'Mmmmm', icplim: true, subrayada: true),
    Palabra(nombre: 'Muu', icplim: false, subrayada: true),
    Palabra(nombre: 'Oinc-oinc', icplim: true, subrayada: true),
    Palabra(nombre: '¡Pazz!', icplim: true, subrayada: true),
    Palabra(nombre: '¡Pío-pío!', icplim: false, subrayada: true),
    Palabra(nombre: 'Pi-pí', icplim: false, subrayada: false),
    Palabra(nombre: '¡Pum!', icplim: false, subrayada: false),
    Palabra(nombre: 'Qui-qui-ri-quí', icplim: false, subrayada: true),
    Palabra(nombre: 'Tic-tac', icplim: true, subrayada: true),
    Palabra(nombre: 'Tu-tú', icplim: false, subrayada: false),
  ];

  List<Palabra> palabrasSeccion2 = [
    Palabra(nombre: 'Abeja', icplim: false, subrayada: true),
    Palabra(nombre: 'Águila', icplim: true, subrayada: true),
    Palabra(nombre: 'Alacrán', icplim: true, subrayada: true),
    Palabra(nombre: 'Animal', icplim: false, subrayada: true),
    Palabra(nombre: 'Araña', icplim: false, subrayada: true),
    Palabra(nombre: 'Ardilla', icplim: false, subrayada: true),
    Palabra(nombre: 'Ballena', icplim: true, subrayada: true),
    Palabra(nombre: 'Bicho', icplim: false, subrayada: false),
    Palabra(nombre: 'Borrego', icplim: false, subrayada: true),
    Palabra(nombre: 'Buey', icplim: false, subrayada: false),
    Palabra(nombre: 'Búho', icplim: false, subrayada: false),
    Palabra(nombre: 'Burro', icplim: false, subrayada: false),
    Palabra(nombre: 'Caballo', icplim: false, subrayada: true),
    Palabra(nombre: 'Canario', icplim: true, subrayada: true),
    Palabra(nombre: 'Cangrejo', icplim: true, subrayada: true),
    Palabra(nombre: 'Caracol', icplim: true, subrayada: true),
    Palabra(nombre: 'Cebra', icplim: false, subrayada: false),
    Palabra(nombre: 'Cocodrilo', icplim: false, subrayada: true),
    Palabra(nombre: 'Conejo', icplim: false, subrayada: true),
    Palabra(nombre: 'Elefante', icplim: false, subrayada: true),
    Palabra(nombre: 'Foca', icplim: false, subrayada: false),
    Palabra(nombre: 'Gallina', icplim: false, subrayada: false),
    Palabra(nombre: 'Ganso', icplim: false, subrayada: true),
    Palabra(nombre: 'Gato', icplim: false, subrayada: true),
    Palabra(nombre: 'Guajolote', icplim: false, subrayada: true),
    Palabra(nombre: 'Gusano/lombriz', icplim: true, subrayada: true),
    Palabra(nombre: 'Hipopótamo', icplim: false, subrayada: false),
    Palabra(nombre: 'Hormiga', icplim: false, subrayada: true),
    Palabra(nombre: 'Jirafa', icplim: false, subrayada: true),
    Palabra(nombre: 'Oso', icplim: false, subrayada: true),
    Palabra(nombre: 'León', icplim: false, subrayada: true),
    Palabra(nombre: 'Lobo', icplim: false, subrayada: true),
    Palabra(nombre: 'Mariposa', icplim: false, subrayada: true),
    Palabra(nombre: 'Mono', icplim: false, subrayada: true),
    Palabra(nombre: 'Mosca', icplim: false, subrayada: true),
    Palabra(nombre: 'Mosco', icplim: false, subrayada: true),
    Palabra(nombre: 'Paloma', icplim: true, subrayada: true),
    Palabra(nombre: 'Pájaro', icplim: false, subrayada: true),
    Palabra(nombre: 'Panda', icplim: true, subrayada: true),
    Palabra(nombre: 'Pato', icplim: false, subrayada: true),
    Palabra(nombre: 'Perico', icplim: true, subrayada: true),
    Palabra(nombre: 'Perro', icplim: false, subrayada: true),
    Palabra(nombre: 'Pescado', icplim: false, subrayada: true),
    Palabra(nombre: 'Pingüino', icplim: false, subrayada: true),
    Palabra(nombre: 'Pollito', icplim: false, subrayada: true),
    Palabra(nombre: 'Puerco', icplim: false, subrayada: true),
    Palabra(nombre: 'Rana', icplim: false, subrayada: true),
    Palabra(nombre: 'Rata', icplim: true, subrayada: true),
    Palabra(nombre: 'Ratón/hámster', icplim: false, subrayada: true),
    Palabra(nombre: 'Tiburón', icplim: true, subrayada: true),
    Palabra(nombre: 'Tigre', icplim: false, subrayada: true),
    Palabra(nombre: 'Toro', icplim: true, subrayada: true),
    Palabra(nombre: 'Tortuga', icplim: false, subrayada: true),
    Palabra(nombre: 'Vaca', icplim: false, subrayada: true),
    Palabra(nombre: 'Venado', icplim: false, subrayada: true),
    Palabra(nombre: 'Víbora', icplim: false, subrayada: false),
    Palabra(nombre: 'Zorro', icplim: true, subrayada: true),
  ];

  void setOpcionPalabra(Opcion opcion, Palabra palabra) {
    palabra.opcion = opcion;
    notifyListeners();
  }

  int getTotalC(List<Palabra> palabras) {
    int total = 0;
    for (var palabra in palabras) {
      if (palabra.subrayada && palabra.opcion == Opcion.comprende) total += 1;
    }
    return total;
  }

  int getTotalCD(List<Palabra> palabras) {
    int total = 0;
    for (var palabra in palabras) {
      if (palabra.subrayada && palabra.opcion == Opcion.comprendeYDice) {
        total += 1;
      }
    }
    return total;
  }

  int getTotalD(List<Palabra> palabras) {
    int total = 0;
    for (var palabra in palabras) {
      if (!palabra.subrayada && palabra.opcion == Opcion.comprendeYDice) {
        total += 1;
      }
    }
    return total;
  }
}
