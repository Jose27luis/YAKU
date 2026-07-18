# Desierto de Oro — Diagramas de secuencia (especificación de flujos)

Este documento define los **pasos concretos** de cada flujo del juego. Funciona como **especificación de implementación**: cada participante mapea a un sistema/nodo previsto en Godot, y cada diagrama describe el comportamiento esperado paso a paso.

Complementa al GDD (`README.md`). Los 3 flujos de alto nivel (general, creación del héroe, misión insignia) viven en el README; aquí están las **mecánicas**, los **sistemas transversales** y la **progresión global**.

> Los diagramas usan sintaxis Mermaid (se renderizan en GitHub y en la mayoría de visores Markdown).

---

## Convención de participantes

Cada actor de los diagramas corresponde a una pieza del proyecto Godot:

| Participante | Rol | Implementación prevista (Godot 4.x) |
|---|---|---|
| **Jugador** | Persona que juega | Input |
| **GameManager** | Estado global, atributos y reglas | Autoload (singleton) |
| **SceneManager** | Transiciones entre escenas | Autoload (singleton) |
| **Pantallas/UI** | Título, creación, menús | Escenas `Control` en `CanvasLayer` |
| **HUD** | Interfaz durante el juego | `CanvasLayer` |
| **Heroe** | Personaje jugable | `CharacterBody2D` |
| **Zona** | Escena de cada zona del mapa | `Node2D` + `TileMap` |
| **Misión** | Lógica de objetivos | Recurso/escena en `missions/` |
| **Expediente** | Evidencia documentada (prueba) | Datos en `GameManager` |
| **Diario** | Testimonios y memoria | Datos en `GameManager` |
| **Yaku** | Espíritu guía (realismo mágico) | Escena + `AnimationPlayer` |
| **Aliado** | Personaje que se suma al viaje | Escena en `characters/` |
| **Guardia** | Antagonista de sigilo | `CharacterBody2D` + cono de visión |
| **SaveSystem** | Guardado / carga | `FileAccess` en `user://` |
| **AudioManager** | Música y efectos | Autoload + `AudioStreamPlayer` |

---

## A. Flujos de sistema (alto nivel)

> El flujo general, la creación del héroe y la misión insignia están en el README. Aquí, el flujo de exploración del mapa y el cierre.

### A1 — Exploración del mapa del mundo (selección de zona)

```mermaid
sequenceDiagram
    actor J as Jugador
    participant Mapa as Mapa del Mundo
    participant GM as GameManager
    participant SM as SceneManager
    participant Z as Zona

    J->>Mapa: Abre el mapa del mundo
    Mapa->>GM: Consultar estado de zonas
    GM-->>Mapa: Visitadas / disponibles / bloqueadas + misiones activas
    J->>Mapa: Selecciona una zona
    alt Zona disponible
        Mapa->>SM: Transición (fundido)
        SM->>Z: Cargar zona (atmósfera, NPCs, misión)
        Z-->>J: Jugador entra a la zona
    else Zona bloqueada
        Mapa-->>J: "Aún no puedes llegar aquí" + pista de qué falta
    end
```

### A2 — Cierre del juego (balance honesto, sin victoria limpia)

```mermaid
sequenceDiagram
    actor J as Jugador
    participant M as Misión Final
    participant Exp as Expediente
    participant GM as GameManager
    participant Fin as Pantalla de Cierre

    J->>M: Reúne aliados y presenta la evidencia (Tres Islas / Manu)
    M->>Exp: Validar pruebas y testimonios reunidos
    Exp-->>M: Denuncia sostenida
    M->>GM: Calcular balance real
    GM->>Fin: Mostrar lo logrado (aliados, evidencia, fragmentos restaurados)
    GM->>Fin: Mostrar lo que NO se pudo salvar
    Fin-->>J: Texto honesto sobre Madre de Dios hoy
    Fin-->>J: Llamado a la acción + organizaciones reales
    J->>Fin: Compartir para difundir la causa
```

---

## B. Mecánicas / habilidades del héroe

### B1 — Observar

```mermaid
sequenceDiagram
    actor J as Jugador
    participant H as Heroe
    participant Z as Zona
    participant C as Conciencia
    participant D as Diario

    J->>H: Pulsa "Observar" frente a una escena
    H->>Z: Buscar punto observable cercano
    alt Hay algo que mirar de verdad
        Z-->>J: Revela el detalle oculto (rastro, gesto, objeto)
        Z->>C: Sumar Conciencia
        opt El detalle es una pista o testimonio
            Z->>D: Registrar hallazgo en el Diario
        end
    else Nada relevante
        Z-->>J: "Aquí no hay nada que mirar dos veces"
    end
```

### B2 — Documentar (la cámara construye la prueba)

```mermaid
sequenceDiagram
    actor J as Jugador
    participant H as Heroe
    participant Cam as Cámara
    participant Z as Zona
    participant Exp as Expediente
    participant HUD as HUD

    J->>H: Equipa la Cámara y apunta a un objetivo
    H->>Cam: Disparar (documentar)
    Cam->>Z: Validar objetivo en el encuadre
    alt Objetivo válido (daño, operación o abuso referido)
        Z-->>Cam: Confirma captura
        Cam->>Exp: Añadir evidencia (id, zona, descripción, fuente real)
        Exp-->>HUD: Animación sobria — evidencia al Expediente
        Exp->>Exp: Comprobar si completa la evidencia clave de la misión
    else Sin objetivo válido
        Cam-->>J: Foto descartada (no es prueba)
    end
```

### B3 — Convocar a Yaku (cruzar río envenenado / revelar camino)

```mermaid
sequenceDiagram
    actor J as Jugador
    participant H as Heroe
    participant V as Vínculo Natural
    participant Y as Yaku
    participant Z as Zona

    J->>H: Invoca a Yaku frente a un obstáculo (río / mercurio)
    H->>V: Consultar Vínculo disponible
    alt Vínculo suficiente y la zona conserva algo de vida
        V->>Y: Manifestar a Yaku
        Y-->>Z: Calmar el agua o revelar el camino oculto
        Y->>V: Consumir Vínculo
        Z-->>J: Cruce habilitado (temporal)
    else Vínculo insuficiente o zona muerta
        Y-->>J: Yaku apenas responde — el daño lo debilita
        Y-->>J: Buscar otra vía (filtro de agua, rodear)
    end
```

### B4 — Sembrar (restaurar un fragmento real, no milagroso)

```mermaid
sequenceDiagram
    actor J as Jugador
    participant H as Heroe
    participant Inv as Inventario
    participant Z as Zona
    participant GM as GameManager

    J->>H: Usa "Sembrar" en una zona recuperable
    H->>Inv: Comprobar semillas sagradas
    alt Tiene semillas y el suelo es recuperable
        Inv->>Inv: Consumir una semilla
        H->>Z: Plantar
        Z-->>J: Brota un fragmento de vida (cambio visual pequeño y real)
        Z->>GM: Registrar fragmento restaurado
    else Sin semillas o suelo muerto
        H-->>J: "Aquí ya nada prende" / "No me quedan semillas"
    end
```

### B5 — Recoger testimonio (núcleo emocional)

```mermaid
sequenceDiagram
    actor J as Jugador
    participant NPC as Poblador / Aliado
    participant D as Diario
    participant C as Conciencia
    participant H as Heroe

    J->>NPC: Habla y escucha
    NPC-->>J: Testimonio con su voz (nombre, rostro, lugar)
    NPC->>D: Guardar testimonio (con fuente real asociada)
    D->>C: Sumar Conciencia
    opt El testimonio desbloquea algo
        D-->>H: Nueva pista, diálogo o acceso
    end
```

---

## C. Sistemas transversales

### C1 — Sigilo y detección

```mermaid
sequenceDiagram
    actor J as Jugador
    participant H as Heroe
    participant G as Guardia
    participant Z as Zona
    participant GM as GameManager

    loop Mientras el héroe está en área vigilada
        G->>G: Patrullar (cono de visión)
        J->>H: Avanza usando cobertura
        alt Héroe dentro del cono y a la vista
            G->>GM: Alerta — héroe detectado
            GM->>H: Restar una hoja de vida
            GM->>Z: Reiniciar desde el último punto seguro
        else Héroe oculto
            Z-->>H: Sigue sin ser visto
        end
    end
    H->>Z: Llega al objetivo y documenta
```

### C2 — Sistema de aliados

```mermaid
sequenceDiagram
    actor J as Jugador
    participant M as Misión
    participant Al as Aliado
    participant GM as GameManager
    participant Mapa as Mapa del Mundo

    M->>Al: Misión resuelta — se suma un aliado
    Al->>GM: Registrar aliado (nombre, habilidad, testimonio)
    Al-->>J: Su habilidad abre una posibilidad nueva (cruce / acceso / voz)
    GM->>Mapa: Actualizar contador de aliados reunidos
    note over GM: En el cierre, todos los aliados<br/>aparecen como fuerza colectiva
```

### C3 — Guardado automático y Continuar

```mermaid
sequenceDiagram
    actor J as Jugador
    participant GM as GameManager
    participant Save as SaveSystem
    participant FS as Almacenamiento local
    participant T as Pantalla de Título

    note over GM,Save: Autosave tras cada misión y cambio de zona
    GM->>Save: Solicitar guardado
    Save->>FS: Escribir estado (héroe, progreso, Expediente, Diario, fragmentos)
    FS-->>Save: OK
    note over J,T: En otra sesión
    J->>T: Selecciona "Continuar"
    T->>Save: Cargar partida
    Save->>FS: Leer estado
    FS-->>Save: Datos
    Save->>GM: Restaurar estado
    GM-->>J: Reanudar en el mapa del mundo
```

---

## D. Visión de conjunto — progresión global

Diagrama de estados que resume la ruta completa: pantallas, zonas y misiones principales. La exploración es **no lineal**; Tres Islas es zona de apoyo accesible en paralelo.

```mermaid
stateDiagram-v2
    [*] --> Titulo
    Titulo --> CreacionHeroe: Nueva partida
    Titulo --> MapaMundo: Continuar
    CreacionHeroe --> IntroNarrativa
    IntroNarrativa --> MapaMundo

    MapaMundo --> PuertoMaldonado: M1 El regreso
    PuertoMaldonado --> MapaMundo: aliado + acceso

    MapaMundo --> LaPampa: M2 Ver para creer
    LaPampa --> MapaMundo

    MapaMundo --> RioMadreDeDios: M3 Agua que duele
    RioMadreDeDios --> MapaMundo

    MapaMundo --> Amarakaeri: M4 La línea del territorio
    Amarakaeri --> MapaMundo

    MapaMundo --> TresIslas: Apoyo (opcional)
    TresIslas --> MapaMundo

    MapaMundo --> Cierre: M5 Romper el silencio (Manu / Tres Islas)
    Cierre --> [*]

    note right of MapaMundo
        Exploración no lineal.
        Cada misión devuelve al mapa
        con autosave y un aliado.
    end note
```

---

*Documento de flujos v1.0 — acompaña al GDD v3.0. Para implementación en Godot 4.x.*
