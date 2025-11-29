import 'package:flutter/material.dart';

void TelaHome() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EHSync',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Cor de fundo principal da tela
        scaffoldBackgroundColor: const Color.fromARGB(255, 87, 153, 240), 
        // Define uma fonte padrão que se assemelha à da imagem
        fontFamily: 'Roboto', 
        textTheme: const TextTheme(
          headlineSmall: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255)),
          titleMedium: TextStyle(fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(color: Colors.black54),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0; // Índice da BottomNavigationBar
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(context),
              _buildProfileCard(context),
              _buildSectionTitle(context, 'Continue de onde parou'),
              _buildContinueLearningCard(context),
              _buildSectionTitle(context, 'Recomendados para você'),
              _buildRecommendationsList(context),
              _buildSectionTitle(context, 'Categorias'),
              _buildCategoryTabs(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Tela Inicial',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search), // Ícone de catálogo (usei 'search')
            label: 'Catálogo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Meu perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }

  /// Constrói a barra superior com menu, saudação e configurações
  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.menu, size: 30),
          Text(
            'Boas vindas, Nicholas',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
          ),
          const Icon(Icons.settings_outlined, size: 30),
        ],
      ),
    );
  }

  /// Constrói o card de perfil do usuário
  Widget _buildProfileCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          // Cor de fundo do card de perfil
          color: const Color.fromARGB(255, 190, 213, 243), 
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          children: [
            // Substitua 'assets/images/avatar.png' pelo caminho do seu avatar
            const CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              // Use Image.asset('assets/images/avatar.png') se tiver a imagem
              child: Icon(Icons.person, size: 30, color: Color.fromARGB(255, 6, 88, 194)), 
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nicholas Wang',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.workspace_premium_outlined, color: Colors.grey[700], size: 20),
                    const SizedBox(width: 5),
                    Text(
                      '28 Certificados',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Constrói um título de seção
  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 20),
      ),
    );
  }

  /// Constrói o card "Continue de onde parou"
  Widget _buildContinueLearningCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        clipBehavior: Clip.antiAlias, // Para cortar a imagem
        child: Row(
          children: [
            // Substitua pelo seu placeholder
            Image.asset(
              'assets/images/continuar.png', // Placeholder
              width: 130,
              height: 140,
              fit: BoxFit.cover,
              // Fallback em caso de erro ao carregar a imagem
              errorBuilder: (context, error, stackTrace) => 
                Container(width: 130, height: 140, color: Colors.grey[300], child: Icon(Icons.image, color: Colors.grey[600])),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Python para análise de dados',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    // Barra de progresso
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: 0.7, // 70% de progresso
                        backgroundColor: Colors.grey[300],
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                        minHeight: 6,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Capítulo 3: Bibliotecas Essenciais Domine NumPy, Pandas e Matplotlib...',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 30, 64, 114), // Cor de fundo clara
                        foregroundColor: Colors.blue, // Cor do texto
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text('Continuar aula'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Constrói a lista horizontal de recomendações
  Widget _buildRecommendationsList(BuildContext context) {
    // Dados mocados para os cards
    final recommendations = [
      {
        'image': 'assets/images/curso1.png',
        'title': 'Python para Automação: De Tarefas Repetitivas a Robôs Pessoais',
        'author': 'Thomás Tabosa',
      },
      {
        'image': 'assets/images/curso2.png',
        'title': 'Sua Primeira API com Node.js: Dos Fundamentos à Prática',
        'author': 'Eduardo Tavares',
      },
    ];

    return Container(
      height: 230, // Altura fixa para a lista horizontal
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 16.0),
        itemCount: recommendations.length,
        itemBuilder: (context, index) {
          final item = recommendations[index];
          return _buildRecommendationCard(
            context,
            item['image']!,
            item['title']!,
            item['author']!,
          );
        },
      ),
    );
  }

  /// Constrói um card individual de recomendação
  Widget _buildRecommendationCard(BuildContext context, String imagePath, String title, String author) {
    return Container(
      width: 200, // Largura fixa para cada card
      margin: const EdgeInsets.only(right: 16.0),
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imagePath,
              width: 200,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => 
                Container(width: 200, height: 100, color: Colors.grey[300], child: Icon(Icons.image, color: Colors.grey[600])),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    author,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '5,0',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange[800],
                            ),
                      ),
                      const SizedBox(width: 4),
                      // Estrelas de avaliação
                      ...List.generate(
                        5,
                        (i) => Icon(Icons.star, color: Colors.amber[600], size: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Constrói as abas de categorias
  Widget _buildCategoryTabs(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TabBar(
        controller: _tabController,
        isScrollable: false, // Fixo como na imagem
        labelColor: const Color.fromARGB(255, 8, 7, 63),
        unselectedLabelColor: const Color.fromARGB(255, 255, 255, 255),
        indicatorColor: const Color.fromARGB(255, 12, 23, 68),
        indicatorWeight: 3.0,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        tabs: const [
          Tab(text: 'Tecnologia'),
          Tab(text: 'Marketing Digital'),
          Tab(text: 'Soft Skills'),
        ],
      ),
    );
    // Para uma versão completa, você envolveria isso e um TabBarView
    // em um DefaultTabController ou usaria o _tabController
    // para exibir conteúdo diferente abaixo das abas.
  }
}