#!/bin/bash

function uno() {
    echo -e "\n Ingrese la ruta del directorio"
    read -p "Ruta: " path
    if [ -d "$path" ]; then
        echo "El contenido del directorio $path es:"
        ls "$path"
        read -p ""
    else
        echo "La rduta $path no es un directorio válido."
        read -p ""
    fi
}

function dos() {
    echo -e "\n Ingrese el nombre del archivo"
    read -p "Nombre: " file
    echo -e "\n Ingrese el texto que desea guardar en el archivo"
    read -p "Texto: " text
    echo "$text" > "$file.txt"
    echo "Archivo $file.txt creado con éxito."
    read -p ""
}

function tres() {
    echo -e "\n Ingrese el nombre del primer archivo"
    read -p "Archivo 1: " file1
    echo -e "\n Ingrese el nombre del segundo archivo"
    read -p "Archivo 2: " file2
    if ! [ -f "$file1" ]; then
        echo "El archivo $file1 no existe."
        return
    fi
    if ! [ -f "$file2" ]; then
        echo "El archivo $file2 no existe."
        return
    fi

    if cmp -s "$file1" "$file2"; then
        echo "Los archivos son iguales."
    else
        echo "Los archivos son diferentes."
    fi
    read -p ""
}

function cuatro() {
    echo -e "\nIngrese las columnas que desea extraer (ejemplo: 1,2,3)"
    read -p "Columnas: " columns

    ps aux | awk -v cols="$columns" '
    BEGIN {
        n = split(cols, colArray, ",")
    }
    {
        output = ""
        for (i = 1; i <= n; i++) {
            output = output $colArray[i] "\t"
        }
        print output
    }'
    
    echo "Procesos extraídos con éxito"
    read -p ""
}


function cinco() {
    echo -e "\n Ingrese el nombre del archivo"
    read -p "Archivo: " file
    echo -e "\n Ingrese la palabra que desea buscar"
    read -p "Palabra: " word

    if ! [ -f "$file" ]; then
        echo "El archivo $file no existe."
        return
    fi
    
    if grep -q "$word" "$file"; then
        echo -e "\nLa palabra '$word' se encuentra en las siguientes lineas del archivo $file:\n"
        grep -n --color=always "$word" "$file"
    else
        echo "La palabra '$word' no se encuentra en el archivo $file."
    fi
    read -p ""
}


while true;
do

    echo "Menu de opciones"
    echo "1. Listar el contenio de un directorio"
    echo "2. Crear un archivo txt con un texto"
    echo "3. Comparar dos archivos de texto"
    echo "4. Extraer columnas de la tabla de procesos con awk"
    echo "5. Buscar una palabra en un archivo con grep"
    echo "6. Salir"

    read -p "Seleccione una opción: " option
    case $option in
        1) uno ;;
        2) dos ;;
        3) tres ;;
        4) cuatro ;;
        5) cinco ;;
        6) echo "Saliendo..."; exit 0 ;;
        *) echo "Opción no válida. Intente de nuevo." ;;
    esac

done