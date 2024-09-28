import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  // Função para abrir o e-mail do cliente
  void _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'hendrilmendes2015@gmail.com',
      query: Uri.encodeFull(
        'subject=Olá Hendril, tudo bem?'
        '&body= Vi seu portfolio e tenho interesse em...',
      ),
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Não foi possível abrir o aplicativo de e-mail.';
    }
  }

  // Função para fazer uma ligação
  void _makePhoneCall() async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: '+5565993611847',
    );

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Não foi possível fazer a ligação.';
    }
  }

  void _whatsappOpen() async {
    final String phoneNumber = '+5565993611847';
    final String message = 'Olá Hendril! Vi seu portfolio e gostaria de ...';
    final Uri whatsappUri = Uri.parse(
        'https://api.whatsapp.com/send?phone=$phoneNumber&text=${Uri.encodeComponent(message)}');

    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    } else {
      throw 'Não foi possível abrir o WhatsApp.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Card para o contato
            Container(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Entre em Contato',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent,
                                ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Você pode entrar em contato comigo através dos botões abaixo:',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.grey[700],
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton.icon(
                        onPressed: _sendEmail,
                        icon: const Icon(Icons.email),
                        label: const Text('Enviar E-mail'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blueAccent,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _makePhoneCall,
                        icon: const Icon(Icons.phone),
                        label: const Text('Ligar para o Telefone'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _whatsappOpen,
                        icon: const Icon(MdiIcons.whatsapp),
                        label: const Text('Whatsapp'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Divisor visual
            Divider(height: 1, color: Colors.grey[300]),
            const SizedBox(height: 32),
            // Card para o mapa
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: AspectRatio(
                aspectRatio: 2 / 1,
                child: GoogleMap(
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(-15.3391487, -58.8738707),
                    zoom: 10,
                  ),
                  markers: {
                    const Marker(
                      markerId: MarkerId('jauru'),
                      position: LatLng(-15.3391487, -58.8738707),
                      infoWindow: InfoWindow(title: 'Jauru'),
                    ),
                  },
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
