# Script: Verificar-MD5.ps1
# Autor: Daniel Carralero Benito
# Descripción: Comprueba la integridad de un archivo utilizando el algoritmo MD5.

param (
    [Parameter(Mandatory=$true)]
    [string]$Archivo,  # Ruta del archivo a verificar

    [Parameter(Mandatory=$true)]
    [string]$HashMD5   # Hash MD5 esperado
)

# Función para calcular el hash MD5 de un archivo
function Calcular-HashMD5 {
    param (
        [string]$RutaArchivo
    )

    if (-not (Test-Path $RutaArchivo)) {
        Write-Error "El archivo especificado no existe: $RutaArchivo"
        exit 1
    }

    # Leer el contenido del archivo y calcular su hash MD5
    try {
        $Hash = Get-FileHash -Path $RutaArchivo -Algorithm MD5
        return $Hash.Hash
    } catch {
        Write-Error "Error al calcular el hash MD5 del archivo: $_"
        exit 1
    }
}

# Calcular el hash del archivo proporcionado
$HashCalculado = Calcular-HashMD5 -RutaArchivo $Archivo

# Comparar el hash calculado con el hash esperado
if ($HashCalculado -eq $HashMD5) {
    Write-Host "La integridad del archivo es VÁLIDA." -ForegroundColor Green
} else {
    Write-Host "La integridad del archivo es INVÁLIDA." -ForegroundColor Red
    Write-Host "Hash esperado:   $HashMD5"
    Write-Host "Hash calculado: $HashCalculado"
}
