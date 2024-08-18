import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:folio/models/projects.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Projetos',
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // Design para telas grandes
            return GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 4 / 3,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: projetos.length,
              itemBuilder: (context, index) {
                final projeto = projetos[index];
                return ProjetoCard(projeto: projeto);
              },
            );
          } else {
            // Design para telas pequenas
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: projetos.length,
              itemBuilder: (context, index) {
                final projeto = projetos[index];
                return ProjetoCard(projeto: projeto);
              },
            );
          }
        },
      ),
    );
  }
}

class ProjetoCard extends StatelessWidget {
  final Projeto projeto;

  const ProjetoCard({super.key, required this.projeto});

  Future<void> _abrirProjeto(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Não foi possível abrir a URL: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(10.0)),
            child: CachedNetworkImage(
              imageUrl: projeto.imagemUrl,
              width: double.infinity,
              height: 150.0,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              projeto.titulo,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              projeto.descricao,
              style: TextStyle(fontSize: 16.0, color: Colors.grey[600]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: ElevatedButton(
                onPressed: () => _abrirProjeto(projeto.urlProject),
                child: const Text('Abrir Projeto'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
