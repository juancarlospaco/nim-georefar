# Nim-GeoRefAr

[GeoRef Argentina](https://georef-ar-api.readthedocs.io) MultiSync API Lib for [Nim](https://nim-lang.org)
*(All Docs on Spanish because its for Argentina)*

La API del Servicio de Normalizacion de Datos Geograficos, permite normalizar y
codificar los nombres de unidades territoriales de la Argentina
(provincias, departamentos, municipios y localidades) y de sus calles,
así como ubicar coordenadas dentro de ellas.


# Uso

```nim
import georefar, json

## Sync client.
let georefar_client = GeoRefAr(timeout: 9)  # Timeout en Segundos.
## Las consultas en formato JSON son copiadas desde la Documentacion de la API.
var consulta = %* {
  "provincias": [
    {
      "id": "82"
    }
  ]
}
echo georefar_client.provincias(consulta).pretty

consulta = %* {
  "departamentos": [
    {
      "provincia": "Santa Fe"
    }
  ]
}
echo georefar_client.departamentos(consulta).pretty

consulta = %* {
  "municipios": [
    {
      "provincia": "Santa Fe"
    }
  ]
}
echo georefar_client.municipios(consulta).pretty

consulta = %* {
  "localidades": [
    {
      "provincia": "Santa Fe",
      "departamento": "Rosario",
      "municipio": "Granadero Baigorria"
    }
  ]
}
echo georefar_client.localidades(consulta).pretty

consulta = %* {
  "calles": [
    {
      "provincia": "Santa Fe",
      "departamento": "Rosario"
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
      "departamento": "Rosario"
    }
  ]
}
echo georefar_client.direcciones(consulta).pretty

consulta = %* {
  "ubicaciones": [
    {
      "lat": -32.8551545,
      "lon": -60.697636
    }
  ]
}
echo georefar_client.ubicacion(consulta).pretty

## Async client.
proc async_georefar() {.async.} =
  let
    async_georefar_client = AsyncGeoRefAr(timeout: 9)
    async_response = await async_georefar_client.ubicacion(consulta)
  echo async_response.pretty

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
