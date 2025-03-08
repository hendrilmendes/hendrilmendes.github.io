import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
        '&body=Vi seu portfólio e tenho interesse em...',
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
    final Uri phoneUri = Uri(scheme: 'tel', path: '+5565993611847');

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Não foi possível fazer a ligação.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Card para o contato
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Text(
                        'Entre em Contato',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Escolha uma das opções abaixo para entrar em contato:',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      // Botões de contato
                      ContactButton(
                        onPressed: _sendEmail,
                        icon: Icons.email,
                        label: 'Enviar E-mail',
                        color: Colors.blueAccent,
                      ),
                      const SizedBox(height: 16),
                      ContactButton(
                        onPressed: _makePhoneCall,
                        icon: Icons.phone,
                        label: 'Ligar para o Telefone',
                        color: Colors.green,
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
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
            ),
          ],
        ),
      ),
    );
  }
}

class ContactButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  final Color color;

  const ContactButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
