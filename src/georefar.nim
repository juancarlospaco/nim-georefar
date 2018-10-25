## GeoRefAr
## ========
##
## - API del `Servicio de Normalizacion de Datos Geograficos de Argentina. <https://georef-ar-api.readthedocs.io>`_ para `Nim. <https://nim-lang.org>`_
## .. raw:: html
##   <video src="argentina.mp4" muted autoplay loop width=300 height=400 ></video>
import asyncdispatch, httpclient, json

const
  georefar_api_url* =
    when defined(ssl): "https://apis.datos.gob.ar/georef/api/" ## Base API URL for all API calls (SSL).
    else: "http://apis.datos.gob.ar/georef/api/" ## Base API URL for all API calls (No SSL).
  header_api_data = {"dnt": "1", "accept": "application/vnd.api+json", "content-type": "application/vnd.api+json"}
let json_api_headers = newHttpHeaders(header_api_data) ## HTTP Headers for JSON APIs.

type
  GeoRefArBase*[HttpType] = object  ## Base Object
    proxy*: Proxy  ## Network IPv4 / IPv6 Proxy support, Proxy type.
    timeout*: byte  ## Timeout Seconds for API Calls, byte type, 0~255.
  GeoRefAr* = GeoRefArBase[HttpClient]           ## GeoRefAr API  Sync Client.
  AsyncGeoRefAr* = GeoRefArBase[AsyncHttpClient] ## GeoRefAr API Async Client.

template proxi(this: untyped): untyped =
  ## Template to use Proxy when its declared.
  when declared(this.proxy): this.proxy else: nil

proc apicall(this: GeoRefAr | AsyncGeoRefAr, api_url: string, cueri: JsonNode): Future[JsonNode] {.multisync.} =
  let client =
    when this is AsyncGeoRefAr: newAsyncHttpClient(proxy=proxi(this))
    else: newHttpClient(timeout=this.timeout.int * 1000, proxy=proxi(this))
  client.headers = json_api_headers
  let response =
    when this is AsyncGeoRefAr: await client.post(api_url, body = $cueri)
    else: client.post(api_url, body = $cueri)
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
