import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EspecialidadesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Especialidades'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            _buildSpecialtyCard(context, 'assets/cardiologia.png', 'Cardiología', 'https://www.redclinica.cl/plantilla/especialidades/cardiologia.aspx'),
            _buildSpecialtyCard(context, 'assets/kinesiologia.png', 'Kinesiología', 'https://www.meds.cl/especialidades/kinesiologia/'),
            _buildSpecialtyCard(context, 'assets/medicina_general.png', 'Medicina General', 'https://www.integramedica.cl/integramedica/medicina-general'),
            _buildSpecialtyCard(context, 'assets/radiologia.png', 'Radiología', 'https://medicina.uc.cl/postgrado/especialidades-medicas/especialidades-primarias-2/radiologia/'),
            _buildSpecialtyCard(context, 'assets/dental.png', 'Dental', 'https://www.unosalud.cl/?utm_source=google&utm_medium=cpc&utm_campaign=20230824_brand_camping&utm_content=adset_02_brand_campaing_term_brand&gad_source=1&gclid=CjwKCAjw8fu1BhBsEiwAwDrsjGLOtFUbdL2xRoteUZbPvFzmkZwVDgpWQ2ISo1ZEjpSCc0hxKeD41RoCop8QAvD_BwE'),
            _buildSpecialtyCard(context, 'assets/maternidad.png', 'Maternidad', 'https://www.clinicaalemana.cl/especialidades/maternidad-y-familia/maternidad-integral'),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecialtyCard(BuildContext context, String assetPath, String title, String url) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Card(
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(assetPath, width: 50, height: 50),
            SizedBox(height: 16),
            Text(title, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}