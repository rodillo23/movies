import 'package:flutter/material.dart';
import 'package:movies/models/actores_model.dart';
import 'package:movies/models/pelicula_model.dart';
import 'package:movies/providers/peliculas_provider.dart';

class PeliculaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;
    final sizeScreen = MediaQuery.of(context).size;
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _appBar(pelicula, sizeScreen),
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(
              height: 15.0,
            ),
            _posterTitulo(context, pelicula),
            _descripcion(pelicula),
            _descripcion(pelicula),
            _descripcion(pelicula),
            _crearCasting(pelicula)
          ]),
        )
      ],
    ));
  }

  Widget _appBar(Pelicula pelicula, Size size) {
    return SliverAppBar(
      elevation: 2,
      floating: false,
      pinned: true,
      expandedHeight: size.height * .30,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          pelicula.title,
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
        centerTitle: true,
        background: FadeInImage(
          image: NetworkImage(pelicula.getBackdropImg()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitulo(BuildContext context, Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                image: NetworkImage(pelicula.getPosterImg()),
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pelicula.title,
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 10),
                Text(
                  pelicula.originalTitle,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                Row(
                  children: [
                    Icon(Icons.star),
                    Text(
                      pelicula.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subtitle2,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _descripcion(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _crearCasting(Pelicula pelicula) {
    final peliculasProvider = new PeliculasProvider();

    return FutureBuilder(
      future: peliculasProvider.getActores(pelicula.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _crearPageViewActores(snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearPageViewActores(List<Actor> actores){
    return SizedBox(
      height: 200,
      child: PageView.builder(
        itemCount: actores.length,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1
        ),
        pageSnapping: false,
        itemBuilder: (context, i){
          return _actorTarjeta(actores[i]);
        },
      ),
    );
  }

  Widget _actorTarjeta(Actor actor) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              image: NetworkImage(actor.getFoto()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              fit: BoxFit.cover,
              height: 150,
            ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
