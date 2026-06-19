# Requerimientos Portal PQRSF — IDEAL SOFTWARE S.A.S

**Objetivo:** Portal público de Peticiones, Quejas, Reclamos, Sugerencias y Felicitaciones en `idealsoluciones.com.co/pqrs`, requerido para la acreditación como proveedor tecnológico DIAN.

**Versión:** MVP (v1.0)
**Tiempo estimado:** 2-3 días de desarrollo

---

## 1. ¿Un formulario basta?

**Sí, para la DIAN basta.** Lo que necesitan es:

- Un canal público documentado donde los clientes puedan registrar PQRSF
- Que cada solicitud reciba un número de radicado único
- Que el cliente pueda consultar el estado de su solicitud

No se requiere un sistema complejo de tickets. Un formulario + email de confirmación + una página de consulta por número de radicado cubre el 100% del requisito.

---

## 2. Funcionalidades MVP

### 2.1 Formulario de envío (`/pqrs`)

| Campo | Tipo | Requerido | Notas |
|---|---|---|---|
| NIT de la empresa | Texto (validar formato NIT colombiano) | Sí | |
| Razón social | Texto | Sí | |
| Nombre del solicitante | Texto | Sí | |
| Email de contacto | Email (validar formato) | Sí | |
| Teléfono | Texto | No | |
| Tipo de solicitud | Select: Petición / Queja / Reclamo / Sugerencia / Felicitación | Sí | |
| Asunto | Texto (máx. 200 chars) | Sí | |
| Descripción | Textarea (máx. 2000 chars) | Sí | |
| Archivo adjunto | File (PDF, PNG, JPG — máx. 5 MB) | No | Solo 1 archivo por simplicidad |
| Aceptar política de datos | Checkbox | Sí | Link a política de privacidad |

**Comportamiento esperado al enviar:**
1. Validar campos en frontend + backend
2. Guardar en base de datos
3. Generar número de radicado (formato: `PQRSF-YYYY-XXXXX`, ej: `PQRSF-2026-00001`)
4. Enviar email automático al solicitante con el número de radicado y resumen de la solicitud
5. Enviar notificación al equipo de soporte (`soporte@idealsoluciones.com.co`)
6. Mostrar pantalla de confirmación con número de radicado y tiempo estimado de respuesta

### 2.2 Consulta de estado (`/pqrs/consulta`)

| Campo | Tipo | Requerido |
|---|---|---|
| Número de radicado | Texto | Sí |
| Email de contacto | Email | Sí |

**Comportamiento:**
- Si coinciden radicado + email, mostrar:
  - Número de radicado
  - Fecha de recepción
  - Tipo de solicitud
  - Estado actual (Recibido / En proceso / Respondido / Cerrado)
  - Última actualización
  - Historial de estados con fechas

### 2.3 Panel interno de gestión (`/pqrs/admin`)

Protegido con autenticación (mismo sistema de login del admin panel existente).

| Funcionalidad | Descripción |
|---|---|
| Listado de solicitudes | Tabla paginada con filtros por estado, tipo, fecha, NIT |
| Ver detalle | Datos completos de la solicitud |
| Cambiar estado | Recibido → En proceso → Respondido → Cerrado |
| Agregar nota interna | Solo visible para el equipo de soporte |
| Enviar respuesta al cliente | Editor de texto simple. Al guardar, envía email al solicitante y cambia estado a "Respondido" |

---

## 3. Requisitos técnicos

| Requisito | Detalle |
|---|---|
| **Dominio** | `idealsoluciones.com.co/pqrs` (misma app Next.js existente, ruta nueva) |
| **Base de datos** | Nueva tabla `pqrsf` en PostgreSQL existente |
| **Emails** | SMTP ya configurado en la plataforma. Usar el mismo servicio |
| **Autenticación** | Panel admin usa el mismo sistema de login del `ideal-admin` |
| **HTTPS** | Ya cubierto por Caddy |
| **Idioma** | Español (Colombia) |

### Esquema de base de datos sugerido

```sql
CREATE TABLE pqrsf (
    id              SERIAL PRIMARY KEY,
    radicado        VARCHAR(20) UNIQUE NOT NULL,   -- PQRSF-2026-00001
    nit             VARCHAR(15) NOT NULL,
    razon_social    VARCHAR(200) NOT NULL,
    nombre          VARCHAR(150) NOT NULL,
    email           VARCHAR(150) NOT NULL,
    telefono        VARCHAR(20),
    tipo            VARCHAR(20) NOT NULL,           -- peticion|queja|reclamo|sugerencia|felicitacion
    asunto          VARCHAR(200) NOT NULL,
    descripcion     TEXT NOT NULL,
    archivo_url     VARCHAR(500),
    estado          VARCHAR(20) DEFAULT 'recibido', -- recibido|en_proceso|respondido|cerrado
    created_at      TIMESTAMPTZ DEFAULT NOW(),
    updated_at      TIMESTAMPTZ DEFAULT NOW(),
    responded_at    TIMESTAMPTZ
);

CREATE TABLE pqrsf_notes (
    id              SERIAL PRIMARY KEY,
    pqrsf_id        INTEGER REFERENCES pqrsf(id),
    nota            TEXT NOT NULL,
    es_respuesta    BOOLEAN DEFAULT FALSE,
    autor           VARCHAR(150) NOT NULL,
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE pqrsf_status_history (
    id              SERIAL PRIMARY KEY,
    pqrsf_id        INTEGER REFERENCES pqrsf(id),
    estado_anterior VARCHAR(20),
    estado_nuevo    VARCHAR(20) NOT NULL,
    changed_by      VARCHAR(150) NOT NULL,
    changed_at      TIMESTAMPTZ DEFAULT NOW()
);
```

---

## 4. Emails automáticos

### 4.1 Confirmación de recepción (al cliente)

```
Asunto: PQRSF-{RADICADO} — Hemos recibido tu {TIPO}

Hola {NOMBRE},

Hemos recibido tu {TIPO} con número de radicado {RADICADO} 
el {FECHA} a las {HORA}.

Tiempo estimado de respuesta: {SEGUN_TIPO}

Puedes consultar el estado en: 
https://idealsoluciones.com.co/pqrs/consulta

Gracias por contactarnos,
Equipo IDEAL SOFTWARE S.A.S
```

### 4.2 Notificación al equipo de soporte

```
Asunto: Nueva PQRSF-{RADICADO} — {TIPO} de {RAZON_SOCIAL}

NIT: {NIT}
Tipo: {TIPO}
Asunto: {ASUNTO}
Enlace admin: https://idealsoluciones.com.co/pqrs/admin/{ID}
```

---

## 5. Tiempos de respuesta (SLA)

Configurados según los niveles definidos en el documento de acreditación:

| Nivel | Tipo PQRSF | Tiempo primera respuesta |
|---|---|---|
| P1 | Crítico (servicio caído) | ≤ 30 min |
| P2 | Alto | ≤ 2 horas |
| P3 | Medio | ≤ 8 horas |
| P4 | Bajo (sugerencias, felicitaciones) | ≤ 24 horas |

---

## 6. Lo que NO necesita el MVP

| No incluir en v1 | Por qué |
|---|---|
| Chat en tiempo real | Sobrecostrucción para MVP |
| Integración con WhatsApp Business | Fase 2 |
| Dashboard de métricas SLA | Fase 2 |
| API REST pública | Solo interna para el admin panel |
| Firma digital en respuestas | No requerido por DIAN para PQRSF |
| Workflow de aprobación de respuestas | MVP: el agente responde directo |

---

## 7. Criterios de aceptación

- [ ] Formulario público en `idealsoluciones.com.co/pqrs`
- [ ] Al enviar, se genera número de radicado único
- [ ] El cliente recibe email de confirmación con el radicado
- [ ] El equipo de soporte recibe notificación
- [ ] El cliente puede consultar estado con radicado + email
- [ ] El equipo de soporte puede ver, actualizar estado y responder desde panel admin
- [ ] HTTPS en todas las páginas
