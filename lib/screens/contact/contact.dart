// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AuroraBackground extends StatefulWidget {
  const AuroraBackground({super.key});
  @override
  State<AuroraBackground> createState() => _AuroraBackgroundState();
}

class _AuroraBackgroundState extends State<AuroraBackground>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _topAlignmentAnimation;
  late Animation<Alignment> _bottomAlignmentAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    _topAlignmentAnimation = TweenSequence<Alignment>([
      TweenSequenceItem(
        tween: AlignmentTween(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: AlignmentTween(
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: AlignmentTween(
          begin: Alignment.bottomRight,
          end: Alignment.bottomLeft,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: AlignmentTween(
          begin: Alignment.bottomLeft,
          end: Alignment.topLeft,
        ),
        weight: 1,
      ),
    ]).animate(_controller);
    _bottomAlignmentAnimation = TweenSequence<Alignment>([
      TweenSequenceItem(
        tween: AlignmentTween(
          begin: Alignment.bottomRight,
          end: Alignment.bottomLeft,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: AlignmentTween(
          begin: Alignment.bottomLeft,
          end: Alignment.topLeft,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: AlignmentTween(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: AlignmentTween(
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
        ),
        weight: 1,
      ),
    ]).animate(_controller);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: const [Color(0xFF1A237E), Color(0xFF4A148C)],
            begin: _topAlignmentAnimation.value,
            end: _bottomAlignmentAnimation.value,
          ),
        ),
      ),
    );
  }
}

class Particle {
  Offset position;
  Offset speed;
  Particle({required this.position, required this.speed});
}

class AnimatedParticleBackground extends StatefulWidget {
  const AnimatedParticleBackground({super.key});
  @override
  State<AnimatedParticleBackground> createState() =>
      _AnimatedParticleBackgroundState();
}

class _AnimatedParticleBackgroundState extends State<AnimatedParticleBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Particle> particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initializeParticles());
  }

  void _initializeParticles() {
    if (!mounted) return;
    final size = MediaQuery.of(context).size;
    const particleCount = 35;
    particles = List.generate(
      particleCount,
      (index) => Particle(
        position: Offset(
          _random.nextDouble() * size.width,
          _random.nextDouble() * size.height,
        ),
        speed: Offset(
          (_random.nextDouble() - 0.5) * 0.4,
          (_random.nextDouble() - 0.5) * 0.4,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateParticles() {
    if (!mounted) return;
    final size = MediaQuery.of(context).size;
    for (var p in particles) {
      p.position += p.speed;
      if (p.position.dx < 0 || p.position.dx > size.width) {
        p.speed = Offset(-p.speed.dx, p.speed.dy);
      }
      if (p.position.dy < 0 || p.position.dy > size.height) {
        p.speed = Offset(p.speed.dx, -p.speed.dy);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        _updateParticles();
        return CustomPaint(
          painter: _ParticlePainter(particles: particles),
          child: Container(),
        );
      },
    );
  }
}

class _ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final Paint _paint = Paint()..strokeWidth = 0.5;

  _ParticlePainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    const connectionDistance = 100.0;
    for (var p in particles) {
      _paint.color = Colors.white.withOpacity(0.8);
      canvas.drawCircle(p.position, 1.5, _paint);
      for (var other in particles) {
        final distance = (p.position - other.position).distance;
        if (distance < connectionDistance) {
          _paint.color = Colors.white.withOpacity(
            1.0 - (distance / connectionDistance),
          );
          canvas.drawLine(p.position, other.position, _paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class GlassmorphicCard extends StatefulWidget {
  final Widget child;
  const GlassmorphicCard({super.key, required this.child});

  @override
  State<GlassmorphicCard> createState() => _GlassmorphicCardState();
}

class _GlassmorphicCardState extends State<GlassmorphicCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _dx = 0;
  double _dy = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      onHover: (event) {
        final containerSize = context.size;
        if (containerSize != null) {
          setState(() {
            _dx =
                (event.localPosition.dx - containerSize.width / 2) /
                (containerSize.width / 2);
            _dy =
                (event.localPosition.dy - containerSize.height / 2) /
                (containerSize.height / 2);
          });
        }
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final rotationValue = _controller.value * 0.05;
          final transform = Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(_dx * rotationValue)
            ..rotateX(-_dy * rotationValue);
          return Transform(
            transform: transform,
            alignment: FractionalOffset.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
                child: Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.1),
                        Colors.white.withOpacity(0.05),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                          _controller.value * 0.1,
                        ),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: widget.child,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});
  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final LatLng _location = const LatLng(-15.3391487, -58.8738707);
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

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) throw 'Não foi possível abrir a URL: $url';
  }

  Future<void> _sendEmail() async => await _launchURL(
    'mailto:hendrilmendes2015@gmail.com?subject=Contato%20via%20Portfólio&body=Olá,%20Hendril.%0D%0A%0D%0A',
  );
  Future<void> _makePhoneCall() async => await _launchURL('tel:+5565993611847');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0a192f),
      body: Stack(
        children: [
          const Positioned.fill(child: AuroraBackground()),
          const Positioned.fill(child: AnimatedParticleBackground()),
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildHeader()),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: Column(
                        children: [
                          _buildContactInfoSection(),
                          const SizedBox(height: 60),
                          _buildMapAndFormSection(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 80, 24, 40),
      child: Column(
        children: [
          ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFF64FFDA), Color(0xFF8892B0)],
                ).createShader(bounds),
                child: const Text(
                  'Entre em Contato',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
              )
              .animate()
              .fadeIn(duration: 500.ms)
              .slideY(begin: 0.5, curve: Curves.easeOutCubic),
          const SizedBox(height: 16),
          Text(
            'Estou sempre aberto a novas oportunidades, colaborações e um bom bate-papo. Vamos construir algo incrível juntos!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 18,
              height: 1.5,
            ),
          ).animate(delay: 200.ms).fadeIn(),
        ],
      ),
    );
  }

  Widget _buildContactInfoSection() {
    return Wrap(
      spacing: 24,
      runSpacing: 24,
      alignment: WrapAlignment.center,
      children: [
        _ContactInfoCard(
          icon: Icons.email_rounded,
          title: 'E-mail',
          subtitle: 'hendrilmendes2015@gmail.com',
          onTap: _sendEmail,
        ),
        _ContactInfoCard(
          icon: Icons.phone_rounded,
          title: 'Telefone',
          subtitle: '+55 65 99361-1847',
          onTap: _makePhoneCall,
        ),
        _ContactInfoCard(
          icon: MdiIcons.github,
          title: 'GitHub',
          subtitle: 'github.com/hendrilmendes',
          onTap: () => _launchURL('https://github.com/hendrilmendes'),
        ),
      ],
    ).animate(delay: 400.ms).fadeIn();
  }

  Widget _buildMapAndFormSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 950) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: _buildContactForm()),
              const SizedBox(width: 40),
              Expanded(flex: 3, child: _buildMapSection()),
            ],
          );
        } else {
          return Column(
            children: [
              _buildContactForm(),
              const SizedBox(height: 40),
              _buildMapSection(),
            ],
          );
        }
      },
    ).animate(delay: 600.ms).fadeIn();
  }

  Widget _buildMapSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Minha Localização',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Atualmente baseado em Jauru, Mato Grosso - Brasil',
          style: TextStyle(color: Colors.grey[400], fontSize: 16),
        ),
        const SizedBox(height: 24),
        GlassmorphicCard(
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _location,
                  zoom: 14,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId('my_location'),
                    position: _location,
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueAzure,
                    ),
                  ),
                },
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactForm() {
    return GlassmorphicCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Envie uma Mensagem',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          _buildGlassTextField(
            controller: _nameController,
            labelText: 'Seu Nome',
            icon: Icons.person_outline_rounded,
          ),
          const SizedBox(height: 16),
          _buildGlassTextField(
            controller: _emailController,
            labelText: 'Seu E-mail',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          _buildGlassTextField(
            controller: _messageController,
            labelText: 'Sua Mensagem',
            icon: Icons.message_outlined,
            maxLines: 4,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
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
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Enviar Mensagem',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white70, size: 20),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blueAccent),
        ),
      ),
    );
  }
}

class _ContactInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ContactInfoCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      hoverColor: Colors.transparent,
      child: GlassmorphicCard(
        child: SizedBox(
          width: 280,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.blueAccent, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(color: Colors.grey[300], fontSize: 14),
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
      ),
    );
  }
}
