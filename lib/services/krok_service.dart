import '../models/krok.dart';
import '../models/krok_step.dart';

class KrokService {
  static const String idLiseberg = "42bc8f";
  static const String idFeskekorka = "3c697f";

  Future<Iterable<Krok>> findNearby() => Future.delayed(
    Duration(seconds: 1),
    () => <Krok>[
      Krok(
        id: idLiseberg,
        title: "Liseberg",
        imagePath: "liseberg.jpg",
        distanceInMeters: 40,
      ),
      Krok(
        id: idFeskekorka,
        title: "Feskekörka",
        imagePath: "feskekorka.jpg",
        distanceInMeters: 350,
      ),
    ],
  );

  Future<List<KrokStep>> get(String id) =>
      idLiseberg == id
          ? Future.delayed(
            Duration(seconds: 1),
            () => <KrokStep>[
              KrokStep(
                title: "Radiobilarna",
                imageNearby: "radiobilarna.jpg",
                imageProceedTo: "42bc8f_0.jpeg",
                promptNearby: "Åk minst en runda i Radiobilarna!",
              ),
              KrokStep(title: "Biergarten",
                imageNearby: "biergarten.jpg",
                imageProceedTo: "42bc8f_1.jpeg",
                promptNearby: "Drick minst en Bier!",),
              KrokStep(title: "Uppswinget",
                imageNearby: "uppswinget.jpg",
                imageProceedTo: "42bc8f_2.jpeg",
                promptNearby: "Åk om du törs!",),
            ],
          )
          : Future.error(id);
}
