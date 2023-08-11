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
