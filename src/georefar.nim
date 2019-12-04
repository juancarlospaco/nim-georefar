## GeoRefAr
## ========
##
## - API del `Servicio de Normalizacion de Datos Geograficos de Argentina. <https://georef-ar-api.readthedocs.io>`_ para `Nim. <https://nim-lang.org>`_
## .. raw:: html
##   <video src="argentina.mp4" muted autoplay loop width=300 height=400 ></video>
import asyncdispatch, httpclient, json

const
  georefarApiUrl* =
    when defined(ssl): "https://apis.datos.gob.ar/georef/api/"                   ## Base API URL for all API calls (SSL).
    else: "http://apis.datos.gob.ar/georef/api/"                                 ## Base API URL for all API calls (No SSL).
  georefarProvinciasDataset* =
    when defined(ssl): "https://apis.datos.gob.ar/georef/api/provincias.json"    ## Dataset de Provincias (SSL).
    else: "http://apis.datos.gob.ar/georef/api/provincias.json"                  ## Dataset de Provincias (No SSL).
  georefarDepartamentosDataset* =
    when defined(ssl): "https://apis.datos.gob.ar/georef/api/departamentos.json" ## Dataset de Departamentos (SSL).
    else: "http://apis.datos.gob.ar/georef/api/departamentos.json"               ## Dataset de Departamentos (No SSL).
  georefarMunicipiosDataset* =
    when defined(ssl): "https://apis.datos.gob.ar/georef/api/municipios.json"    ## Dataset de Municipios (SSL).
    else: "http://apis.datos.gob.ar/georef/api/municipios.json"                  ## Dataset de Municipios (No SSL).
  georefarLocalidadesDataset* =
    when defined(ssl): "https://apis.datos.gob.ar/georef/api/localidades.json"   ## Dataset de Localidades (SSL).
    else: "http://apis.datos.gob.ar/georef/api/localidades.json"                 ## Dataset de Localidades (No SSL).
  georefarCallesDataset* =
    when defined(ssl): "https://apis.datos.gob.ar/georef/api/calles.json"        ## Dataset de Calles (SSL).
    else: "http://apis.datos.gob.ar/georef/api/calles.json"                      ## Dataset de Calles (No SSL).
  headerApiData = {"dnt": "1", "accept": "application/vnd.api+json", "content-type": "application/vnd.api+json"}
let jsonApiHeaders = newHttpHeaders(headerApiData) ## HTTP Headers for JSON APIs.

type
  GeoRefArBase*[HttpType] = object ## Base Object
    proxy*: Proxy                  ## Network IPv4 / IPv6 Proxy support, Proxy type.
    timeout*: byte                 ## Timeout Seconds for API Calls, byte type, 0~255.
  GeoRefAr* = GeoRefArBase[HttpClient] ## GeoRefAr API  Sync Client.
  AsyncGeoRefAr* = GeoRefArBase[AsyncHttpClient] ## GeoRefAr API Async Client.

template clientify(this: GeoRefAr | AsyncGeoRefAr): untyped =
  ## Build & inject basic HTTP Client with Proxy and Timeout.
  var client {.inject.} =
    when this is AsyncGeoRefAr: newAsyncHttpClient(proxy = when declared(this.proxy): this.proxy else: nil, userAgent = "")
    else: newHttpClient(
      timeout = when declared(this.timeout): this.timeout.int * 1_000 else: -1,
      proxy = when declared(this.proxy): this.proxy else: nil, userAgent = "")
  client.headers = jsonApiHeaders

proc apicall(this: GeoRefAr | AsyncGeoRefAr, api_url: string, cueri: JsonNode): Future[JsonNode] {.multisync.} =
  clientify(this)
  let response =
    when this is AsyncGeoRefAr: await client.post(api_url, body = $cueri)
    else: client.post(api_url, body = $cueri)
  result = parseJson(await response.body)

proc provincias*(this: GeoRefAr | AsyncGeoRefAr, cueri: JsonNode): Future[JsonNode] {.multisync.} =
  ## Permite realizar varias busquedas sobre el listado de provincias en simultaneo.
  result = await this.apicall(georefarApiUrl & "provincias", cueri)

proc departamentos*(this: GeoRefAr | AsyncGeoRefAr, cueri: JsonNode): Future[JsonNode] {.multisync.} =
  ## Permite realizar varias busquedas sobre el listado de departamentos en simultaneo.
  result = await this.apicall(georefarApiUrl & "departamentos", cueri)

proc municipios*(this: GeoRefAr | AsyncGeoRefAr, cueri: JsonNode): Future[JsonNode] {.multisync.} =
  ## Permite realizar varias busquedas sobre el listado de municipios en simultaneo.
  result = await this.apicall(georefarApiUrl & "municipios", cueri)

proc localidadesCensales*(this: GeoRefAr | AsyncGeoRefAr, cueri: JsonNode): Future[JsonNode] {.multisync.} =
  ## Permite realizar varias busquedas sobre el listado de localidades censales en simultaneo.
  result = await this.apicall(georefarApiUrl & "localidades-censales", cueri)

proc asentamientos*(this: GeoRefAr | AsyncGeoRefAr, cueri: JsonNode): Future[JsonNode] {.multisync.} =
  ## Permite realizar busquedas sobre el listado de asentamientos BAHRA.
  result = await this.apicall(georefarApiUrl & "asentamientos", cueri)

proc localidades*(this: GeoRefAr | AsyncGeoRefAr, cueri: JsonNode): Future[JsonNode] {.multisync.} =
  ## Permite realizar varias busquedas sobre el listado de localidades en simultáneo.
  result = await this.apicall(georefarApiUrl & "localidades", cueri)

proc calles*(this: GeoRefAr | AsyncGeoRefAr, cueri: JsonNode): Future[JsonNode] {.multisync.} =
  ## Permite realizar varias busquedas sobre el listado de vias de circulacion en simultaneo.
  result = await this.apicall(georefarApiUrl & "calles", cueri)

proc direcciones*(this: GeoRefAr | AsyncGeoRefAr, cueri: JsonNode): Future[JsonNode] {.multisync.} =
  ## Permite normalizar un lote de direcciones utilizando el listado de vias de circulacion.
  result = await this.apicall(georefarApiUrl & "direcciones", cueri)

proc ubicacion*(this: GeoRefAr | AsyncGeoRefAr, cueri: JsonNode): Future[JsonNode] {.multisync.} =
  ## Permite realizar una georreferenciacion inversa para varios puntos, informando cuales unidades territoriales contienen cada uno.
  result = await this.apicall(georefarApiUrl & "ubicacion", cueri)

proc provinciasDataset*(this: GeoRefAr | AsyncGeoRefAr, filename: string) {.discardable, multisync.} =
  ## Permite descargar el listado completo desde la API.
  clientify(this)
  when this is AsyncGeoRefAr: await client.downloadFile(georefarProvinciasDataset, filename)
  else: client.downloadFile(georefarProvinciasDataset, filename)

proc departamentosDataset*(this: GeoRefAr | AsyncGeoRefAr, filename: string) {.discardable, multisync.} =
  ## Permite descargar el listado completo desde la API.
  clientify(this)
  when this is AsyncGeoRefAr: await client.downloadFile(georefarDepartamentosDataset, filename)
  else: client.downloadFile(georefarDepartamentosDataset, filename)

proc municipiosDataset*(this: GeoRefAr | AsyncGeoRefAr, filename: string) {.discardable, multisync.} =
  ## Permite descargar el listado completo desde la API.
  clientify(this)
  when this is AsyncGeoRefAr: await client.downloadFile(georefarMunicipiosDataset, filename)
  else: client.downloadFile(georefarMunicipiosDataset, filename)

proc localidadesDataset*(this: GeoRefAr | AsyncGeoRefAr, filename: string) {.discardable, multisync.} =
  ## Permite descargar el listado completo desde la API.
  clientify(this)
  when this is AsyncGeoRefAr: await client.downloadFile(georefarLocalidadesDataset, filename)
  else: client.downloadFile(georefarLocalidadesDataset, filename)

proc callesDataset*(this: GeoRefAr | AsyncGeoRefAr, filename: string) {.discardable, multisync.} =
  ## Permite descargar el listado completo desde la API.
  clientify(this)
  when this is AsyncGeoRefAr: await client.downloadFile(georefarCallesDataset, filename)
  else: client.downloadFile(georefarCallesDataset, filename)




# De aca para abajo ya es codigo opcional, es solo para ejemplos, doc, etc.
runnableExamples: # "nim doc georefar.nim" corre estos ejemplos y genera documentacion.
  import asyncdispatch, json
  ## Sync client.
  let georefar_client = GeoRefAr(timeout: 99) # Timeout en Segundos.
  ## Las consultas en formato JSON son copiadas desde la Documentacion de la API.
  var consulta = %* {"provincias": [{"id": "82"}]}
  echo georefar_client.provincias(consulta).pretty

  consulta = %* {"departamentos": [{"provincia": "Santa Fe"}]}
  echo georefar_client.departamentos(consulta).pretty

  consulta = %* {"municipios": [{"provincia": "Santa Fe"}]}
  echo georefar_client.municipios(consulta).pretty

  consulta = %* {"localidades": [{"provincia": "Santa Fe", "departamento": "Rosario", "municipio": "Granadero Baigorria"}]}
  echo georefar_client.localidades(consulta).pretty

  consulta = %* {"calles": [{"provincia": "Santa Fe", "departamento": "Rosario"}]}
  echo georefar_client.calles(consulta).pretty

  consulta = %* {"direcciones": [{"direccion": "Urquiza 400", "tipo": "calle", "provincia": "Santa Fe", "departamento": "Rosario"}]}
  echo georefar_client.direcciones(consulta).pretty

  consulta = %* {"ubicaciones": [{"lat": -32.8551545, "lon": -60.697636}]}
  echo georefar_client.ubicacion(consulta).pretty
  # Whole Dataset Downloads (takes a lot of time to complete!).
  # georefar_client.provincias_dataset("provincias.json")
  # georefar_client.departamentos_dataset("departamentos.json")
  # georefar_client.municipios_dataset("municipios.json")
  # georefar_client.localidades_dataset("localidades.json")
  # georefar_client.calles_dataset("calles.json")

  ## Async client.
  proc async_georefar() {.async.} = echo pretty(await AsyncGeoRefAr(timeout: 9).ubicacion(consulta))
  wait_for async_georefar()




when isMainModule and defined(release):
  {.passL: "-s", passC: "-flto -ffast-math", optimization: size.}
  import parseopt, terminal, random
  const helpy = """
  GeoRef Argentina MultiSync API Client App.

  La API del Servicio de Normalizacion de Datos Geograficos,
  permite normalizar y codificar los nombres de unidades territoriales de Argentina
  (provincias, departamentos, municipios y localidades) y de sus calles,
  asi como ubicar coordenadas dentro de ellas.
  Para mas informacion y ayuda ver la Documentacion.

  👑 https://github.com/juancarlospaco/nim-georefar#nim-georefar 👑

  Uso (Spanish):
  ./georefar --color --provincias '{"provincias": [{"id": "82"}]}'
  """
  var endpoint: string
  for tipoDeClave, clave, valor in getopt():
    case tipoDeClave
    of cmdShortOption, cmdLongOption:
      case clave
      of "version": quit("0.1.8", 0)
      of "license", "licencia": quit("MIT", 0)
      of "help", "ayuda": quit(helpy, 0)
      of "provincias", "departamentos", "municipios", "localidades", "calles", "direcciones", "ubicacion":
        endpoint = clave
      of "color":
        randomize()
        setBackgroundColor(bgBlack)
        setForegroundColor([fgRed, fgGreen, fgYellow, fgBlue, fgMagenta, fgCyan, fgWhite].rand)
    of cmdArgument:
      let clientito = GeoRefAr(timeout: 99)
      case endpoint
      of "provincias": echo clientito.provincias(parse_json(clave)).pretty
      of "departamentos": echo clientito.departamentos(parse_json(clave)).pretty
      of "municipios": echo clientito.municipios(parse_json(clave)).pretty
      of "localidades": echo clientito.localidades(parse_json(clave)).pretty
      of "calles": echo clientito.calles(parse_json(clave)).pretty
      of "direcciones": echo clientito.direcciones(parse_json(clave)).pretty
      of "ubicacion": echo clientito.ubicacion(parse_json(clave)).pretty
      else: quit("""Parametro a buscar debe ser alguno de los endpoint de la API:
      provincias,departamentos,municipios,localidades,calles,direcciones,ubicacion""", 1)
    of cmdEnd: quit("Los Parametros son incorrectos, ver Ayuda con --ayuda", 1)
