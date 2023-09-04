enum RespuestaComprension { todaviaNo, deVezEnCuando, muchasVeces, noContesto }

String convertToString(RespuestaComprension? value) {
  switch (value) {
    case RespuestaComprension.todaviaNo:
      return 'Todavía no';
    case RespuestaComprension.deVezEnCuando:
      return 'De vez en cuando';
    case RespuestaComprension.muchasVeces:
      return 'Muchas veces';
    case RespuestaComprension.noContesto:
      return 'No contestó';
    default:
      return 'No contestó';
  }
}

RespuestaComprension convertToEnum(String? value) {
  switch (value) {
    case 'Todavía no':
      return RespuestaComprension.todaviaNo;
    case 'De vez en cuando':
      return RespuestaComprension.deVezEnCuando;
    case 'Muchas veces':
      return RespuestaComprension.muchasVeces;
    case 'No contestó':
      return RespuestaComprension.noContesto;
    default:
      return RespuestaComprension.noContesto;
  }
}

enum Opcion { comprende, comprendeYDice, ninguna, dejoDeContestar }

int convertToInt(Opcion? value) {
  switch (value) {
    case Opcion.comprende:
      return 1;
    case Opcion.comprendeYDice:
      return 2;
    case Opcion.ninguna:
      return 0;
    case Opcion.dejoDeContestar:
      return 9;
    default:
      return 3;
  }
}

Opcion convertToEnumOpcion(int? value) {
  switch (value) {
    case 1:
      return Opcion.comprende;
    case 2:
      return Opcion.comprendeYDice;
    case 0:
      return Opcion.ninguna;
    case 9:
      return Opcion.dejoDeContestar;
    default:
      return Opcion.ninguna;
  }
}
