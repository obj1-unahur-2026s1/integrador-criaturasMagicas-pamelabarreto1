
class Criatura {
  var  poderMagico
  const astucia
  var  rol 
  
method poderMagico() =poderMagico
 /*
  variarPoderMagicoEn() espera el porcentaje a variar, sea para sumar o para restar
  Para restar argumentar con entero negativo, para sumar con entero positivo
  */
  method variarPoderMagicoEn(porcentaje) { poderMagico *= 1 + porcentaje * 0.01 }
method rol() =rol
method cambiarRol() {rol= rol.cambiarRol()}   
  method poderOfensivo() = poderMagico*10 + rol.extra()
  
method esFormidable() = self.esAstuta() or self.esExtraordinario()
  //esAstuta() es abstracto, no hay definición común que compartir entre subclases ni queremos instanciar una Criatura 'genérica'
  method esAstuta()
  method esExtraordinario() = rol.esExtraordinario(self)

}
//ROLES
class Domador {
  const mascotas=[]
    
  method extra() = 150 * self.cantidadMascotasConCuernos()
  
method todasSonVeteranas() =mascotas.all({m=>m.esVeterano()}) 
method esExtraordinario(criatura) =criatura.poderMagico()>=15 and self.todasSonVeteranas() 
method cambiarRol() = if(self.cantidadMascotasConCuernos()>0)
      return Hechicero 
 else
      self.error("Error, se cancela el cambio.")

method cantidadMascotasConCuernos() = mascotas.count({m=>m.tieneCuernos()})

}
class Mascota inherits Domador {
  const property  tieneCuernos
  const edad
  method esVeterano() =edad>=10 


}
class Guardian {
   

   method extra() = 100
  
method esExtraordinario(criatura)=criatura.poderMagico()>50 

method cambiarRol() = new Domador(mascotas = [new Mascota (edad=1, tieneCuernos=false)])
  

}
class Hechicero {
   method extra() = 0
     
    method esExtraordinario(criatura) = true

method cambiarRol() = Guardian
}
//

class Duende inherits Criatura {
 
  override method poderOfensivo()= super() * 0.1
  method esAstuto() = false
}
class Hada inherits Criatura {
  var kmsQuePuedeVolar=2
//pueder ir aumentando paulatinamente
  // la cantidad de kilometros hasta una máximo de 25.
  method aumentarKmsDeVuelo() { kmsQuePuedeVolar = 25.min(kmsQuePuedeVolar + 1) }
 
method esAstuto() = astucia>50 
  override method esExtraordinario() = super() and kmsQuePuedeVolar > 10

}  

class Area {
  var coloniaQueLoDomina
  method cambiarColonia(unaColonia) {coloniaQueLoDomina=unaColonia}
    method poderDefensivo() {}
  }

class LosClaros inherits Area {
  override method poderDefensivo()=100 + coloniaQueLoDomina.poderOfensivo()
}

class LosCastillos inherits Area{
  override method poderDefensivo()= 200 * coloniaQueLoDomina.cantidadDeCriaturas()
}

class Colonia {
  const criaturas = [] //No necesita getter
  const property criaturas=[]
  method poderOfensivo() = criaturas.sum({ c => c.poderOfensivo() })
  method cantidadDeFormidables() = criaturas.count({ c => c.esFormidable() })
  method porcentajeQueQuitaAlSufrirDerrota() = 15 //Opcional, lo extraigo a método aparte para facilitar mantenimiento
  
  method intentarConquistaDe(area) {
    if (self.poderOfensivo() > area.poderDefensivo()) {
      area.cambiarDominioAColonia(self)
    } else {
      self.sufrirDerrota()
    }
  }
  //Argumenta variarPoderMagicoEn() con negativo, para restar el porcentaje de poder mágico indicado a la criatura 
  // - self.porcentajeQueQuitaAlSufrirDerrota() = - 15
  method sufrirDerrota() { criaturas.forEach({ c => c.variarPoderMagicoEn(- self.porcentajeQueQuitaAlSufrirDerrota()) }) }
}