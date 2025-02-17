import requests
from bs4 import BeautifulSoup

# URL de la factura electrónica
url = "https://siat.impuestos.gob.bo/consulta/QR?nit=146058022&cuf=9FE62D2B5D43F052F332D1B6E24E706475D56366684929C3F4F51F74&numero=8007&t=2"

# Realizar la solicitud GET para obtener el contenido de la página
response = requests.get(url)

# Verificar si la solicitud fue exitosa
if response.status_code == 200:
    # Analizar el contenido HTML de la página
    soup = BeautifulSoup(response.text, 'html.parser')

    # Encontrar el enlace al PDF (suponiendo que el botón tiene un atributo href con el enlace al PDF)
    pdf_link = soup.find('a', text='Ver factura')['href']

    # Realizar la solicitud GET para descargar el PDF
    pdf_response = requests.get(pdf_link)

    # Verificar si la solicitud fue exitosa
    if pdf_response.status_code == 200:
        # Guardar el PDF en un archivo
        with open("factura2.pdf", "wb") as pdf_file:
            pdf_file.write(pdf_response.content)
        print("PDF guardado con éxito en 'factura2.pdf'")
    else:
        print(f"Error al descargar el PDF: {pdf_response.status_code}")
else:
    print(f"Error al obtener el contenido de la página: {response.status_code}")