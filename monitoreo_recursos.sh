# Archivo para guardar los datos de los recursos
file="reporte_recursos.txt"

# Imprimimos los títulos de cada columna
echo -e "Tiempo\t%CPU Libre\t%Memoria Libre\t%Disco Libre" > $file

# Creamos la función para realizar el monitoreo cada 60 segundos
for tiempo in 60 120 180 240 300; do
    
    cpu_libre=$(top -bn1 | grep "Cpu(s)" | cut -d' ' -f11)
    #El comando top -bn1 nos presenta un reporte instantáneo y grep filtra la línea del CPU
    #El comando cut -d' ' -f11 separa los datos por espacios y nos permite extraer el valor que contiene el porcentaje "idle" que es el tiempo que el cpu está inactivo

    memoria_libre=$(free | grep Mem | awk '{printf($4/$2 * 100)}')
    #El comando free muestra el uso de memoria y awk calcula el porcentaje de memoria libre

    disco_libre=$(df -h / | grep '/' | awk '{print $4}' | sed 's/%//')
    #df -h muestra el uso de disco en el directorio raíz y awk '{print $4}' extrae el porcentaje libre.

    # Escribimos los datos en el archivo de salida
    echo -e "${tiempo}s\t${cpu_libre}\t\t${memoria_libre}\t\t${disco_libre}" >> $output_file

    # Esperamos 60 segundos antes de realizar la próxima medición.
    sleep 60
done

echo "Monitoreo completado. Los datos se han guardado en $file"