import requests
from openpyxl import Workbook

# URL de la factura electrónica
url = "https://siat.impuestos.gob.bo/consulta/QR?nit=146058022&cuf=9FE62D2B5D43F052F332D1B6E24E706475D56366684929C3F4F51F74&numero=8007&t=1"

# Realizar la solicitud GET
response = requests.get(url)

# Verificar si la solicitud fue exitosa
if response.status_code == 200:
    # Obtener el contenido XML
    xml_content = response.text

    # Guardar el contenido XML en un archivo
    with open("factura.xml", "w", encoding="utf-8") as xml_file:
        xml_file.write(xml_content)
    print("XML guardado con éxito en 'factura.xml'")

    # Crear un archivo Excel y agregar el contenido XML
    workbook = Workbook()
    sheet = workbook.active
    sheet.title = "Factura Electrónica"

    # Agregar el contenido XML a la primera celda
    sheet["A1"] = xml_content

    # Guardar el archivo Excel
    workbook.save("factura.xlsx")
    print("Archivo Excel guardado con éxito en 'factura.xlsx'")
else:
    print(f"Error al obtener el XML: {response.status_code}")