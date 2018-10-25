# Nim-GeoRefAr

[GeoRef Argentina](https://georef-ar-api.readthedocs.io) MultiSync API Lib for [Nim](https://nim-lang.org)
*(All Docs on Spanish because its for Argentina)*


# Uso

```nim
import georefar

## Sync client.
let georefar_client = GeoRefAr(timeout: 9)  # Timeout en Segundos.
## Las consultas en formato JSON son copiadas desde la Documentacion de la API.
var consulta = %* {
  "provincias": [
    {
      "id": "string",
      "nombre": "string",
      "interseccion": "provincia:82,departamento:82084,municipio:820196",
      "orden": "id",
      "aplanar": true,
      "campos": "id,nombre",
      "max": 10,
      "inicio": 10,
      "exacto": true
    }
  ]
}
echo georefar_client.provincias(consulta).pretty

consulta = %* {
  "departamentos": [
    {
      "id": "string",
      "nombre": "string",
      "provincia": "Santa Fe",
      "interseccion": "provincia:82,departamento:82084,municipio:820196",
      "orden": "id",
      "aplanar": true,
      "campos": "id,nombre",
      "max": 10,
      "inicio": 10,
      "exacto": true
    }
  ]
}
echo georefar_client.departamentos(consulta).pretty

consulta = %* {
  "municipios": [
    {
      "id": "string",
      "nombre": "string",
      "provincia": "Santa Fe",
      "interseccion": "provincia:82,departamento:82084,municipio:820196",
      "orden": "id",
      "aplanar": true,
      "campos": "id,nombre",
      "max": 10,
      "inicio": 10,
      "exacto": true
    }
  ]
}
echo georefar_client.municipios(consulta).pretty

consulta = %* {
  "localidades": [
    {
      "id": "string",
      "nombre": "string",
      "provincia": "Santa Fe",
      "departamento": "Rosario",
      "municipio": "Granadero Baigorria",
      "orden": "id",
      "aplanar": true,
      "campos": "id,nombre",
      "max": 10,
      "inicio": 10,
      "exacto": true
    }
  ]
}
echo georefar_client.localidades(consulta).pretty

consulta = %* {
  "calles": [
    {
      "id": "string",
      "nombre": "string",
      "tipo": "calle",
      "provincia": "Santa Fe",
      "departamento": "Rosario",
      "orden": "id",
      "aplanar": true,
      "campos": "id,nombre",
      "max": 10,
      "inicio": 10,
      "exacto": true
    }
  ]
}
echo georefar_client.calles(consulta).pretty

consulta = %* {
  "direcciones": [
    {
      "direccion": "Urquiza 400",
      "tipo": "calle",
      "provincia": "Santa Fe",
      "departamento": "Rosario",
      "orden": "id",
      "aplanar": true,
      "campos": "id,nombre",
      "max": 10,
      "inicio": 10,
      "exacto": true
    }
  ]
}
echo georefar_client.direcciones(consulta).pretty

consulta = %*{
  "ubicaciones": [
    {
      "lat": -32.8551545,
      "lon": -60.697636,
      "aplanar": true,
      "campos": "id,nombre"
    }
  ]
}
echo georefar_client.ubicacion(consulta).pretty

## Async client.
proc async_georefar() {.async.} =
  let
    async_georefar_client = AsyncGeoRefAr(timeout: 9)
    async_response = await async_georefar_client.ubicacion(consulta)
  echo $async_response

wait_for async_georefar()

# Ver la Doc para mas API Calls...
```


# API

- Todas las funciones retornan JSON, tipo `JsonNode`.
- Todas las funciones toman JSON, tipo `JsonNode`.
- Los nombres siguen los mismos nombres de la Documentacion.
- Los errores siguen los mismos errores de la Documentacion.
- Todas las API Calls son HTTP `POST`.
- El `timeout` es en Segundos.
- Para soporte de Proxy de red definir un `proxy` de tipo `Proxy`.
- No tiene codigo especifico a ningun Sistema Operativo, funciona en Linux, Windows, Mac, etc.


# FAQ

- Funciona sin SSL ?.

Si.

- Funciona con SSL ?.

Si.

- Funciona con codigo Asincrono ?.

Si.

- Funciona con codigo Sincrono ?.

Si.

- Requiere API Key ?.

No.

- Es Pago ?.

No.


# Requisites

- None.
