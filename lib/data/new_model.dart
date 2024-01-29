// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'new_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class NewModel {
  const NewModel({
    required this.url,
    required this.text,
    required this.date,
    this.isFavorite = false,
  });

  final String url;
  final String text;
  final DateTime date;
  final bool isFavorite;

  factory NewModel.fromJson(Map<String, dynamic> json) =>
      _$NewModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewModelToJson(this);

  NewModel copyWith({
    String? url,
    String? text,
    DateTime? date,
    bool? isFavorite,
  }) {
    return NewModel(
      url: url ?? this.url,
      text: text ?? this.text,
      date: date ?? this.date,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

final List<NewModel> news = [
  NewModel(
    url:
        'https://cdn-2.motorsport.com/images/amp/68ygMOQ0/s1200/lando-norris-mclaren-2nd-posit.webp',
    text:
        'Stella took over from the Audi-bound Andreas Seidl at the start of 2023 and was praised for steering the team in a different direction, implementing an overhauled technical structure in Woking while also proving to be a candid figurehead for the team towards the general public and the press.\n\nOnce it became clear McLaren had completely missed its launch targets for 2023, Stella was quick to explain where the team had gone wrong and what his plan was to get its season back on track\n\nWhen asked by Autosport if his blunt honesty was a deliberate strategy, Stella replied: "I have a very simple strategy: just say things as they are. It’s very simple. It puts you in a solid place.',
    date: DateTime(2024, 1, 19, 15, 32),
  ),
  NewModel(
    url:
        'https://cdn-8.motorsport.com/images/amp/YEQagmPY/s1200/lance-stroll-aston-martin-f1-t.webp',
    text:
        'The Silverstone-based squad knew it would be more in the spotlight throughout 2023 following the signing of two-time F1 world champion Alonso to race alongside Stroll. \n\nWhile it was well aware of the potential for difficulties with Alonso being so demanding of the teams he races for, the squad had no doubts about the way it needed to manage things. \n\nTeam principal Mike Krack explained that, ahead of Alonso’s arrival, there had been a lot of internal discussions about how best to deal with the new situation the team found itself in. But he said in the end the approach it needed was pretty straightforward. ',
    date: DateTime(2024, 1, 18, 14, 21),
  ),
  NewModel(
    url:
        'https://cdn-5.motorsport.com/images/amp/2y3XPzp6/s1200/colton-herta-andretti-autospor.webp',
    text:
        'The FIA gave Andretti’s new project the official go-ahead in October, subject to the team agreeing commercial terms with the F1 organisation and its CEO Stefano Domenicali, which is still pending.\n\nHerta, who turns 24 in March, has won seven IndyCar races in his career – effectively all with Andretti Autosport, which supported Herta’s rookie year with Harding Steinbrenner Racing when he stormed onto the scene with two wins.',
    date: DateTime(2024, 1, 17, 16, 54),
  ),
  NewModel(
    url:
        'https://cdn-5.motorsport.com/images/amp/YMdmOjG2/s1200/press-conference-with-lando-no.webp',
    text:
        'Owned by brewer Hijos de Rivera, Estrella Galicia has long been associated with Carlos Sainz, having supported him from his GP3 days in 2013.\n\nThe company entered the top level of the sport in 2015 with Toro Rosso when Sainz made his F1 debut alongside fellow rookie Max Verstappen. The following year it stepped up its involvement with logos on the car.\n\nIt then joined Sainz in his team moves, first to Renault for the last part of the 2017 season, and then onto McLaren in 2019.',
    date: DateTime(2024, 1, 16, 12, 5),
  ),
  NewModel(
    url:
        'https://cdn-2.motorsport.com/images/amp/YW7oj7kY/s1200/action-takes-place-in-the-aren.webp',
    text:
        'But while BriSCA F1 machines are used to turning left, left, left and left again, Birmingham’s National Exhibition Centre isn’t quite their natural habitat. From March to November they compete on quarter-mile ovals, paved or with loose shale surfaces. Over a 70-year history, the formula has evolved from genuine ‘stock’ cars to highly specialised purpose-built machines with huge power combined with mean-looking steel bumpers and side rails to withstand the rigours of full-contact racing.\n\nPerhaps the most visually striking feature of a BriSCA F1 stock car is its huge roof-mounted wing. These developed in two different directions: relatively conventional downforce-producing devices for sealed-surface tracks, and much taller, almost sail-like, sloping wings for racing on shale. Stability is key on the loose surface, where drivers also use the throttle to turn.',
    date: DateTime(2024, 1, 15, 10, 12),
  ),
  NewModel(
    url:
        'https://cdn-2.motorsport.com/images/amp/6zQOGnaY/s1200/luca-engstler-liqui-moly-team-.webp',
    text:
        'It contributes to a third of their annual budgets, and means competing in the DTM costs significantly more than other GT3 championships of similar scale.\n\nDue to high costs, many people in the paddock have called for a ban on testing in the DTM, including former motorsport chief Norbert Haug.\n\nSo far, the ADAC has remained sceptical about the prospect of imposing restrictions on private testing as GT3 cars are used in a variety of series around the world, making it hard to monitor any illegal running.',
    date: DateTime(2024, 1, 14, 9, 7),
  ),
  NewModel(
    url:
        'https://cdn-3.motorsport.com/images/amp/0RraQyO0/s1200/charles-leclerc-scuderia-ferra.webp',
    text:
        'Moet et Chandon had the deal for many years, and subsequently, Mumm took over. In 2016 there was a brief move to sparkling wine with McLaren partner Chandon, but the brand was part of the French LMVH luxury goods group under the umbrella of Moet Hennessy, and arguably not such a huge step away from the traditional product.\n\nF1 quickly returned to champagne with the nascent Carbon brand in 2017, and when that deal concluded after its fourth season a replacement was needed.',
    date: DateTime(2024, 1, 13, 20, 54),
  ),
  NewModel(
    url:
        'https://cdn-8.motorsport.com/images/amp/2jX5QPp6/s1200/eryk-goczal-en-el-dakar.webp',
    text:
        'Energylandia driver Goczal had dominated the opening week of Dakar in T3 category, with his performances even earning him a place inside the overall top 10 after the 48-hour Stage 6 on Friday.\n\nHowever, during the rest day in Riyadh, the FIA announced that Goczal has been excluded from the results for using a carbon clutch that has not been not authorised by the stewards. This decision is irrevocable, with Goczal and his co-driver Oriol Mena now out of the rally-raid.',
    date: DateTime(2024, 1, 12, 19, 3),
  ),
  NewModel(
    url:
        'https://cdn-8.motorsport.com/images/amp/2jX5QPp6/s1200/eryk-goczal-en-el-dakar.webp',
    text:
        'Energylandia driver Goczal had dominated the opening week of Dakar in T3 category, with his performances even earning him a place inside the overall top 10 after the 48-hour Stage 6 on Friday.\n\nHowever, during the rest day in Riyadh, the FIA announced that Goczal has been excluded from the results for using a carbon clutch that has not been not authorised by the stewards. This decision is irrevocable, with Goczal and his co-driver Oriol Mena now out of the rally-raid.',
    date: DateTime(2024, 1, 11, 13, 16),
  ),
];
