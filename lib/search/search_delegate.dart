import 'package:flutter/material.dart';
import 'package:movies/models/pelicula_model.dart';
import 'package:movies/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate{

  String seleccion = "";

  final peliculasProvider = new PeliculasProvider();

  final peliculas = [
    'Frozen',
    'Frozen II',
    'Toy Story',
    'Rey Leon',
    'Sirenita',
    'Dumbo',
    'Minions',
    'Monsters Inc'
  ];

  final peliculasRecientes = [
    'Mercenarios de Elite',
    'Como perros y gatos',
    'En guerra',
    'Alone',
    'Trolls 2',
    'Cuenta Pendiente',
    'Rogue'
  ];

  @override
  // podemos cambiar el hint del label
  String get searchFieldLabel => 'Buscar';

  @override
  // estilo del buscador
  TextStyle get searchFieldStyle => TextStyle(color: Colors.white,);

  @override
  ThemeData appBarTheme(BuildContext context) {
    // TODO: implement appBarTheme
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: Colors.black54
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro appbar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del appbaR
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      },
    );

  }

  @override
  Widget buildResults(BuildContext context) {
    //crea los resultados que vamos a mostrar
    return Center(
      child: Container(
        color: Colors.amber,
        width: 100,
        height: 100,
        child: Center(
          child: Text(seleccion),
        ),
      ),
    );
  }

  @override
  //Son las sugerencias que aparecen cuando la persona excribe
  Widget buildSuggestions(BuildContext context) {
    if(query.isEmpty){
      return Container();
    }

    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot){
        if(snapshot.hasData){
          final peliculas = snapshot.data;
          return ListView(
            children: peliculas.map((pelicula){
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(pelicula.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(pelicula.title),
                subtitle: Text(pelicula.originalTitle),
                onTap: (){
                  close(context, null);
                  pelicula.uniqueId = '';
                  Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                },
              );
            }).toList()
          );
        }else{
          return CircularProgressIndicator();
        }
      },
    );
  }

}





/*final listaSugerida = (query.isEmpty) ? peliculas
        : peliculas.where((element) => element.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: listaSugerida.length,
      itemBuilder: (context, index){
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(listaSugerida[index]),
          subtitle: Text(listaSugerida[index]),
          onTap: (){
            seleccion = listaSugerida[index];
            showResults(context);
          },
        );
      },
    );*/
