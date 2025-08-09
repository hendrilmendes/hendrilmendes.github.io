# Devfolio - Portfólio Profissional

[![Flutter 3.32+](https://img.shields.io/badge/Flutter-3.19%2B-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

### ➡️ [Acesse a versão ao vivo aqui](https://hendrilmendes.github.io/) ⬅️

---

## 🌟 Sobre o Projeto

Bem-vindo ao meu mundo de desenvolvimento! Este é meu portfólio pessoal, construído com cuidado e atenção aos detalhes — um espaço onde tecnologia e design se encontram para contar minha jornada profissional.

Este projeto demonstra minhas competências em desenvolvimento com Flutter, com foco em:

- **UI/UX e Design System:** Interface moderna, coesa e consistente.
- **Animações Imersivas:** Uso de animações para uma experiência fluida.
- **Arquitetura Limpa:** Código organizado, testável e escalável.
- **Responsividade:** Layouts ajustados para diferentes tamanhos de tela.

---

## ✨ Funcionalidades

- 📱 **Navegação Dupla e Responsiva:** Barra superior em Desktop e inferior em Mobile, com interações otimizadas.
- 🚀 **Splash Screen Criativa:** Tema de terminal simulando inicialização do site.
- 📄 **Currículo Interativo + PDF:** Visualização do currículo e opção de **gerar/baixar PDF** com layout profissional ou **imprimir**.
- 🗺️ **Mapa Interativo:** Integração com Google Maps na seção de contato.
- 🎨 **Animações Complexas:** Aurora + Partículas, Glassmorphism e microinterações.

---

## 🛠️ Arquitetura e Tecnologias

Projeto baseado em pacotes modernos do ecossistema Flutter, seguindo boas práticas.

### Estrutura de Arquivos

```text
lib/
├── configs/     # Configurações globais
├── data/        # Dados estáticos
├── models/      # Modelos de dados
├── screens/     # Telas principais
└── widgets/     # Widgets reutilizáveis
```

### Dependências Principais

- **UI/UX e Animação:** `animations`, `flutter_animate`, `shimmer`, `google_fonts`, `material_design_icons_flutter`
- **Integrações:** `google_maps_flutter`, `url_launcher`
- **PDF e Persistência:** `pdf`, `printing`, `shared_preferences`
- **Internacionalização:** `intl`
- **Qualidade:** `flutter_lints`
- **Infra:** GitHub Actions para CI/CD

---

## 🚀 Começando

### Pré-requisitos

- **Flutter SDK:** instale e configure o Flutter (versão recomendada: `3.32+`).
  - Guia oficial: https://docs.flutter.dev/get-started/install

### Instalação

1) Clone o repositório:

```bash
git clone https://github.com/hendrilmendes/hendrilmendes.github.io.git
cd hendrilmendes.github.io
```

2) Instale as dependências:

```bash
flutter pub get
```

3) Configure a chave da API do Google Maps:

- Crie a chave no [Google Cloud Console](https://console.cloud.google.com/google/maps-apis/overview).
- Para Web, adicione no `web/index.html` dentro de `<head>`:

```html
<script src="https://maps.googleapis.com/maps/api/js?key=SUA_CHAVE_DE_API_AQUI"></script>
```

- ⚠️ **Importante:** restrinja a chave no Console para evitar uso indevido e cobranças.

4) Execute a aplicação (Web):

```bash
flutter run -d chrome
```

---

## 📦 pubspec.yaml

Abaixo um `pubspec.yaml` organizado, com versões alinhadas às faixas atuais. Recomenda-se executar `flutter pub outdated` e `flutter pub upgrade --major-versions` para validar a atualização no seu ambiente.

```yaml
name: folio
description: Devfolio escrito em Flutter.
publish_to: "none" # Remova se desejar publicar no pub.dev

# Sugestão: incremente version conforme seu fluxo de release
version: 2.0.2+20250809

environment:
  sdk: ">=3.8.0 <4.0.0"

dependencies:
  flutter:
    sdk: flutter

  # UI/Animações
  animations: ^2.0.11
  flutter_animate: ^4.5.2
  shimmer: ^3.0.0
  google_fonts: ^6.3.0
  material_design_icons_flutter: ^5.0.0

  # Integrações
  google_maps_flutter: ^2.12.3
  url_launcher: ^6.3.2

  # Internacionalização
  intl: ^0.20.2

  # PDF e impressão
  pdf: ^3.11.3
  printing: ^5.14.2

  # Persistência
  shared_preferences: ^2.5.3

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0

flutter:
  uses-material-design: true
```

Dicas de atualização:
- Rode `flutter pub outdated` para ver o que pode ser atualizado com segurança.
- Use `flutter pub upgrade --major-versions` para subir para as últimas versões possíveis dentro das suas restrições.
- Caso utilize GitHub Actions, considere um job que valide `flutter analyze`, `flutter test` e `flutter build web`.

---

## 🧪 Qualidade e CI

- Padronização com `flutter_lints`.
- Sugestão de pipeline: Analyze, Test e Build em cada PR.

---

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE.md) para mais detalhes.

---

## 📫 Contato

**Hendril Mendes**  
- [LinkedIn](https://linkedin.com/in/hendril-mendes)  
- [GitHub](https://github.com/hendrilmendes)  
- **E-mail:** hendrilmendes2015@gmail.com
```

