-- DONACIONES XML
INSERT INTO donaciones ( fecha, cantidad, tipo,nit_empresa, fundaciones)
VALUES (
  SYSDATE,
  10,
  'D',
  '1',
  XMLType(
    '<fundaciones>
      <fundacion>
        <nombre>Banco de Alimentos Ciudad</nombre>
        <descripcion>Proporciona alimentos a personas necesitadas en la ciudad.</descripcion>
      </fundacion>
      <fundacion>
        <nombre>Fundaci�n Comida Para Todos</nombre>
        <descripcion>Se dedica a distribuir comida en comunidades marginadas.</descripcion>
      </fundacion>
      <fundacion>
        <nombre>Red Solidaria de Alimentos</nombre>
        <descripcion>Red de voluntarios que recolecta y distribuye alimentos.</descripcion>
      </fundacion>
    </fundaciones>'
  )
);    


SELECT 
    d.id,
    d.fecha,
    d.cantidad,
    d.tipo,
    d.nit_empresa,
    xt.fundacion_nombre,
    xt.fundacion_descripcion
FROM 
    donaciones d,
    XMLTable('/fundaciones/fundacion' 
             PASSING d.fundaciones 
             COLUMNS 
                fundacion_nombre VARCHAR2(100) PATH 'nombre',
                fundacion_descripcion VARCHAR2(500) PATH 'descripcion'
             ) xt;
             
             
-- PUBLICIDAD XML  

INSERT INTO Publicidad (publicidad) VALUES (
    XMLType('<anuncio>
<idea>DELIZIA, UN PROYECTO QUE CAMBIAR� TU VIDA, REDUCE EL DESPERDICIO DE COMIDA INALCANZABLEMENTE. 
					  PODR�S PEDIR DIFERENTES MEN�S Y CADA UNO CON DISTINTOS PLATOS, EL CUAL ESE PLATO SE GENERA DE MANERA ALEATORIO. 	
					  SORPRENDENTE, VERDAD? 
					  SIENDO EL PLATO ALEATORIO, EL COSTO NO SER� PROPORCIONAL AL PRECIO ORIGINAL, 
					  SE REDUCIR� DEPENDIENDO DEL TIPO DE MEN� QUE ESCOJAS. 
					  PUEDES ELEGIR SI QUIERES UN ENV�O DIRECTO A TU UBICACI�N DE RESIDENCIA O PUEDES IR A RECOGERLO EN TIENDAS DISPONIBLES. 
</idea>
<titulo>�SI EST�S INTERESADO, PUEDES COMPARTIR A TUS FAMILIARES Y AMIGOS!</titulo>
<descripcion> MOT�VATE A PROBAR ESTA NUEVA EXPERIENCIA GASTRON�MICA!</descripcion>
<vigencia>EL FUTURO ES HOY!</vigencia>
</anuncio>')
);                

-- Consulta para extraer informaci�n del XML almacenado en la columna 'publicidad'
SELECT 
    ExtractValue(publicidad, '/anuncio/idea/text()') AS idea,
    ExtractValue(publicidad, '/anuncio/titulo/text()') AS titulo,
    ExtractValue(publicidad, '/anuncio/descripcion/text()') AS descripcion,
    ExtractValue(publicidad, '/anuncio/vigencia/text()') AS vigencia
FROM 
    Publicidad;