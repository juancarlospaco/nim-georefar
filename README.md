# Nim-GeoRefAr

[GeoRef Argentina](https://georef-ar-api.readthedocs.io) MultiSync API Lib for [Nim](https://nim-lang.org)
*(All Docs on Spanish because its for Argentina)*

La API del Servicio de Normalizacion de Datos Geograficos, permite normalizar y
codificar los nombres de unidades territoriales de la Argentina
(provincias, departamentos, municipios y localidades) y de sus calles,
asi como ubicar coordenadas dentro de ellas.

Este Cliente es Async y Sync al mismo tiempo, es MultiPlataforma, MultiArquitectura,
0 Dependencias, 1 Archivo solo, ~250 Kilobytes Compilado, muy poco uso de RAM.
Soporta Proxy, IPv6, SSL y Timeout. Auto-Documentado.


# Instalar

```
nimble install georefar
```


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

<details>
  <summary>Click aca para ver lo que devuelve el codigo</summary>

```json
{
  "resultados": [
    {
      "cantidad": 1,
      "inicio": 0,
      "provincias": [
        {
          "centroide": {
            "lat": -30.706927,
            "lon": -60.949837
          },
          "id": "82",
          "nombre": "Santa Fe"
        }
      ],
      "total": 1
    }
  ]
}
{
  "resultados": [
    {
      "cantidad": 10,
      "departamentos": [
        {
          "centroide": {
            "lat": -33.485583,
            "lon": -60.851384
          },
          "id": "82028",
          "nombre": "Villa Constitución",
          "provincia": {
            "id": "82",
            "nombre": "Santa Fe"
          }
        },
        {
          "centroide": {
            "lat": -31.475356,
            "lon": -60.669479
          },
          "id": "82063",
          "nombre": "La Capital",
          "provincia": {
            "id": "82",
            "nombre": "Santa Fe"
          }
        },
        {
          "centroide": {
            "lat": -30.228319,
            "lon": -61.360015
          },
          "id": "82091",
          "nombre": "San Cristóbal",
          "provincia": {
            "id": "82",
            "nombre": "Santa Fe"
          }
        },
        {
          "centroide": {
            "lat": -32.153771,
            "lon": -61.048127
          },
          "id": "82105",
          "nombre": "San Jerónimo",
          "provincia": {
            "id": "82",
            "nombre": "Santa Fe"
          }
        },
        {
          "centroide": {
            "lat": -32.942315,
            "lon": -60.961501
          },
          "id": "82119",
          "nombre": "San Lorenzo",
          "provincia": {
            "id": "82",
            "nombre": "Santa Fe"
          }
        },
        {
          "centroide": {
            "lat": -31.054641,
            "lon": -60.125808
          },
          "id": "82035",
          "nombre": "Garay",
          "provincia": {
            "id": "82",
            "nombre": "Santa Fe"
          }
        },
        {
          "centroide": {
            "lat": -28.67197,
            "lon": -59.526652
          },
          "id": "82049",
          "nombre": "General Obligado",
          "provincia": {
            "id": "82",
            "nombre": "Santa Fe"
          }
        },
        {
          "centroide": {
            "lat": -32.706084,
            "lon": -61.273388
          },
          "id": "82056",
          "nombre": "Iriondo",
          "provincia": {
            "id": "82",
            "nombre": "Santa Fe"
          }
        },
        {
          "centroide": {
            "lat": -33.127856,
            "lon": -60.710842
          },
          "id": "82084",
          "nombre": "Rosario",
          "provincia": {
            "id": "82",
            "nombre": "Santa Fe"
          }
        },
        {
          "centroide": {
            "lat": -33.221497,
            "lon": -61.531016
          },
          "id": "82014",
          "nombre": "Caseros",
          "provincia": {
            "id": "82",
            "nombre": "Santa Fe"
          }
        }
      ],
      "inicio": 0,
      "total": 19
    }
  ]
}
{
  "resultados": [
    {
      "cantidad": 10,
      "inicio": 0,
      "municipios": [
        {
          "centroide": {
            "lat": -33.541937,
            "lon": -61.963807
          },
          "id": "822658",
          "nombre": "La Chispa",
          "provincia": {
            "id": "82",
            "nombre": "Santa Fe"
          }
        },
        {
          "centroide": {
            "lat": -33.718744,
            "lon": -61.293182
          },
          "id": "822665",
          "nombre": "Labordeboy",
          "provincia": {
            "id": "82",
            "nombre": "Santa Fe"
          }
        },
        {
          "centroide": {
            "lat": -30.597043,
            "lon": -60.26593
          },
          "id": "823694",
          "nombre": "Cacique Ariacaiquín",
          "provincia": {
            "id": "82",
            "nombre": "Santa Fe"
          }
        },
        {
          "centroide": {
            "lat": -34.039567,
            "lon": -61.912867
          },
          "id": "822686",
          "nombre": "María Teresa",
          "provincia": {
            "id": "82",
            "nombre": "Santa Fe"
          }
        },
        {
          "centroide": {
            "lat": -30.402616,
            "lon": -60.177144
          },
          "id": "823708",
          "nombre": "La Brava",
          "provincia": {
            "id": "82",
            "nombre": "Santa Fe"
          }
        },
        {
          "centroide": {
            "lat": -31.548994,
            "lon": -61.960371
          },
          "id": "822406",
          "nombre": "Zenón Pereyra",
          "provincia": {
            "id": "82",
            "nombre": "Santa Fe"
          }
        },
        {
          "centroide": {
            "lat": -32.925768,
            "lon": -60.826161
          },
          "id": "820189",
          "nombre": "Funes",
          "provincia": {
            "id": "82",
            "nombre": "Santa Fe"
          }
        },
        {
          "centroide": {
            "lat": -33.340932,
            "lon": -60.868743
          },
          "id": "822497",
          "nombre": "Pavón Arriba",
          "provincia": {
            "id": "82",
            "nombre": "Santa Fe"
          }
        },
        {
          "centroide": {
            "lat": -33.866831,
            "lon": -61.251409
          },
          "id": "822756",
          "nombre": "Wheelwright",
          "provincia": {
            "id": "82",
            "nombre": "Santa Fe"
          }
        },
        {
          "centroide": {
            "lat": -30.861005,
            "lon": -61.840493
          },
          "id": "822154",
          "nombre": "Colonia Bicha",
          "provincia": {
            "id": "82",
            "nombre": "Santa Fe"
          }
        }
      ],
      "total": 362
    }
  ]
}
{
  "resultados": [
    {
      "cantidad": 1,
      "inicio": 0,
      "localidades": [
        {
          "centroide": {
            "lat": -32.861364,
            "lon": -60.706216
          },
          "departamento": {
            "id": "82084",
            "nombre": "Rosario"
          },
          "id": "82084160000",
          "municipio": {
            "id": "820196",
            "nombre": "Granadero Baigorria"
          },
          "nombre": "GRANADERO BAIGORRIA",
          "provincia": {
            "id": "82",
            "nombre": "Santa Fe"
          },
          "tipo": "Componente de localidad compuesta (LC)"
        }
      ],
      "total": 1
    }
  ]
}
{
  "resultados": [
    {
      "calles": [
        {
          "altura": {
            "fin": {
              "derecha": 998,
              "izquierda": 999
            },
            "inicio": {
              "derecha": 800,
              "izquierda": 801
            }
          },
          "departamento": {
            "id": "82084",
            "nombre": "Rosario"
          },
          "id": "8208421000125",
          "nombre": "AVELLANEDA",
          "nomenclatura": "AVELLANEDA, Rosario, Santa Fe",
          "provincia": {
            "id": "82",
            "nombre": "Santa Fe"
          },
          "tipo": "CALLE"
        },
        {
          "altura": {
            "fin": {
              "derecha": 2598,
              "izquierda": 2599
            },
            "inicio": {
              "derecha": 2100,
              "izquierda": 2101
            }
          },
          "departamento": {
            "id": "82084",
            "nombre": "Rosario"
          },
          "id": "8208414002685",
          "nombre": "URUNDAY",
          "nomenclatura": "URUNDAY, Rosario, Santa Fe",
          "provincia": {
            "id": "82",
            "nombre": "Santa Fe"
          },
          "tipo": "CALLE"
        },
        {
          "altura": {
            "fin": {
              "derecha": 2198,
              "izquierda": 2199
            },
            "inicio": {
              "derecha": 2100,
              "izquierda": 2101
            }
          },
          "departamento": {
            "id": "82084",
            "nombre": "Rosario"
          },
          "id": "8208414001945",
          "nombre": "LAPACHO",
          "nomenclatura": "LAPACHO, Rosario, Santa Fe",
          "provincia": {
            "id": "82",
            "nombre": "Santa Fe"
          },
          "tipo": "CALLE"
        },
        {
          "altura": {
            "fin": {
              "derecha": 3898,
              "izquierda": 3899
            },
            "inicio": {
              "derecha": 3700,
              "izquierda": 3701
            }
          },
          "departamento": {
            "id": "82084",
            "nombre": "Rosario"
          },
          "id": "8208427007775",
          "nombre": "PJE 2139",
          "nomenclatura": "PJE 2139, Rosario, Santa Fe",
          "provincia": {
            "id": "82",
            "nombre": "Santa Fe"
          },
          "tipo": "CALLE"
        },
        {
          "altura": {
            "fin": {
              "derecha": 6398,
              "izquierda": 2499
            },
            "inicio": {
              "derecha": 0,
              "izquierda": 0
            }
          },
          "departamento": {
            "id": "82084",
            "nombre": "Rosario"
          },
          "id": "8208414000160",
          "nombre": "AV FUERZA AEREA",
          "nomenclatura": "AV FUERZA AEREA, Rosario, Santa Fe",
          "provincia": {
            "id": "82",
            "nombre": "Santa Fe"
          },
          "tipo": "AV"
        },
        {
          "altura": {
            "fin": {
              "derecha": 6498,
              "izquierda": 6499
            },
            "inicio": {
              "derecha": 2200,
              "izquierda": 2201
            }
          },
          "departamento": {
            "id": "82084",
            "nombre": "Rosario"
          },
          "id": "8208414001900",
          "nombre": "JOSE INGENIEROS",
          "nomenclatura": "JOSE INGENIEROS, Rosario, Santa Fe",
          "provincia": {
            "id": "82",
            "nombre": "Santa Fe"
          },
          "tipo": "CALLE"
        },
        {
          "altura": {
            "fin": {
              "derecha": 2598,
              "izquierda": 2599
            },
            "inicio": {
              "derecha": 2300,
              "izquierda": 2301
            }
          },
          "departamento": {
            "id": "82084",
            "nombre": "Rosario"
          },
          "id": "8208414002635",
          "nombre": "TANDIL",
          "nomenclatura": "TANDIL, Rosario, Santa Fe",
          "provincia": {
            "id": "82",
            "nombre": "Santa Fe"
          },
          "tipo": "CALLE"
        },
        {
          "altura": {
            "fin": {
              "derecha": 6498,
              "izquierda": 6499
            },
            "inicio": {
              "derecha": 0,
              "izquierda": 0
            }
          },
          "departamento": {
            "id": "82084",
            "nombre": "Rosario"
          },
          "id": "8208414000010",
          "nombre": "ACAPULCO",
          "nomenclatura": "ACAPULCO, Rosario, Santa Fe",
          "provincia": {
            "id": "82",
            "nombre": "Santa Fe"
          },
          "tipo": "CALLE"
        },
        {
          "altura": {
            "fin": {
              "derecha": 6498,
              "izquierda": 6499
            },
            "inicio": {
              "derecha": 0,
              "izquierda": 0
            }
          },
          "departamento": {
            "id": "82084",
            "nombre": "Rosario"
          },
          "id": "8208414000130",
          "nombre": "AV CORDOBA - COLECTORA",
          "nomenclatura": "AV CORDOBA - COLECTORA, Rosario, Santa Fe",
          "provincia": {
            "id": "82",
            "nombre": "Santa Fe"
          },
          "tipo": "AV"
        },
        {
          "altura": {
            "fin": {
              "derecha": 6398,
              "izquierda": 6399
            },
            "inicio": {
              "derecha": 5700,
              "izquierda": 5701
            }
          },
          "departamento": {
            "id": "82084",
            "nombre": "Rosario"
          },
          "id": "8208414002715",
          "nombre": "VINA DEL MAR",
          "nomenclatura": "VINA DEL MAR, Rosario, Santa Fe",
          "provincia": {
            "id": "82",
            "nombre": "Santa Fe"
          },
          "tipo": "CALLE"
        }
      ],
      "cantidad": 10,
      "inicio": 0,
      "total": 4157
    }
  ]
}
{
  "resultados": [
    {
      "cantidad": 5,
      "direcciones": [
        {
          "altura": 400,
          "departamento": {
            "id": "82084",
            "nombre": "Rosario"
          },
          "id": "8208427013005",
          "nombre": "URQUIZA",
          "nomenclatura": "URQUIZA 400, Rosario, Santa Fe",
          "provincia": {
            "id": "82",
            "nombre": "Santa Fe"
          },
          "tipo": "CALLE",
          "ubicacion": {
            "lat": null,
            "lon": null
          }
        },
        {
          "altura": 400,
          "departamento": {
            "id": "82084",
            "nombre": "Rosario"
          },
          "id": "8208407000705",
          "nombre": "URQUIZA",
          "nomenclatura": "URQUIZA 400, Rosario, Santa Fe",
          "provincia": {
            "id": "82",
            "nombre": "Santa Fe"
          },
          "tipo": "CALLE",
          "ubicacion": {
            "lat": null,
            "lon": null
          }
        },
        {
          "altura": 400,
          "departamento": {
            "id": "82084",
            "nombre": "Rosario"
          },
          "id": "8208414002670",
          "nombre": "URQUIZA",
          "nomenclatura": "URQUIZA 400, Rosario, Santa Fe",
          "provincia": {
            "id": "82",
            "nombre": "Santa Fe"
          },
          "tipo": "CALLE",
          "ubicacion": {
            "lat": null,
            "lon": null
          }
        },
        {
          "altura": 400,
          "departamento": {
            "id": "82084",
            "nombre": "Rosario"
          },
          "id": "8208414002675",
          "nombre": "URQUIZA",
          "nomenclatura": "URQUIZA 400, Rosario, Santa Fe",
          "provincia": {
            "id": "82",
            "nombre": "Santa Fe"
          },
          "tipo": "CALLE",
          "ubicacion": {
            "lat": -32.9247697193499,
            "lon": -60.7711169887185
          }
        },
        {
          "altura": 400,
          "departamento": {
            "id": "82084",
            "nombre": "Rosario"
          },
          "id": "8208416001280",
          "nombre": "URQUIZA",
          "nomenclatura": "URQUIZA 400, Rosario, Santa Fe",
          "provincia": {
            "id": "82",
            "nombre": "Santa Fe"
          },
          "tipo": "CALLE",
          "ubicacion": {
            "lat": -32.85515451234649,
            "lon": -60.69763668291105
          }
        }
      ],
      "inicio": 0,
      "total": 5
    }
  ]
}
{
  "resultados": [
    {
      "ubicacion": {
        "departamento": {
          "id": "82084",
          "nombre": "Rosario"
        },
        "lat": -32.8551545,
        "lon": -60.697636,
        "municipio": {
          "id": "820196",
          "nombre": "Granadero Baigorria"
        },
        "provincia": {
          "id": "82",
          "nombre": "Santa Fe"
        }
      }
    }
  ]
}
{
  "resultados": [
    {
      "ubicacion": {
        "departamento": {
          "id": "82084",
          "nombre": "Rosario"
        },
        "lat": -32.8551545,
        "lon": -60.697636,
        "municipio": {
          "id": "820196",
          "nombre": "Granadero Baigorria"
        },
        "provincia": {
          "id": "82",
          "nombre": "Santa Fe"
        }
      }
    }
  ]
}
```

</details>


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
