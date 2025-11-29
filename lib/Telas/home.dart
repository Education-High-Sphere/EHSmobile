import 'package:flutter/material.dart';

class TelaHome extends StatefulWidget {
  const TelaHome({super.key});

  @override
  State<TelaHome> createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
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
      // Movi a cor que estava no theme do seu código antigo para cá
      backgroundColor: const Color.fromARGB(255, 87, 153, 240), 
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
            icon: Icon(Icons.search),
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

  // --- WIDGETS AUXILIARES (Mantive idênticos ao seu código) ---

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.menu, size: 30, color: Colors.white), // Adicionei cor branca para contraste
          Text(
            'Boas vindas, Nicholas',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const Icon(Icons.settings_outlined, size: 30, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 190, 213, 243),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 30, color: Color.fromARGB(255, 6, 88, 194)),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nicholas Wang',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.workspace_premium_outlined, color: Colors.grey[700], size: 20),
                    const SizedBox(width: 5),
                    Text(
                      '28 Certificados',
                      style: const TextStyle(color: Colors.black54),
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

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget _buildContinueLearningCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            // Placeholder para imagem
            Container(
              width: 130, 
              height: 140, 
              color: Colors.grey[300], 
              child: const Icon(Icons.image, size: 50, color: Colors.grey),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Python para análise de dados',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: 0.7,
                        backgroundColor: Colors.grey[300],
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                        minHeight: 6,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Capítulo 3: Bibliotecas Essenciais...',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 30, 64, 114),
                        foregroundColor: Colors.white, // Ajustei texto para branco para ler melhor
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
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

  Widget _buildRecommendationsList(BuildContext context) {
    // Lista simplificada para evitar erro de assets faltando
    final recommendations = [
      {'title': 'Python para Automação', 'author': 'Thomás Tabosa'},
      {'title': 'Sua Primeira API', 'author': 'Eduardo Tavares'},
    ];

    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 16.0),
        itemCount: recommendations.length,
        itemBuilder: (context, index) {
          final item = recommendations[index];
          return _buildRecommendationCard(
            context,
            item['title']!,
            item['author']!,
          );
        },
      ),
    );
  }

  Widget _buildRecommendationCard(BuildContext context, String title, String author) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 16.0),
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Container(
              width: 200, 
              height: 100, 
              color: Colors.grey[300], 
              child: const Icon(Icons.code, color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    author,
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '5,0',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange[800]),
                      ),
                      const SizedBox(width: 4),
                      ...List.generate(5, (i) => Icon(Icons.star, color: Colors.amber[600], size: 16)),
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

  Widget _buildCategoryTabs(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TabBar(
        controller: _tabController,
        isScrollable: false,
        labelColor: const Color.fromARGB(255, 8, 7, 63),
        unselectedLabelColor: const Color.fromARGB(255, 255, 255, 255),
        indicatorColor: const Color.fromARGB(255, 12, 23, 68),
        indicatorWeight: 3.0,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        tabs: const [
          Tab(text: 'Tecnologia'),
          Tab(text: 'Mkt Digital'), // Abreviei para caber melhor na tela
          Tab(text: 'Soft Skills'),
        ],
      ),
    );
  }
}