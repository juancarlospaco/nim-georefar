## GeoRefAr
## ========
##
## - API del `Servicio de Normalizacion de Datos Geograficos de Argentina. <https://georef-ar-api.readthedocs.io>`_ para `Nim. <https://nim-lang.org>`_
## .. raw:: html
##   <video src="argentina.mp4" muted autoplay loop width=300 height=400 ></video>
import asyncdispatch, httpclient, json

const georefar_api_url* =
  when defined(ssl): "https://apis.datos.gob.ar/georef/api/" ## Base API URL for all API calls (SSL).
  else: "http://apis.datos.gob.ar/georef/api/" ## Base API URL for all API calls (No SSL).

type
  GeoRefArBase*[HttpType] = object  ## Base Object
    proxy*: Proxy  ## Network IPv4 / IPv6 Proxy support, Proxy type.
    timeout*: byte  ## Timeout Seconds for API Calls, byte type, 0~255.
  GeoRefAr* = GeoRefArBase[HttpClient]           ## GeoRefAr API  Sync Client.
  AsyncGeoRefAr* = GeoRefArBase[AsyncHttpClient] ## GeoRefAr API Async Client.

proc apicall(this: GeoRefAr | AsyncGeoRefAr, api_url: string, cueri: JsonNode): Future[JsonNode] {.multisync.} =
  let response =
     when this is AsyncGeoRefAr:
       await newAsyncHttpClient(proxy = when declared(this.proxy): this.proxy else: nil).post(api_url, body = $cueri)
     else:
       newHttpClient(timeout=this.timeout.int * 1000, proxy = when declared(this.proxy): this.proxy else: nil ).post(api_url, body = $cueri)
  result = parseJson(await response.body)

proc provincias*(this: GeoRefAr | AsyncGeoRefAr, cueri: JsonNode): Future[JsonNode] {.multisync.} =
  ## Permite realizar varias busquedas sobre el listado de provincias en simultaneo.
  result = await this.apicall(georefar_api_url & "provincias", cueri)

proc departamentos*(this: GeoRefAr | AsyncGeoRefAr, cueri: JsonNode): Future[JsonNode] {.multisync.} =
  ## Permite realizar varias busquedas sobre el listado de departamentos en simultaneo.
  result = await this.apicall(georefar_api_url & "departamentos", cueri)

proc municipios*(this: GeoRefAr | AsyncGeoRefAr, cueri: JsonNode): Future[JsonNode] {.multisync.} =
  ## Permite realizar varias busquedas sobre el listado de municipios en simultaneo.
  result = await this.apicall(georefar_api_url & "municipios", cueri)

proc localidades*(this: GeoRefAr | AsyncGeoRefAr, cueri: JsonNode): Future[JsonNode] {.multisync.} =
  ## Permite realizar varias búsquedas sobre el listado de localidades en simultáneo.
  result = await this.apicall(georefar_api_url & "localidades", cueri)

proc calles*(this: GeoRefAr | AsyncGeoRefAr, cueri: JsonNode): Future[JsonNode] {.multisync.} =
  ## Permite realizar varias busquedas sobre el listado de vias de circulacion en simultaneo.
  result = await this.apicall(georefar_api_url & "calles", cueri)

proc direcciones*(this: GeoRefAr | AsyncGeoRefAr, cueri: JsonNode): Future[JsonNode] {.multisync.} =
  ## Permite normalizar un lote de direcciones utilizando el listado de vias de circulacion.
  result = await this.apicall(georefar_api_url & "direcciones", cueri)

proc ubicacion*(this: GeoRefAr | AsyncGeoRefAr, cueri: JsonNode): Future[JsonNode] {.multisync.} =
  ## Permite realizar una georreferenciacion inversa para varios puntos, informando cuales unidades territoriales contienen cada uno.
  result = await this.apicall(georefar_api_url & "ubicacion", cueri)




runnableExamples: # "nim doc georefar.nim" corre estos ejemplos y genera documentacion.
  import asyncdispatch, json
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
