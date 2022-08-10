class NewsListData {
  NewsListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.info,
    this.kacl = 0,
  });

  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  List<String>? info;
  int kacl;

  static List<NewsListData> tabIconsList = <NewsListData>[
    NewsListData(
      imagePath: 'assets/drawblood_app/event.png',
      titleTxt: 'Give out blood to save life',
      info: <String>[
        'Date: 6 August to 7 August 2022',
        'Venue: Damansara Shopping Mall',
        'RSVP: 016-2099268'
      ],
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    NewsListData(
      imagePath: 'assets/drawblood_app/event.png',
      titleTxt: 'Campaign of Blood Donation',
      kacl: 602,
      info: <String>[
        'Date: 8 August 2022',
        'Venue: Pusat Darah Negara',
        'Time: 7.30 a.m. - 8.00p.m.'
      ],
      startColor: '#738AE6',
      endColor: '#5C5EDD',
    ),
    NewsListData(
      imagePath: 'assets/drawblood_app/event.png',
      titleTxt: 'Campaign of Blood Donation',
      kacl: 0,
      info: <String>[
        'Date: 8 August 2022',
        'Venue: Mid Valley Megamall',
        'Time: 10.00 a.m. - 9.00p.m.'
      ],
      startColor: '#FE95B6',
      endColor: '#FF5287',
    ),
    NewsListData(
      imagePath: 'assets/drawblood_app/event.png',
      titleTxt: 'Campaign of Blood Donation',
      kacl: 0,
      info: <String>[
        'Date: 8 August 2022',
        'Venue: 1 Utama Shopping Centre',
        'Time: 11.00 a.m. - 7.00p.m.'
      ],
      startColor: '#6F72CA',
      endColor: '#1E1466',
    ),
  ];
}
