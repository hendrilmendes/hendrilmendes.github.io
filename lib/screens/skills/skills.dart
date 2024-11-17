import 'package:flutter/material.dart';
import 'package:folio/models/habilidades.dart';

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Determina o layout com base na largura da tela
                  if (constraints.maxWidth > 1200) {
                    // Layout para telas grandes
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        childAspectRatio: 2 / 1,
                      ),
                      itemCount: habilidades.length,
                      itemBuilder: (context, index) {
                        final habilidade = habilidades[index];
                        return SkillCard(habilidade: habilidade);
                      },
                    );
                  } else {
                    // Layout para telas pequenas
                    return ListView.builder(
                      itemCount: habilidades.length,
                      itemBuilder: (context, index) {
                        final habilidade = habilidades[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: SkillCard(habilidade: habilidade),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SkillCard extends StatelessWidget {
  final Habilidade habilidade;

  const SkillCard({super.key, required this.habilidade});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(habilidade.icone, size: 32, color: Colors.blue),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    habilidade.nome,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              habilidade.descricao,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            SkillProgress(habilidade: habilidade),
          ],
        ),
      ),
    );
  }
}

class SkillProgress extends StatefulWidget {
  final Habilidade habilidade;

  const SkillProgress({super.key, required this.habilidade});

  @override
  // ignore: library_private_types_in_public_api
  _SkillProgressState createState() => _SkillProgressState();
}

class _SkillProgressState extends State<SkillProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();

    _animation = Tween<double>(begin: 0, end: widget.habilidade.nivel).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${(_animation.value * 100).round()}%',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: LinearProgressIndicator(
                    value: _animation.value,
                    backgroundColor: Colors.grey[300],
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
