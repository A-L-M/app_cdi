enum Opcion { comprende, comprendeYDice, noContesto }

class Palabra {
  Palabra({
    required this.nombre,
    required this.icplim,
    required this.subrayada,
  });
  String nombre;
  bool icplim;
  bool subrayada;
  Opcion? opcion;
}
