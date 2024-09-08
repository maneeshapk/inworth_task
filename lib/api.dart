import 'package:flutter/material.dart';
import 'package:demo/model.dart'; 
import 'package:http/http.dart' as http;
import 'dart:convert';

class SuperheroList extends StatefulWidget {
  const SuperheroList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SuperheroListState createState() => _SuperheroListState();
}

class _SuperheroListState extends State<SuperheroList> {
  List<Heros> heroes = [];
  List<Heros> filteredHeroes = []; 
  bool _isSearching = false;
  // ignore: prefer_final_fields
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchDatas(); 
    _searchController.addListener(_filterHeroes); 
  }


  Future<void> fetchDatas() async {
    final response = await http.get(
      Uri.parse('https://protocoderspoint.com/jsondata/superheros.json'),
    );

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final List<dynamic> heroDetails = data['superheros'] as List<dynamic>;
    final List<Heros> fetchedHeroes = heroDetails
        .map((heroMap) => Heros.fromMap(heroMap as Map<String, dynamic>))
        .toList();

    setState(() {
      heroes = fetchedHeroes;
      filteredHeroes = heroes; 
    });
  }

  
  void _filterHeroes() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredHeroes = heroes.where((hero) {
        return hero.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _showHeroDetails(BuildContext context, Heros hero) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(hero.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(hero.url, height: 150),
              const SizedBox(height: 10),
              Text('Power: ${hero.power}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                style: const TextStyle(color: Color.fromARGB(255, 62, 58, 58)),
                decoration: const InputDecoration(
                  hintText: 'Search name',
                  hintStyle: TextStyle(color: Color.fromARGB(137, 44, 42, 42),fontSize:25),
                  border: InputBorder.none,
                ),
              )
            : const Text('SUPER HEROES LIST'),
            backgroundColor: const Color.fromARGB(255, 135, 101, 113),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search,),
            iconSize: 40,
            onPressed: () {
              setState(() {
                if (_isSearching) {
              
                  _isSearching = false;
                  filteredHeroes = heroes;
                } else {
                  _isSearching = true;
                }
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: filteredHeroes.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: filteredHeroes.length,
                itemBuilder: (context, index) {
                  final hero = filteredHeroes[index];
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showHeroDetails(context, hero);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(hero.url),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        hero.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
