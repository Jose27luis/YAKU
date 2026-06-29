# Desierto de Oro — Documento de diseño del juego
**Juego de aventura retro estilo Zelda | Conciencia ambiental sobre la minería en Madre de Dios**

---

## Concepto general

**Nombre del juego:** Desierto de Oro

**Género:** Aventura de acción top-down estilo Zelda clásico (SNES)

**Plataforma objetivo:** Web (HTML5 / JavaScript), posible exportación móvil

**Propósito:** Difundir el impacto de la minería ilegal en la región Madre de Dios, Perú, a través de una experiencia interactiva que mezcla exploración, acertijos y narrativa ambiental.

**Tagline:** *"Lo que el oro se llevó, tú puedes devolver."*

---

## Historia

La región Madre de Dios fue alguna vez el pulmón verde del mundo: ríos cristalinos, bosques infinitos, comunidades indígenas en armonía con la naturaleza. Hoy, grandes zonas han sido convertidas en desiertos de arena y mercurio por la minería ilegal de oro.

El jugador elige a su héroe — hombre o mujer — y le da un nombre. Ese héroe es un joven de la región que regresa a su pueblo natal después de años fuera, y encuentra una tierra devastada. Guiado por el espíritu de la selva (una anaconda ancestral llamada **Yaku**), el héroe recorre el mapa completo de Madre de Dios: desde las zonas destruidas hasta los últimos refugios naturales, enfrentando desafíos para restaurar el equilibrio.

**Misión final:** Llegar al corazón del bosque, desactivar la operación minera central y convocar a las comunidades para una solución colectiva.

---

## Personaje principal

### Creación del héroe

Al iniciar el juego, el jugador ve una pantalla de creación de personaje:

- **Nombre:** campo de texto libre (el nombre aparecerá en diálogos y en la HUD)
- **Género:** elige entre héroe masculino o héroe femenino (sprite diferente, mismas habilidades)
- **Origen:** el personaje siempre es de Madre de Dios — esto es parte de la narrativa

### Atributos del personaje

| Atributo | Descripción |
|---|---|
| Vida | Representada con hojas de árbol (no corazones genéricos) — se pierden al recibir daño |
| Conocimiento | Sube al recoger testimonios, documentos y hablar con comuneros |
| Vínculo natural | Energía especial que permite usar habilidades ancestrales |

### Habilidades

- **Analizar:** examinar zonas contaminadas para obtener información real sobre el daño ambiental
- **Convocar a Yaku:** invocar al espíritu serpiente para cruzar ríos contaminados o revelar caminos ocultos
- **Sembrar:** plantar semillas en zonas recuperadas para restaurarlas visualmente en el mapa
- **Documentar:** tomar "evidencia" fotográfica de daños (mecánica de acertijo) para desbloquear rutas

---

## Mapa del mundo

El mapa es una representación estilizada de la región Madre de Dios, dividida en zonas con distintos estados de degradación ambiental. El jugador lo explora de forma no lineal pero con ciertas zonas bloqueadas hasta completar misiones clave.

### Zonas del mapa

#### 1. Puerto Maldonado — La Ciudad Gris
- **Estado:** ciudad con tensión entre progreso y naturaleza
- **Descripción visual:** mezcla de edificios, calles polvorientas y algo de vegetación resistente
- **Función en el juego:** zona de inicio, tutoriales, primer contacto con aliados y la problemática
- **PNJ clave:** Doña Esperanza, una anciana shipibo que explica la historia de la región

#### 2. La Pampa — El Gran Desierto
- **Estado:** devastación total (zona más oscura y perturbadora del mapa)
- **Descripción visual:** tierra removida, pozas de agua contaminada con mercurio, maquinaria abandonada, sin vegetación
- **Función en el juego:** zona central del conflicto, misión principal de denuncia
- **Desafío:** infiltrarse para documentar la operación sin ser detectado por guardias de la minera
- **Dato real mostrado al jugador:** "La Pampa destruyó más de 10,000 hectáreas de bosque amazónico"

#### 3. Río Madre de Dios — Las Aguas Envenenadas
- **Estado:** degradado pero parcialmente vivo
- **Descripción visual:** río de color amarillento, dragas flotantes, orillas sin vegetación
- **Función en el juego:** zona de navegación y acertijos de purificación del agua
- **Desafío:** navegar el río evitando dragas y zonas de mercurio, encontrar nacientes limpias
- **Dato real:** "El mercurio de la minería contamina el río y envenena a comunidades aguas abajo"

#### 4. Reserva Comunal Amarakaeri — El Último Bosque
- **Estado:** protegido pero amenazado
- **Descripción visual:** bosque denso y vibrante, comunidad indígena Harakmbut, animales nativos
- **Función en el juego:** zona de recuperación, alianzas con comunidades indígenas, habilidades ancestrales
- **Desafío:** ayudar a la comunidad a establecer límites y alertar sobre avances de la minería
- **PNJ clave:** Tato, joven Harakmbut guardián del territorio

#### 5. Parque Nacional del Manu — El Corazón Verde
- **Estado:** pristino, destino final
- **Descripción visual:** biodiversidad máxima, colores vibrantes, animales emblemáticos (guacamayos, nutrias gigantes, tapires)
- **Función en el juego:** zona final, enfrentamiento con el "jefe" (el operador de la minera), resolución
- **Desafío final:** convocar a todos los aliados reunidos durante el juego para bloquear la expansión minera

#### 6. Comunidad Nativa Tres Islas — La Resistencia
- **Estado:** en lucha
- **Descripción visual:** comunidad ribereña, botes, rostros determinados
- **Función en el juego:** zona secundaria de misiones de organización comunitaria
- **Desafío:** coordinar con líderes comunales para presentar una denuncia formal (mecánica de rompecabezas legal)

---

## Sistema de misiones

El juego usa misiones (no niveles). Las misiones se organizan en tres categorías:

### Misiones principales (hilo narrativo)
Deben completarse para avanzar la historia.

| # | Misión | Zona | Objetivo |
|---|---|---|---|
| 1 | El regreso | Puerto Maldonado | Tutorial: conocer la ciudad, hablar con Doña Esperanza |
| 2 | Ver para creer | La Pampa | Documentar la devastación sin ser detectado |
| 3 | Agua que duele | Río Madre de Dios | Encontrar la fuente de contaminación y cerrarla |
| 4 | La línea del territorio | Amarakaeri | Ayudar a la comunidad a demarcar y defender su territorio |
| 5 | El último paso | Parque del Manu | Confrontación final, convocar aliados, solución colectiva |

### Misiones secundarias (profundidad narrativa)
Opcionales pero enriquecen la historia y dan recompensas.

- Recolectar testimonios de pobladores afectados (se convierten en "cartas abiertas" en el menú del juego)
- Ayudar a animales heridos a llegar a zonas seguras
- Encontrar objetos culturales de comunidades desplazadas y devolverlos
- Revelar rutas de escape clandestinas de mercurio

### Misiones de conocimiento (datos reales)
Minijuegos educativos disfrazados de desafíos.

- **El ciclo del mercurio:** conectar cómo el mercurio va de la mina al río, al pez, a la persona
- **El mapa de la deforestación:** ordenar imágenes satelitales reales de Madre de Dios por año
- **¿Qué vale más?:** calcular cuánto genera la minería vs. el ecoturismo en la misma zona
- **La cadena de vida:** identificar qué especies desaparecen cuando se destruye cada ecosistema

---

## Mecánicas de juego

### Movimiento y exploración
- Vista top-down 2D estilo Zelda: Link's Awakening / A Link to the Past
- El héroe camina, corre, interactúa con objetos y PNJs
- El mapa se revela progresivamente al explorar
- Zonas contaminadas tienen efectos visuales: desaturación, niebla tóxica, sonido opresivo

### Combate (mínimo y simbólico)
El juego minimiza el combate tradicional. Los "enemigos" no son personas sino obstáculos:

- **Guardias de la minera:** se evitan con sigilo, no se atacan
- **Zonas tóxicas:** se atraviesan con objetos o habilidades
- **Burocracia:** "jefes" resueltos con diálogo y recopilación de evidencia, no con espadas

Esto refuerza el mensaje: el problema no tiene solución violenta.

### Sistema de aliados
A lo largo del mapa, el héroe suma aliados:

- Cada aliado tiene una habilidad especial que desbloquea nuevas zonas
- Los aliados aparecen en la pantalla final como muestra del poder colectivo
- Al completar el juego, el jugador ve cuántos aliados logró convocar

### Objetos importantes

| Objeto | Descripción | Dónde se encuentra |
|---|---|---|
| Cámara documental | Documenta daños, activa eventos de denuncia | Puerto Maldonado |
| Semillas sagradas | Permite restaurar zonas pequeñas | Comunidad Amarakaeri |
| Mapa ancestral | Revela rutas ocultas en el bosque | Con Tato, guardián Harakmbut |
| Filtro de agua | Permite cruzar zonas de mercurio | Río Madre de Dios |
| Expediente legal | Acumula evidencia para la misión final | Se construye durante el juego |

---

## Diseño visual

### Paleta de colores por zona

| Zona | Colores dominantes | Atmósfera |
|---|---|---|
| Puerto Maldonado | Ocre, marrón, verde pálido | Tensión, nostalgia |
| La Pampa | Gris ceniza, marrón oscuro, amarillo sucio | Opresión, vacío |
| Río Madre de Dios | Amarillo turbio, marrón oxidado, azul apagado | Tristeza, peligro latente |
| Amarakaeri | Verde intenso, azul cielo, terracota | Esperanza, vida |
| Parque del Manu | Verde brillante, azul profundo, multicolor | Maravilla, victoria posible |

### Estética retro
- Pixel art de 16 bits estilo SNES
- Tiles de 16×16 o 32×32 píxeles
- Paleta limitada por zona (máx. 16 colores por pantalla) para autenticidad retro
- Animaciones simples pero expresivas
- Fuente pixel art con soporte para español (tildes, ñ)

### HUD (interfaz durante el juego)
- Arriba izquierda: nombre del héroe + hojas de vida
- Arriba derecha: indicador de zona actual
- Abajo: barra de Vínculo Natural + objetos equipados
- Al recoger datos reales: aparece un recuadro con el dato, estilo "pergamino"

---

## Diseño de sonido

### Música
- Chiptune 8/16-bit con instrumentos nativos amazónicos integrados (quena, zampoña procesada)
- Cada zona tiene su tema musical que refleja su estado ambiental
- La música de La Pampa es disonante y opresiva
- La música del Manu es la más rica melódicamente — recompensa auditiva al llegar

### Efectos de sonido
- Sonidos de la selva (aves, agua, viento) en zonas sanas
- Ruido de maquinaria y estática en zonas mineras
- Los aliados tienen frases de voz breves en español

---

## Pantallas del juego

### 1. Pantalla de título
- Logo "Desierto de Oro" sobre imagen del contraste bosque/desierto
- Opciones: Nueva partida, Continuar, Acerca del juego

### 2. Creación del héroe
- Selección de sprite (hombre/mujer)
- Campo de nombre
- Texto introductorio breve sobre Madre de Dios
- Botón: "Comenzar el viaje"

### 3. Mapa del mundo
- Accesible en cualquier momento desde el menú
- Muestra zonas visitadas, zonas disponibles y zonas bloqueadas
- Indicadores de misiones activas
- Contador de aliados reunidos y zonas restauradas

### 4. Pantalla de fin de juego
- Muestra el porcentaje de la región "restaurada" por el jugador
- Lista de aliados convocados con sus nombres
- Mensaje de impacto real: datos actualizados sobre la situación en Madre de Dios
- Botón: "Compartir mi resultado" (para difusión en redes)
- Enlace a organizaciones reales que trabajan en la región

### 5. Enciclopedia / Diario
- Se completa durante el juego
- Secciones: Flora, Fauna, Comunidades, Datos del impacto minero, Testimonios
- Funciona como recurso educativo real

---

## Mensajes clave que el juego comunica

1. La minería ilegal en Madre de Dios no es solo un problema ambiental — es una crisis humanitaria que afecta a comunidades indígenas, a la biodiversidad y al agua de toda la región.

2. Las comunidades locales son los principales guardianes del territorio, no víctimas pasivas.

3. La solución requiere acción colectiva: comunidades, jóvenes, Estado y sociedad civil.

4. El bosque amazónico tiene un valor económico, cultural y ecológico que supera con creces al del oro extraído.

5. La situación es urgente pero no irreversible — hay zonas que se pueden recuperar.

---

## Datos reales integrados en el juego

Estos datos aparecen durante el juego en momentos clave, siempre en contexto narrativo:

- Más de 10,000 hectáreas devastadas solo en La Pampa (Madre de Dios)
- El mercurio usado en la minería contamina ríos y se acumula en la cadena alimentaria
- Madre de Dios alberga una de las mayores biodiversidades del planeta: más de 1,000 especies de aves
- Las comunidades indígenas que viven en aislamiento voluntario están en riesgo directo por el avance minero
- El ecoturismo y la castaña generan más empleo sostenible que la minería informal en la región

---

## Organizaciones reales para vincular al final del juego

- FENAMAD (Federación Nativa del Río Madre de Dios y Afluentes)
- SERNANP — Parque Nacional del Manu
- DAR (Derecho, Ambiente y Recursos Naturales)
- Monitoring of the Andean Amazon Project (MAAP)

---

## Notas para el desarrollo en Claude Design

- El juego debe funcionar completamente en el navegador (HTML5 + Canvas o Phaser.js)
- Priorizar accesibilidad: texto en español, controles simples (teclado y touch)
- El archivo de sprites puede generarse con herramientas pixel art (Aseprite, Piskel)
- Mapa del mundo diseñado como imagen estática interactiva en primera instancia, luego expandir
- Sistema de guardado: localStorage del navegador
- El juego debe poder jugarse en 30-45 minutos para una experiencia completa

---

*Documento de diseño v1.0 — Para uso con Claude Design*
*Proyecto: difusión ambiental, región Madre de Dios, Perú*

---

## Stack tecnológico para desarrollo móvil

El juego debe funcionar en Android e iOS como aplicación nativa o híbrida. Se documentan tres opciones viables ordenadas por recomendación.

---

### Opción 1 — Godot Engine (RECOMENDADA)

**¿Por qué Godot?**
Godot es un motor de videojuegos open source, gratuito y diseñado específicamente para juegos 2D. Es ideal para este proyecto por su soporte nativo para estética pixel art, exportación directa a Android e iOS, y su comunidad activa en Latinoamérica.

**Tecnologías del stack:**
- Motor: Godot 4.x
- Lenguaje de scripting: GDScript (similar a Python, fácil de aprender)
- Renderizado 2D: TileMap + Sprite2D + AnimationPlayer (pixel art nativo)
- Exportación: Android APK / iOS IPA directamente desde el editor
- Audio: AudioStreamPlayer (soporta OGG, MP3, WAV)
- Guardado: ResourceSaver / FileAccess (almacenamiento local en el dispositivo)
- UI del juego: Control nodes (CanvasLayer) para HUD y menús

**Requerimientos mínimos del dispositivo:**
- Android 5.0 (API 21) o superior
- iOS 12 o superior
- 512 MB RAM mínimo
- OpenGL ES 3.0 / Vulkan

**Herramientas complementarias:**
- Aseprite: diseño de sprites y animaciones pixel art
- Tiled Map Editor: diseño de tilemaps del mapa del mundo
- Audacity / LMMS: creación de efectos de sonido y música chiptune

---

### Opción 2 — Unity 2D

**¿Por qué Unity?**
Unity tiene el ecosistema más grande de recursos y documentación para juegos 2D. Tiene una curva de aprendizaje mayor que Godot pero más recursos en línea.

**Tecnologías del stack:**
- Motor: Unity 6 LTS (versión estable actual)
- Lenguaje: C#
- Renderizado 2D: Universal Render Pipeline (URP) 2D + Tilemap system
- Exportación: Android Build Support / iOS Build Support (requiere Mac para iOS)
- Audio: Unity Audio Mixer
- Guardado: PlayerPrefs / FileStream (local)
- UI: Unity UI Toolkit o Canvas UI

**Requerimientos mínimos del dispositivo:**
- Android 6.0 (API 23) o superior
- iOS 13 o superior
- 1 GB RAM recomendado

**Consideración importante:**
Unity cobra regalías por descargas si el proyecto supera ciertos umbrales de ingresos. Para un proyecto sin fines de lucro o educativo, Unity Personal es gratuito.

---

### Opción 3 — Flutter + Flame (para equipos con experiencia web/mobile)

**¿Por qué Flutter + Flame?**
Si el equipo ya tiene experiencia con Flutter (desarrollo móvil multiplataforma), Flame es un motor de juegos 2D construido sobre Flutter. Permite compartir código con una app complementaria de información ambiental.

**Tecnologías del stack:**
- Framework: Flutter 3.x
- Motor de juego: Flame 1.x (game loop, colisiones, sprites, tiled maps)
- Lenguaje: Dart
- Exportación: Android e iOS desde el mismo codebase
- Audio: flame_audio (envuelve audioplayers)
- Guardado: shared_preferences / Hive (base de datos local ligera)
- Tiled Maps: flame_tiled (integración directa con Tiled Map Editor)

**Requerimientos mínimos del dispositivo:**
- Android 5.0 o superior
- iOS 12 o superior

**Consideración:**
Flame es menos maduro que Godot o Unity para juegos complejos, pero suficiente para este proyecto de escala media.

---

### Tabla comparativa

| Criterio | Godot | Unity | Flutter + Flame |
|---|---|---|---|
| Costo | Gratuito total | Gratuito (con límites) | Gratuito total |
| Curva de aprendizaje | Baja-media | Media-alta | Media |
| Soporte pixel art 2D | Excelente | Bueno | Bueno |
| Exportación Android/iOS | Directa | Directa | Directa |
| Tamaño del APK | ~20-40 MB | ~50-80 MB | ~15-30 MB |
| Comunidad hispana | Creciente | Grande | Pequeña |
| Recomendado para | Este proyecto | Equipos Unity | Devs Flutter |

---

### Estructura de archivos del proyecto (Godot)

```
desierto_de_oro/
├── assets/
│   ├── sprites/          # personajes, tiles, objetos
│   ├── audio/            # música y efectos
│   ├── fonts/            # fuente pixel art en español
│   └── ui/               # iconos HUD, menús
├── scenes/
│   ├── world/            # mapa general y zonas
│   ├── ui/               # pantallas de menú, HUD
│   ├── characters/       # héroe, PNJs, aliados
│   └── missions/         # lógica de cada misión
├── scripts/
│   ├── game_manager.gd   # controlador global
│   ├── hero.gd           # lógica del personaje
│   ├── map.gd            # navegación del mapa
│   └── mission.gd        # sistema de misiones
├── data/
│   ├── zones.json        # datos de cada zona
│   ├── missions.json     # configuración de misiones
│   └── facts.json        # datos reales ambientales
└── project.godot
```

---

## Diagramas de secuencia

Los siguientes diagramas documentan los flujos principales del juego.

---

### Diagrama 1 — Flujo general del juego

**Actores:** Jugador, Sistema del juego

**Descripción:** El jugador arranca desde la pantalla de título, crea su héroe, accede al mapa del mundo de Madre de Dios y navega entre las 5 zonas. Desde cada zona activa misiones. Al completar una misión recibe recompensa (aliado + dato real). Al fallar regresa al mapa. El juego termina cuando completa la misión final en el Parque del Manu y se muestra el impacto logrado.

**Secuencia principal:**
1. Jugador abre el juego → pantalla de título
2. Elige "Nueva partida" → pantalla de creación del héroe
3. Crea héroe (nombre + género) → sistema inicializa estado
4. Sistema carga mapa del mundo → Jugador explora
5. Jugador entra a una zona → zona activa misiones disponibles
6. Jugador acepta misión → sistema carga desafío
7. Jugador completa desafío → sistema evalúa resultado
8. Éxito: otorga aliado + dato ambiental + desbloquea zona siguiente
9. Falla: Jugador pierde vida → reinicia zona → vuelve al mapa
10. Al completar misión final → pantalla de impacto + llamado a la acción

---

### Diagrama 2 — Creación del héroe

**Actores:** Jugador, Pantalla de inicio, Sistema del juego

**Descripción:** Flujo detallado de la pantalla de creación del personaje, desde que el jugador elige "Nueva partida" hasta que el sistema inicializa el estado y carga la intro narrativa con el nombre del héroe.

**Secuencia:**
1. Jugador abre el juego
2. Pantalla muestra título y opciones
3. Jugador elige "Nueva partida"
4. Pantalla muestra selector de género (hombre / mujer)
5. Jugador elige género
6. Pantalla activa campo de nombre
7. Jugador escribe nombre del héroe
8. Jugador presiona "Comenzar el viaje"
9. Pantalla envía género + nombre al sistema
10. Sistema crea héroe con estado inicial (vidas, inventario vacío, mapa sin explorar)
11. Sistema carga mapa de Madre de Dios
12. Pantalla muestra intro narrativa con el nombre elegido por el jugador

---

### Diagrama 3 — Misión activa (ejemplo: "Ver para creer" en La Pampa)

**Actores:** Jugador, Zona / Mapa, Misión, Sistema del juego

**Descripción:** Secuencia completa de una misión principal. Incluye bifurcación de éxito (completa la misión, obtiene aliado) y falla (detectado por guardia, pierde vida, reinicia zona).

**Secuencia:**
1. Jugador entra a La Pampa
2. Zona carga escenario devastado (efectos visuales de degradación)
3. Zona activa misión "Ver para creer"
4. Misión muestra objetivo: documentar sin ser detectado
5. Jugador usa habilidad "Analizar" en zona contaminada
6. Zona muestra dato real ambiental (emergente en pantalla)
7. Jugador usa habilidad "Documentar" en área minera
8. Misión registra evidencia en expediente del jugador
9. Misión envía condición al sistema para verificar éxito
10a. (Éxito) Sistema confirma misión completada → otorga aliado + desbloquea zona siguiente
10b. (Falla) Sistema detecta que el guardia vio al jugador → Jugador pierde una hoja de vida → Zona reinicia
11. En ambos casos: Jugador vuelve al mapa del mundo
12. Sistema guarda progreso automáticamente

---

*Documento de diseño v2.0 — Actualizado con tecnologías móviles y diagramas de secuencia*
*Para desarrollo con Godot Engine (recomendado) | Exportación Android e iOS*
