from sys import stdin
import xml.etree.ElementTree as ET


def main():
    n = 2000
    for i in range (n):
        line = stdin.readline ().strip ().split (",")
        constante = "insert into donaciones (fecha, cantidad, tipo, nit_empresa, fundaciones) values ("
        fecha = "TO_DATE('2022-12-28', 'YYYY-MM-DD')"  # Ajusta la fecha aquí si es necesario

        # Crear el XML usando ElementTree
        fundaciones = ET.Element ("fundaciones")

        fundacion1 = ET.SubElement (fundaciones, "fundacion")
        nombre1 = ET.SubElement (fundacion1, "nombre")
        nombre1.text = "Banco de Alimentos Ciudad"
        descripcion1 = ET.SubElement (fundacion1, "descripcion")
        descripcion1.text = "Proporciona alimentos a personas necesitadas en la ciudad."

        fundacion2 = ET.SubElement (fundaciones, "fundacion")
        nombre2 = ET.SubElement (fundacion2, "nombre")
        nombre2.text = "Fundación Comida Para Todos"
        descripcion2 = ET.SubElement (fundacion2, "descripcion")
        descripcion2.text = "Se dedica a distribuir comida en comunidades marginadas."

        fundacion3 = ET.SubElement (fundaciones, "fundacion")
        nombre3 = ET.SubElement (fundacion3, "nombre")
        nombre3.text = "Red Solidaria de Alimentos"
        descripcion3 = ET.SubElement (fundacion3, "descripcion")
        descripcion3.text = "Red de voluntarios que recolecta y distribuye alimentos."

        # Convertir el XML a una cadena
        fundaciones_xml = ET.tostring (fundaciones, encoding='unicode')

        if len (line) >= 4:
            print (f"{constante}{fecha}, {line[1]}, {line[2]}, {line[3]}, XMLType('{fundaciones_xml}'));")


if __name__ == "__main__":
    main ()
