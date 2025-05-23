// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final LatLng _location = const LatLng(-15.3391487, -58.8738707);
  bool _isMapLoaded = false;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'Contato',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              centerTitle: true,
              background: Image.network(
                'https://images.unsplash.com/photo-1534972195531-d756b9bfa9f2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
                fit: BoxFit.cover,
              ),
            ),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // Seção de informações de contato
                  _buildContactSection(),
                  const SizedBox(height: 40),

                  // Seção de redes sociais
                  _buildSocialMediaSection(),
                  const SizedBox(height: 40),

                  // Seção do mapa
                  _buildMapSection(),
                  const SizedBox(height: 40),

                  // Formulário de contato
                  _buildContactForm(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    return Column(
      children: [
        const Text(
          'Vamos trabalhar juntos!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ).animate().fadeIn(duration: 500.ms),
        const SizedBox(height: 16),
        Text(
          'Estou disponível para oportunidades de trabalho freelance e colaborações. Entre em contato através dos canais abaixo:',
          style: TextStyle(color: Colors.grey[400], fontSize: 16),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          alignment: WrapAlignment.center,
          children: [
            _buildContactCard(
              icon: Icons.email,
              title: 'E-mail',
              subtitle: 'hendrilmendes2015@gmail.com',
              color: Colors.redAccent,
              onTap: _sendEmail,
            ),
            _buildContactCard(
              icon: Icons.phone,
              title: 'Telefone',
              subtitle: '+55 65 99361-1847',
              color: Colors.greenAccent,
              onTap: _makePhoneCall,
            ),
            _buildContactCard(
              icon: Icons.location_on,
              title: 'Localização',
              subtitle: 'Jauru, MT - Brasil',
              color: Colors.blueAccent,
              onTap: _openMaps,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(color: Colors.grey[400], fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialMediaSection() {
    return Column(
      children: [
        const Text(
          'Minhas Redes Sociais',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Conecte-se comigo através das redes sociais:',
          style: TextStyle(color: Colors.grey[400], fontSize: 16),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            _buildSocialButton(
              icon: Icons.code,
              label: 'GitHub',
              color: Colors.purpleAccent,
              url: 'https://github.com/hendrilmendes',
            ),
            _buildSocialButton(
              icon: Icons.link,
              label: 'LinkedIn',
              color: Colors.blueAccent,
              url: 'https://linkedin.com/in/hendril-mendes',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required Color color,
    required String url,
  }) {
    return ElevatedButton.icon(
      onPressed: () => _launchURL(url),
      icon: Icon(icon, color: Colors.white),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildMapSection() {
    return Column(
      children: [
        const Text(
          'Minha Localização',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Atualmente baseado em Jauru, Mato Grosso - Brasil',
          style: TextStyle(color: Colors.grey[400], fontSize: 16),
        ),
        const SizedBox(height: 24),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            height: 300,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _location,
                zoom: 14,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('my_location'),
                  position: _location,
                  infoWindow: const InfoWindow(title: 'Minha Localização'),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueAzure,
                  ),
                ),
              },
              onMapCreated: (_) => setState(() => _isMapLoaded = true),
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
            ),
          ),
        ),
        if (!_isMapLoaded)
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }

  Widget _buildContactForm() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text(
            'Envie uma Mensagem',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Preencha o formulário abaixo e entrarei em contato o mais breve possível',
            style: TextStyle(color: Colors.grey[400], fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Seu Nome',
              labelStyle: const TextStyle(color: Colors.white70),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey[800],
            ),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Seu E-mail',
              labelStyle: const TextStyle(color: Colors.white70),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey[800],
            ),
            style: const TextStyle(color: Colors.white),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _messageController,
            decoration: InputDecoration(
              labelText: 'Sua Mensagem',
              labelStyle: const TextStyle(color: Colors.white70),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey[800],
            ),
            style: const TextStyle(color: Colors.white),
            maxLines: 5,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () async {
              final name = _nameController.text.trim();
              final email = _emailController.text.trim();
              final message = _messageController.text.trim();

              if (name.isEmpty || email.isEmpty || message.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Por favor, preencha todos os campos.'),
                  ),
                );
                return;
              }

              final Uri emailUri = Uri(
                scheme: 'mailto',
                path: 'hendrilmendes2015@gmail.com',
                query: Uri.encodeFull(
                  'subject=Contato via app de portfólio'
                  '&body=Nome: $name\nE-mail: $email\n\nMensagem:\n$message',
                ),
              );

              if (await canLaunchUrl(emailUri)) {
                await launchUrl(emailUri);
              } else {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Não foi possível abrir o app de e-mail.'),
                  ),
                );
              }
            },

            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blueAccent,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Enviar Mensagem'),
          ),
        ],
      ),
    );
  }

  Future<void> _sendEmail() async {
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

  Future<void> _makePhoneCall() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: '+5565993611847');

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Não foi possível fazer a ligação.';
    }
  }

  Future<void> _openMaps() async {
    final Uri mapsUri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${_location.latitude},${_location.longitude}',
    );

    if (await canLaunchUrl(mapsUri)) {
      await launchUrl(mapsUri);
    } else {
      throw 'Não foi possível abrir o mapa.';
    }
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Não foi possível abrir a URL: $url';
    }
  }
}
