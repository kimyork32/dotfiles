# GhostTrans

Un sistema de traducción cliente-servidor ligero y minimalista. Utiliza los modelos de IA de **Helsinki-NLP** de forma local en el backend (FastAPI) y cuenta con una interfaz flotante y discreta (PyQt6) que lee directamente desde tu portapapeles. 

Diseñado especialmente para integrarse sin problemas en Tiling Window Managers como **bspwm**.

## Características
* **100% IA Local:** No requiere claves de API ni suscripciones. El modelo de traducción se ejecuta íntegramente en tu máquina.
* **Interfaz Sigilosa:** Un popup sin bordes que aparece justo cuando lo necesitas y no estorba en tu flujo de trabajo.
* **Integración con el Portapapeles:** Captura y traduce automáticamente tu selección principal (texto resaltado) o el contenido de tu portapapeles al ejecutarse.

## Requisitos Previos (Arch Linux)
Si usas Arch Linux (específicamente en un entorno X11 como bspwm), asegúrate de tener instaladas las dependencias gráficas y de manejo del portapapeles:

```bash
sudo pacman -S xcb-util-cursor xclip
```

peso de dependencias necesarias: 1.4G

**USO**
activar entorno virtual de python
```bash
source .venv/bin/activate
```
Ejecutar el server.
inicialmente descargará el modelo Helsinki-NLP.
```bash
python server.py
```
Ejecutar el GUI

```bash
python ghost_trans.py
```
