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
