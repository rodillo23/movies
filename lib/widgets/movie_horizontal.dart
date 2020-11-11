import 'package:flutter/material.dart';
import 'package:movies/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {

  final List<Pelicula> peliculas;
  final Function siguientePagina;

  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

  final _pageController = new PageController(
      initialPage: 1,
      viewportFraction: .25
  );

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

    //Listener del PageView Controller
    _pageController.addListener((){
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200){
        siguientePagina();
      }
    });

    return Container(
      height: screenSize.height * .25,
      child: PageView.builder(
        controller: _pageController,
        pageSnapping: false,
        itemCount: peliculas.length,
        itemBuilder: ( context, i){
          return _tarjeta(context, peliculas[i]);
        },
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula){

    pelicula.uniqueId = '${pelicula.id}-tarjeta';

    final tarjeta =  Container(
      margin: EdgeInsets.only(right: 15),
      child: Column(
        children: [
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                image: NetworkImage(pelicula.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 130,
              ),
            ),
          ),
          SizedBox(
            height: 7,
          ),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );

    return GestureDetector(
      child: tarjeta,
      onTap: (){
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
    );
  }

  /*List<Widget> _tarjetas() {
    return peliculas.map( (pelicula) {

    }).toList();
  }*/
}
