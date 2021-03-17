import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:starbucks_landing_web/utils/helpers.dart';
import 'package:starbucks_landing_web/widgets/starbucks_button.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Starbucks Landing Page',
      theme: ThemeData(
        canvasColor: Colors.transparent,
        primarySwatch: Helpers.createMaterialColor(Color(0xff2B6D4E)),
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int index = 0;
  bool isScrolled = false;
  int _focusedIndex = 0;

  ScrollController _scrollController = new ScrollController(
    initialScrollOffset: 0.0,
    keepScrollOffset: true,
  );

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= 100) {
        setState(() {
          isScrolled = true;
        });
      } else {
        setState(() {
          isScrolled = false;
        });
      }
    });
    super.initState();
  }

  void _onItemFocus(int index) {
    setState(() {
      _focusedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2B6D4E),
      body: SafeArea(
        child: Container(
          width: Helpers.getWidthPageSize(context),
          height: Helpers.getHeightPageSize(context),
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    heroBanner(),
                    SizedBox(height: 32,),
                    infoSection(),
                    SizedBox(height: 16,),
                    productSection(),
                    SizedBox(height: 32,),
                    footerSection()
                  ],
                ),
              ),
              Container(
                  width: Helpers.getWidthPageSize(context),
                  decoration: BoxDecoration(
                      color: isScrolled ? Color(0xff2B6D4E) : null
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: Helpers.getWidthPageSize(context) / 10
                  ),
                  child: navBar()
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget footerSection() {
    return  Container(
      width: Helpers.getWidthPageSize(context),
      padding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: Helpers.getWidthPageSize(context) / 10
      ),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              tileMode: TileMode.mirror,
              colors: [
                Color(0xff323834),
                Color(0xff333935),
              ]
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {

                },
                child: Text(
                  "Made by Irvan Lutfi Gunawan",
                  style: GoogleFonts.nunito(
                    color: Colors.white54,
                    fontWeight: FontWeight.w600
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget infoSection() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 32,
          horizontal: Helpers.getWidthPageSize(context) / 10
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.asset(
                    "graphics/starbucks_place.jpeg",
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: 32,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Starbucks Coffe",
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w800
                  ),
                ),
                SizedBox(height: 16,),
                Text(
                  "We are passionate purveyors of coffee and everything else that goes with a rewarding coffeehouse experience. We also offer a selection of premium Tazo® teas, fine pastries and other delectable treats to please the taste buds. And the music you hear in store is chosen for its artistry and appeal. People come to Starbucks to chat, meet up or work.\nWe’re a neighborhood gathering place, a part of the daily routine – and we couldn’t be happier about it. Get to know us and you’ll see: we are so much more than what we brew.",
                  style: GoogleFonts.mukta(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w300
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget productSection() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: 32,
          // horizontal: Helpers.getWidthPageSize(context) / 10
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: Helpers.getWidthPageSize(context) / 10
            ),
            child: Text(
              "Product Coffe",
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w800
              ),
            ),
          ),
          SizedBox(height: 8,),
          Container(
            height: 450,
            child: ScrollSnapList(
              onItemFocus: _onItemFocus,
              scrollDirection: Axis.horizontal,
              itemSize: 21,
              itemCount: 16,
              curve: Curves.bounceInOut,
              itemBuilder: (context, index) {
                return Container(
                  width: 260,
                  height: 400,
                  padding: EdgeInsets.all(16),
                  margin: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xff333935),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(1.0, 2.0),
                        blurRadius: 2.0,
                        color: Color(0xff616161).withOpacity(0.1),
                        spreadRadius: 1.0,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(
                          "graphics/starbuck_coffe.png",
                          width: 140,

                        ),
                      ),
                      SizedBox(height: 24,),
                      RichText(
                        text: TextSpan(
                            text: "Starbucks Espresso Roast ",
                            style: GoogleFonts.nunito(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "\n200 gr",
                                style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w200
                                ),
                              ),

                            ]),
                      ),
                      SizedBox(height: 8,),
                      Text(
                        "Lorem Ipsum Dolor",
                        style: GoogleFonts.mukta(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                      Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                        style: GoogleFonts.mukta(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                      SizedBox(height: 16,),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16)
                        ),
                        child: Text(
                          "Rp 50.000",
                          style: GoogleFonts.inter(
                              color: Color(0xff2B6D4E),
                              fontSize: 12,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16),
          Center(
            child: StarbucksButton(
              "See More",
              width: 210,
              onTap: _launchURL,
              colors: [
                Colors.transparent,
                Colors.transparent,
              ],
              border:Border.all(
                  color: Colors.white
              ),
              textStyle: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget heroBanner() {
    return  Container(
      width: Helpers.getWidthPageSize(context),
      height: Helpers.getHeightPageSize(context) / 1.1,
      padding: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: Helpers.getWidthPageSize(context) / 10
      ),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              tileMode: TileMode.mirror,
              colors: [
                Color(0xff323834),
                Color(0xff333935),
              ]
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Starbucks\nCoffe Blend",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 44,
                        fontWeight: FontWeight.w800
                      ),
                    ),
                    SizedBox(height: 16,),
                    Text(
                      "To say Starbucks purchases and roasts high-quality whole bean coffees is very true. That’s the essence of what we do – but it hardly tells the whole story.",
                      style: GoogleFonts.mukta(
                        color: Color(0xffA7A8A2),
                        fontSize: 16,
                        letterSpacing: 0,
                        wordSpacing: 0
                      ),
                    ),
                    SizedBox(height: 16,),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: Helpers.getWidthPageSize(context) * 0.2,
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color(0xff2B6D4E),
                              Color(0xff2B6D4E),
                            ]),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Text(
                            "Details",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.mukta(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white
                            ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "graphics/starbuck_coffe.png"
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget navBar() {
    return Row(
      children: [
        Image.asset(
          "graphics/starbucks-logo.png",
          width: 80,
          height: 80,
        ),

        SizedBox(width: 16,),

        Expanded(
          child: Row(
            children: [
              navItem("Home", 0),
              navItem("About", 1),
              navItem("Product", 2),
            ],
          ),
        ),
        SizedBox(width: 16,),
        Icon(
          CupertinoIcons.shopping_cart,
          color: Colors.white,
        )
      ],
    );
  }

  Widget navItem(String title, int indexItem) {
    return InkWell(
      onTap: () {
        setState(() {
          index = indexItem;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        margin: EdgeInsets.symmetric(horizontal: 11),
        decoration: BoxDecoration(
          color: index == indexItem ? Colors.white : null,
          borderRadius: BorderRadius.circular(16)
        ),
        child: Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: index == indexItem ? Color(0xff2B6D4E) : Colors.white
          ),
        ),
      ),
    );
  }

  void _launchURL() async =>
      await canLaunch("https://github.com/agryva") ? await launch("https://github.com/agryva") : throw 'Could not launch';

}
