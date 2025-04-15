--rol auditor
-- PRUEBAS OK 
-- add
BEGIN 
    BD1000098857.PA_AUDITOR.auditorias_ad('08','28-MAR-24','D','Nombre 7', 'B003','202403');
END;
    -- mo
BEGIN
    BD1000098857.PA_AUDITOR.auditorias_mo;
END;
-- el
BEGIN
    BD1000098857.PA_AUDITOR.auditorias_el('06');
END;
-- co

SET SERVEROUTPUT ON;
BEGIN
    BD1000098857.PA_AUDITOR.auditorias_print_co;
    
END;


SELECT * FROM BD1000098857.auditorias;
-- Caso de prueba para el procedimiento ad
BEGIN 
    BD1000098857.PA_AUDITOR.evaluaciones_ad('202410', 'CC', 'NID001', SYSDATE, '(A)Descripción evaluación 1', 'https://example.com/evaluacion12.pdf', 'AP', 1);
END;

 
-- Caso de prueba para la función co (imprimir todas las evaluaciones)
BEGIN
    BD1000098857.PA_AUDITOR.evaluaciones_print_co;
END;
-- CASOS NO OK 
-- Caso de prueba para el procedimiento ad con un formato de fecha inválido
BEGIN 
    BD1000098857.PA_AUDITOR.evaluaciones_ad('202410', 'CC', 'NID001', SYSDATE, 'Descripción evaluación 1', 'https://example.com/evaluacion12.pdf', 'AP', 1);
END;
 
-- ===================================================================== ANOMALIAS
-- Caso de prueba para el procedimiento ad
BEGIN
 
    BD1000098857.PA_AUDITOR.anomalias_ad('A002', '202403', 'Texto de prueba', 'P');
 
END;
-- Caso de prueba para el procedimiento mo (actualizar 'prioridad' de la anomalía con ID 'A001' a 'B')
 
BEGIN
 
    BD1000098857.PA_AUDITOR.anomalias_mo('A002', 'prioridad', 'B');
 
END;
-- Caso de prueba para el procedimiento el (eliminar la anomalía con ID 'A001')
 
BEGIN
 
    BD1000098857.PA_AUDITOR.anomalias_el('A002');
 
END;
-- Caso de prueba para la función co (imprimir todas las anomalías)

SET SERVEROUTPUT ON;
BEGIN
 
    BD1000098857.PA_AUDITOR.anomalias_print_co;
 
END;
-- Caso de prueba para la función co_prioridadEstadoPendiente (imprimir todas las anomalías con prioridad 'Estado Pendiente')
 
BEGIN
 
    BD1000098857.PA_AUDITOR.anomalias_print_co_prioridadEstadoPendiente;
 
END;
-- CASOS NO OK  
 
-- Caso de prueba para el procedimiento ad con una anomalía que ya existe (debería fallar)
 
BEGIN
 
    BD1000098857.PA_AUDITOR.anomalias_ad('A001', 'E003', 'Texto de prueba', 'A');
 
END;
-- Caso de prueba para el procedimiento mo con una columna no válida (debería fallar)
 
BEGIN
    BD1000098857.PA_AUDITOR.anomalias_mo('A001', 'columna_invalida', 150);
 
END;
-- Caso de prueba para el procedimiento el con una anomalía que no existe (debería fallar)
 
BEGIN
 
    BD1000098857.PA_AUDITOR.anomalias_el('A999');
 
END;


SELECT * FROM BD1000098857.AUDITORIAS;


---rol administrador
-- CASOS DE PRUEBA
-- Caso de prueba para el procedimiento ad
BEGIN 
    BD1000098857.PA_ADMINISTRADOR.categoria_ad('C011', 'Nombre 7', 'R', 100, 200, 'A003');
END;
 
-- Caso de prueba para el procedimiento mo (actualizar 'minimo' de la categoría con código '06' a 150)
BEGIN
    BD1000098857.PA_ADMINISTRADOR.categoria_mo('C010', 'minimo', 150);
END;
-- Caso de prueba para el procedimiento el (eliminar la categoría con código '06') - CASO DE FRACASO
BEGIN
    BD1000098857.PA_ADMINISTRADOR.categoria_el('D006');
END;

--SELECT * FROM CATEGORIAS;
-- Caso de prueba para la función co (imprimir todas las categorías)

SET SERVEROUTPUT ON;
BEGIN
    BD1000098857.PA_ADMINISTRADOR.categoria_print_co;
END;
 
-- Caso de prueba para la función co_masArticulos (imprimir la categoría con más artículos)
BEGIN
    BD1000098857.PA_ADMINISTRADOR.categoria_print_co_masArticulos;
END;


