class Tablas {
  static int calcularPercentil({
    required Tabla tabla,
    required int edad,
    required int numPalabras,
  }) {
    //Encontrar columna mas cercana a edad
    final columna = tabla.getColumnaPorEdad(edad);

    //Buscar numero de palabras en columna
    int index = columna.datosColumna.indexOf(numPalabras);

    //Si se encuentra un resultado exacto, regresar percentil
    if (index != -1) return tabla.rangoPercentiles[index];

    //Si no, interpolar percentiles
    final ({int index, int interpolacion}) record = columna.interpolar(numPalabras);
    if (record.index == -1) return record.interpolacion;
    return tabla.rangoPercentiles[record.index] + record.interpolacion;
  }

  static Tabla comprensionPrimerasFrasesCDI1 = Tabla(
    [99, 95, 90, 85, 80, 75, 70, 65, 60, 55, 50, 45, 40, 35, 30, 25, 20, 15, 10, 5],
    [
      Columna(8, [27, 25, 22, 18, 15, 14, 13, 12, 12, 11, 10, 9, 9, 8, 7, 6, 5, 5, 4, 2]),
      Columna(9, [27, 26, 23, 20, 18, 16, 15, 14, 14, 13, 12, 11, 10, 10, 9, 8, 6, 6, 4, 3]),
      Columna(10, [27, 26, 24, 22, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 11, 9, 8, 7, 5, 4]),
      Columna(11, [27, 27, 25, 24, 22, 21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 8, 7, 5]),
      Columna(12, [28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16, 15, 14, 13, 11, 10, 8, 6]),
      Columna(13, [28, 27, 27, 26, 25, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16, 15, 13, 11, 10, 7]),
      Columna(14, [28, 28, 27, 27, 26, 26, 25, 24, 23, 23, 22, 21, 20, 18, 18, 17, 15, 13, 11, 9]),
      Columna(15, [28, 28, 28, 27, 27, 27, 26, 26, 24, 24, 23, 23, 21, 20, 19, 18, 17, 15, 13, 10]),
      Columna(16, [28, 28, 28, 28, 28, 27, 27, 27, 25, 25, 24, 24, 23, 22, 21, 20, 19, 17, 15, 12]),
      Columna(17, [28, 28, 28, 28, 28, 28, 28, 28, 26, 26, 25, 25, 24, 23, 22, 22, 21, 19, 17, 14]),
      Columna(18, [28, 28, 28, 28, 28, 28, 28, 28, 27, 27, 26, 26, 25, 24, 24, 23, 22, 20, 19, 16]),
    ],
  );

  static Tabla comprensionPalabrasCDI1 = Tabla(
    [99, 95, 90, 85, 80, 75, 70, 65, 60, 55, 50, 45, 40, 35, 30, 25, 20, 15, 10, 5],
    [
      Columna(8, [170, 145, 127, 109, 91, 81, 73, 61, 50, 41, 36, 30, 25, 20, 15, 12, 10, 7, 4, 1]),
      Columna(9, []),
      Columna(10, []),
      Columna(11, []),
      Columna(12, []),
      Columna(13, []),
      Columna(14, []),
      Columna(15, []),
      Columna(16, []),
      Columna(17, []),
      Columna(18, []),
    ],
  );

  static Tabla produccionPalabrasCDI2 = Tabla(
    [99, 95, 90, 85, 80, 75, 70, 65, 60, 55, 50, 45, 40, 35, 30, 25, 20, 15, 10, 5],
    [
      Columna(16, [566, 261, 181, 151, 131, 110, 89, 71, 59, 52, 43, 35, 29, 26, 22, 19, 16, 12, 10, 6]),
      Columna(17, [592, 308, 217, 181, 157, 132, 108, 88, 73, 64, 54, 45, 36, 33, 28, 24, 20, 15, 12, 7]),
      Columna(18, [613, 357, 257, 215, 185, 158, 131, 108, 90, 79, 67, 56, 46, 42, 36, 30, 25, 19, 15, 9]),
      Columna(19, [630, 404, 299, 252, 217, 187, 157, 131, 111, 97, 83, 69, 58, 52, 45, 37, 31, 23, 18, 11]),
      Columna(20, [642, 449, 343, 291, 251, 218, 186, 159, 135, 119, 102, 86, 72, 65, 56, 47, 39, 29, 22, 14]),
      Columna(21, [652, 491, 387, 332, 287, 253, 219, 189, 163, 144, 124, 106, 90, 80, 70, 58, 49, 36, 27, 17]),
      Columna(22, [659, 527, 429, 373, 324, 290, 254, 224, 195, 173, 150, 130, 112, 98, 86, 72, 61, 45, 34, 21]),
      Columna(23, [665, 558, 468, 413, 362, 327, 291, 261, 230, 205, 180, 157, 137, 120, 106, 89, 75, 55, 41, 25]),
      Columna(24, [669, 584, 504, 451, 400, 366, 300, 300, 268, 240, 214, 188, 166, 146, 129, 109, 93, 68, 50, 31]),
      Columna(25, [672, 606, 535, 486, 435, 403, 369, 340, 307, 278, 250, 223, 200, 175, 156, 132, 114, 84, 61, 38]),
      Columna(26, [674, 623, 563, 518, 469, 439, 407, 381, 348, 318, 289, 260, 236, 208, 187, 159, 138, 102, 74, 46]),
      Columna(27, [676, 636, 586, 546, 500, 473, 444, 420, 389, 358, 330, 300, 276, 244, 222, 190, 167, 123, 90, 56]),
      Columna(28, [677, 647, 605, 570, 528, 504, 478, 457, 428, 398, 371, 341, 318, 282, 259, 224, 198, 148, 108, 68]),
      Columna(29, [678, 655, 621, 590, 553, 532, 509, 491, 465, 436, 411, 382, 360, 322, 299, 261, 234, 176, 129, 82]),
      Columna(30, [679, 661, 634, 608, 575, 556, 537, 522, 499, 472, 449, 422, 402, 363, 339, 300, 271, 207, 152, 99]),
    ],
  );
}

class Tabla {
  List<int> rangoPercentiles = [];
  List<Columna> datosTabla = [];

  Columna getColumnaPorEdad(int edad) {
    final index = datosTabla.lastIndexWhere((columna) => columna.edad == edad);
    if (index != -1) {
      return datosTabla[index];
    }

    int minimo = datosTabla.first.edad;
    if (edad <= minimo) return datosTabla.first;
    //Debe ser mayor al maximo
    return datosTabla.last;
  }

  Tabla(this.rangoPercentiles, this.datosTabla);
}

class Columna {
  int edad;
  List<int> datosColumna;

  Columna(this.edad, this.datosColumna);

  ({int index, int interpolacion}) interpolar(int numPalabras) {
    if (numPalabras > datosColumna.first) {
      return (index: 0, interpolacion: 0);
    }

    int inferior = 0;
    int superior = 0;
    int index = -1;

    //Encontrar el percentil inferior
    for (var i = 0; i < datosColumna.length; i++) {
      if (datosColumna[i] < numPalabras) {
        index = i;
        inferior = datosColumna[i];
        superior = datosColumna[i - 1];
        break;
      }
    }

    if (superior == 0) superior = datosColumna.last;

    //Interpolar el percentil
    final int diferencia = superior - inferior;
    final double palabrasPorPercentil = diferencia / 5;
    double suma = inferior.toDouble();
    int interpolacion = 0;

    for (var i = 0; i < 5; i++) {
      interpolacion += 1;
      suma += palabrasPorPercentil;
      if (suma >= numPalabras) break;
    }
    return (index: index, interpolacion: interpolacion);
  }
}
