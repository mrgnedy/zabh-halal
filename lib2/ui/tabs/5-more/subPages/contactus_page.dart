import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zabh_halal/model/contactUs_model.dart';
import 'package:zabh_halal/model/settings_nodel.dart';
import 'package:zabh_halal/resources/base_scoped_model.dart';
import 'package:zabh_halal/utilities/colors.dart';
import 'package:zabh_halal/utilities/helper_widgets.dart';
import 'package:zabh_halal/utillities.dart';

class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  BaseModel model = BaseModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: model,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 20, 8),
              child: TextD(
                textColor: Colors.white,
                title: "إتصل بنا",
                fontSize: 18,
              ),
            )
          ],
        ),
        body: LoadablePage(
            isLoading: BaseModel.isLoading,
            children: []..add(
                FutureBuilder<SettingsModel>(
                    future: model.getContactInfo(context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Center(child: Loading(indicator: BallPulseIndicator(),color: ColorsD.redDefault,));

                      if (!snapshot.hasData || snapshot.data == null)
                        return Center(
                          child: Loading(
                            color: ColorsD.redDefault,
                            indicator: BallPulseIndicator(),
                          ),
                        );
                      return ListView(
                        shrinkWrap: true,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(blurRadius: 20, color: Colors.grey)
                              ],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            margin: EdgeInsets.all(16),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextD(
                                    title: "أرقام التواصل",
                                    fontSize: 16,
                                  ),
                                  Divider()
                                ]..addAll(List.generate(
                                      snapshot.data.data.contacts.length ,
                                      (index) {
                                    return TextD(
                                      title: snapshot
                                          .data.data.contacts[0].contact,
                                      fontSize: 18,
                                    );
                                  }))),
                          )
                        ]..addAll([
                            SizedBox(
                              height: 30,
                            ),
                            _buildContact(snapshot.data.data.settings.whatsapp,
                                FontAwesomeIcons.whatsapp),
                            _buildContact(
                                snapshot.data.data.settings.gmail, Icons.mail),
                            _buildContact(snapshot.data.data.settings.facebook,
                                FontAwesomeIcons.facebook),
                            _buildContact(snapshot.data.data.settings.twitter,
                                FontAwesomeIcons.twitter),
                            _buildContact(snapshot.data.data.settings.instgram,
                                FontAwesomeIcons.instagram),
                          ]),
                      );
                    }),
              )),
      ),
    );
  }

  Widget _buildContact(String data, IconData icon) {
    return Visibility(
      visible: data != null,
      child: Utility.contaner(
          Colors.white,
          context,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    '$data',
                    style: TextStyle(
                        //  height: 2,
                        fontFamily: "thin",
                        color: Colors.grey,
                        fontSize: 15),
                  )),
              IconButton(
                onPressed: () async {
                  if (await canLaunch(data))
                    await launch(
                      data,
                    );
                },
                icon: Icon(icon),
                color: Colors.grey,
              )
            ],
          )),
    );
  }
}
