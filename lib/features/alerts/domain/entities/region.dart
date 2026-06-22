enum Region {
  khmelnytskyi(3, 'Хмельницька', 'Khelnyska'),
  vinnytsia(4, 'Вінницька', 'Vinnytska'),
  rivne(5, 'Рівненська', 'Rivnenska'),
  volyn(8, 'Волинська', 'Volynska'),
  dnipropetrovsk(9, 'Дніпропетровська', 'Dnipropetrovska'),
  zhytomyr(10, 'Житомирська', 'Zhitomirska'),
  zakarpattia(11, 'Закарпатська', 'Zakarpatska'),
  zaporizhzhia(12, 'Запорізька', 'Zaporizka'),
  ivanoFrankivsk(13, 'Івано-Франківська', 'Ivanj-frankivska'),
  kyivRegion(14, 'Київська', 'Kyivska'),
  kirovohrad(15, 'Кіровоградська', 'KIrovogradska'),
  luhansk(16, 'Луганська', 'Luhanska'),
  mykolaiv(17, 'Миколаївська', 'Mukolayivska'),
  odesa(18, 'Одеська', 'Odeska'),
  poltava(19, 'Полтавська', 'Poltavska'),
  sumy(20, 'Сумська', 'Sumska'),
  ternopil(21, 'Тернопільська', 'Ternopilska'),
  kharkiv(22, 'Харківська', 'Kharkivska'),
  kherson(23, 'Херсонська', 'Khersonska'),
  cherkasy(24, 'Черкаська', 'Cherkaska'),
  chernihiv(25, 'Чернігівська', 'Chernihivska'),
  chernivtsi(26, 'Чернівецька', 'Chernivetska'),
  lviv(27, 'Львівська', 'Lvivska'),
  donetsk(28, 'Донецька', 'Donetska'),
  crimea(29, 'АР Крим', 'Krym'),
  sevastopol(30, 'Севастополь', 'Sevastopol'),
  kyivCity(31, 'м. Київ', 'Kyiv');

  const Region(this.uid, this.label, this.fileName);

  final int uid;
  final String label;
  final String fileName;
}