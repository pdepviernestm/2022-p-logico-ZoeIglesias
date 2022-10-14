%trabaja(Nombre,Trabajo,CantHoras).

%empleoPrivado(Empresa, Rubro). 
%empleoPublico(Organismo, Dependencia, Rubro).
%planSocial(Organizacion).  

%trabaja(Nombre,Trabajo,CantHoras).
%Trabajos posibles

%empleoPrivado(Empresa, Rubro). 
%empleoPublico(Organismo, Dependencia, Rubro).
%planSocial(Organizacion).  

trabaja(juan, empleoPrivado(elAbierto,tenis), 6).
trabaja(agustin, empleoPrivado(minimalart, desarrolloWeb),4).
trabaja(juanfe, empleoPrivado(abertec, desarrolloWeb), 6).
trabaja(juanfe, empleoPublico(anses, nacional, desarrolloWeb), 6).
trabaja(nicolas, empleoPrivado(abertec, ayudanteLaboratorio),8).
trabaja(nahuel, empleoPrivado(ptresk, dataEngineer), 6).
trabaja(rocio, empleoPrivado(ptresk, desarrolloWeb), 6).
trabaja(juani, empleoPrivado(ptresk, robos),5).
trabaja(matias,empleoPrivado(mercadoLibre, seguridadInformatica),8).
trabaja(jorge, planSocial(upl), 3).
trabaja(valentin, planSocial(uqbar), 3).
trabaja(nahuel, empleoPublico(ministerioSalud, caba, ayudanteLaboratorio), 6).
%estudia(Nombre,Carrera,Universidad).

% COMPLETAR ACA 
estudia(valentin,sistemas,utn).
estudia(juan,sistemas,utn).
estudia(juan,medicina,uba).
estudia(alejo,sistemas,utn).
estudia(nicolas,medicina,uba).
estudia(juanfe,sistemas,utn).
estudia(nicolas, administracion, uade).
estudia(franco, sistemas, utn).
estudia(fernando,electronica,utn).
estudia(agustin,sistemas, utn).
estudia(luciano,sistemas, utn).
estudia(tao,sistemas,utn).
estudia(andres, sistemas, utn).
estudia(pedro, derecho, uba).
estudia(delfina,derecho,uba).
estudia(milagros,medicina,unr).
estudia(valentino,veterinaria,unr).
estudia(nahuel, medicina, uba).
estudia(rocio, derecho, uncoma).
estudia(zoe,musica,emba).
estudia(catalina,medicina,unlp).

estudia(alguien,artes,usal).


% INFO ADICIONAL

%organizacion(Organizacion,Rubro).
%habilitacionProfesional(Carrera,ListaDeRubros).

organizacion(uqbar, desarrolloLenguajes).
organizacion(movimiento19Agosto,seguridadInformatica).
organizacion(upl, agro).

habilitacionProfesional(sistemas,[desarrolloWeb,analista,programador,pasanteIT, dataEngineer]).
habilitacionProfesional(medicina, [cientifico, ayudanteLaboratorio]).
habilitacionProfesional(derecho,[divorcios, accidentesViales, robos]).
habilitacionProfesional(veterinaria,[inseminacion]).
habilitacionProfesional(electronica,[seguridadInformatica,pasanteIT]).

universidad(Universidad):-
    estudia(_,_,Universidad).

estudiante(Estudiante):-
    estudia(Estudiante,_,_).

carrera(Carrera):- 
    estudia(_,Carrera,_).


rubro(empleoPrivado(_,Rubro), Rubro).
rubro(empleoPublico(_,_,Rubro),Rubro).
rubro(planSocial(Organizacion),Rubro):-
    organizacion(Organizacion,Rubro).

% 1.)
esObrera(Universidad):-
    universidad(Universidad),
    forall(estudia(Estudiante,_,Universidad), trabaja(Estudiante,_,_)).
    
    esExigente(Carrera,Universidad):-
    estudia(_,Carrera,Universidad),
    forall(estudia(Estudiante,Carrera,Universidad), not(trabaja(Estudiante,_,_))).

% 2.)
esExigente(Carrera,Universidad):-
    estudia(_,Carrera,Universidad),
    forall(estudia(Estudiante,Carrera,Universidad),(not(estudia(Estudiante,OtraCarrera,_)),Carrera \= OtraCarrera)).

% 3.)
universidadTrabajadora(Universidad):-
    porcentajeEstudiantesTrabajadores(Universidad,Porcentaje),
    forall((porcentajeEstudiantesTrabajadores(OtraUniversidad,Porcentaje2), Universidad \= OtraUniversidad), Porcentaje > Porcentaje2).


cantidadDeTrabajadores(Universidad,CantidadDeTrabajadores):-
    universidad(Universidad),
    findall(Estudiante,(estudia(Estudiante,_,Universidad), trabaja(Estudiante,_,_)), ListaCantTrabajadores),
    length(ListaCantTrabajadores, CantidadDeTrabajadores).

cantidadDeEstudiantes(Universidad,CantidadDeEstudiantes):-
    universidad(Universidad),
    findall(Estudiante,estudia(Estudiante,_,Universidad), ListaDeEstudiantes),
    length(ListaDeEstudiantes, CantidadDeEstudiantes).

porcentajeEstudiantesTrabajadores(Universidad, Porcentaje):-
    universidad(Universidad),
    cantidadDeEstudiantes(Universidad,CantidadDeEstudiantes),
    cantidadDeTrabajadores(Universidad,CantidadDeTrabajadores),
    CantidadDeTrabajadores \= 0,
    Porcentaje is ((CantidadDeEstudiantes * 10) / CantidadDeTrabajadores).

% 4.)
trabajaEnOtraCosa(Estudiante):-
    estudia(Estudiante,_,_),
    trabaja(Estudiante,_,_),
    forall((trabaja(Estudiante,Trabajo,_), rubro(Trabajo,Rubro)), not(estaVinculado(Estudiante,Rubro))).

estaVinculado(Estudiante,Rubro):-
    estudia(Estudiante,Carrera,_),
    habilitacionProfesional(Carrera,ListaDeRubros),
    member(Rubro,ListaDeRubros).

% 5.)
carrerasDemandadas(Carrera):-
    carrera(Carrera),
    forall((estudia(Estudiante,Carrera,_), trabaja(Estudiante,Trabajo,_), rubro(Trabajo,Rubro)), estaVinculado(Estudiante,Rubro)).
   
  /* Trabajo Creativo */

/* La nueva modalidad de trabajo emprendedor se podria agregar muy facilmente a nuestra base de conocimientos;
    al igual que las otras modalidades se utilizaria como un functor de aridad 2 de la siguiente manera
    
    trabaja(persona,emprendedor(NombreDelEmprendimiento, Rubro),CantidadDeHoras).

    Ejemplo:
     
        trabaja(juana,emprendedor(juanArte, pinturas),_).

    Supongamos que Juana a su vez tmb estudia artes escenicas

        estudia(juana,arte,uba).

    Tambien contantamos con la habilitacion profesional de las arte

        habilitacionProfesional(arte,[actuacion, escultura, pintura, musica]).

    Solo nos quedaria agregar seria otro hecho en el predicado rubro que nos de el trabajo de la persona, 
    es decir le pasamos el functor y nos duvuelve solo el trabajo, esto al igual que hemos hecho con los otros trabajos,
    se puede definir de manera muy facil de la siguiente manera.

        rubro(emprendedor(_,Rubro),Rubro).

    Como podemos observar no es necesario cambiar muchas cosas de nuetsro codigo si necesitamos
    agregar nuevas cosas, como un nuevo trabajo, a este concepto se lo conoce como acoplamiento,
    que es el grado en el que los componentes se conocen.*/

