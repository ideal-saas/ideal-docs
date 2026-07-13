# PLAN-sla-clientes.md
# Plan de Niveles de Servicio (SLA) para Clientes
## IDEAL SOFTWARE S.A.S — NIT: 902.027.596-7
### Preparación para Habilitación DIAN — Resolución 00165 de 2023

**Versión:** 1.0  
**Fecha:** Mayo 2026  
**Estado:** Borrador operativo — pendiente incorporación en contratos

---

## 1. Propósito

Este documento define los Acuerdos de Nivel de Servicio (SLA) que IDEAL SOFTWARE S.A.S ofrece a sus clientes para la plataforma de facturación electrónica. Su propósito es doble:

1. Satisfacer el **numeral 9 del Artículo 55** de la Resolución 00165 de 2023 (DIAN), que exige documentar las condiciones y niveles de servicio ofrecidos a los obligados a facturar electrónicamente.
2. Formalizar los compromisos de calidad de servicio que ya se prestan en la práctica, estableciendo métricas objetivas y mecanismos de compensación.

---

## 2. Alcance

Este SLA aplica a todos los clientes de IDEAL SOFTWARE S.A.S que utilicen la plataforma de facturación electrónica, accesible a través de:

- **Portal web:** https://app.idealsoluciones.com.co
- **API de integración:** https://api.idealsoluciones.com.co
- **GraphQL Federation endpoint:** https://ideal-apollo-mcp-server.rcermeno.link (desarrollo)

---

## 3. Definiciones

| Término | Definición |
|---|---|
| **Disponibilidad** | Porcentaje de tiempo en que el servicio responde correctamente a solicitudes válidas, medido en el mes calendario |
| **Tiempo de Respuesta** | Tiempo desde que el cliente reporta un incidente hasta que el equipo de soporte confirma recepción y asigna responsable |
| **Tiempo de Resolución** | Tiempo desde el reporte hasta que el servicio es restaurado o el problema queda resuelto |
| **Mantenimiento Programado** | Ventanas de mantenimiento notificadas con 48 horas de anticipación; excluidas del cálculo de disponibilidad |
| **Tiempo de Inactividad No Planificado** | Interrupciones del servicio fuera de ventanas de mantenimiento programado |
| **COT** | Hora de Colombia (UTC-5) |

---

## 4. Disponibilidad del Servicio

### 4.1 Compromiso de Disponibilidad

IDEAL SOFTWARE S.A.S se compromete a mantener una disponibilidad mensual del **99,5%** para los servicios descritos en el alcance, calculada de la siguiente manera:

```
Disponibilidad (%) = ((Minutos del mes - Minutos de inactividad no planificada) / Minutos del mes) × 100
```

Un mes calendario tiene entre 43.200 y 44.640 minutos. El 99,5% de disponibilidad equivale a un máximo de **216 a 223 minutos de inactividad no planificada por mes**.

### 4.2 Ventanas de Mantenimiento Programado

| Parámetro | Valor |
|---|---|
| **Día** | Domingos |
| **Horario** | 01:00 – 03:00 COT (UTC-5) |
| **Duración máxima** | 2 horas |
| **Notificación previa** | Mínimo 48 horas antes |
| **Canal de notificación** | Correo electrónico al contacto técnico registrado del cliente |

El tiempo de mantenimiento dentro de estas ventanas **no se contabiliza como inactividad** para efectos del cálculo de disponibilidad.

Si un mantenimiento programado se extiende más allá de las 2 horas acordadas, el tiempo excedente **sí se contabiliza** como inactividad no planificada.

### 4.3 Exclusiones del Cálculo de Disponibilidad

Los siguientes eventos **no se consideran inactividad atribuible a IDEAL SOFTWARE S.A.S**:

- Indisponibilidad de los servicios web de la DIAN (MUISCA, validador de facturas)
- Interrupciones en servicios de terceros: Firebase Authentication, AWS Lightsail (mantenimientos de AWS)
- Fuerza mayor: desastres naturales, cortes masivos de energía, ataques DDoS de escala nacional
- Mantenimientos programados notificados correctamente
- Problemas de conectividad originados en la red del cliente

---

## 5. Clasificación y Tiempos de Respuesta a Incidentes

### 5.1 Tabla de Prioridades

| Prioridad | Descripción | Ejemplo | Tiempo de Respuesta | Tiempo de Resolución |
|---|---|---|---|---|
| **P1 — Crítico** | Servicio completamente no disponible para todos los usuarios | Portal caído, API sin respuesta, imposibilidad total de emitir facturas | ≤ 30 minutos | ≤ 2 horas |
| **P2 — Alto** | Servicio degradado con impacto significativo en operaciones | Lentitud severa, errores intermitentes en transmisión a DIAN, fallas en módulos críticos | ≤ 2 horas | ≤ 8 horas |
| **P3 — Medio** | Impacto parcial; funciones principales operativas | Errores en reportes, problemas en módulos secundarios, falla en un tipo específico de documento | ≤ 8 horas | ≤ 24 horas |
| **P4 — Bajo** | Impacto cosmético o menor; operación normal no afectada | Errores visuales, textos incorrectos, mejoras de usabilidad, consultas informativas | ≤ 24 horas | ≤ 72 horas |

### 5.2 Horario de Soporte

| Tipo de incidente | Horario de atención |
|---|---|
| **P1 (Crítico)** | 24/7 — todos los días, incluyendo festivos |
| **P2 (Alto)** | Lunes a viernes, 08:00 – 18:00 COT |
| **P3 (Medio)** | Lunes a viernes, 08:00 – 18:00 COT |
| **P4 (Bajo)** | Lunes a viernes, 08:00 – 18:00 COT |

Los incidentes P2, P3 y P4 reportados fuera del horario de atención serán atendidos al inicio del siguiente día hábil, sin que esto afecte el cálculo del tiempo de respuesta.

### 5.3 Canales de Soporte

| Canal | Uso recomendado | Disponibilidad |
|---|---|---|
| **Correo electrónico** | soporte@idealsoluciones.com.co | Todos los horarios; respuesta en horario hábil |
| **Teléfono** | Número dedicado de soporte (por asignar) | Lunes a viernes 08:00-18:00 COT; P1 24/7 |
| **WhatsApp Business** | Número dedicado de soporte (por asignar) | Lunes a viernes 08:00-18:00 COT; P1 24/7 |

Para incidentes **P1**, el cliente debe contactar simultáneamente por teléfono y WhatsApp para garantizar atención inmediata.

---

## 6. SLA Específicos para Facturación Electrónica

Adicionalmente a la disponibilidad general, IDEAL SOFTWARE S.A.S establece los siguientes compromisos de rendimiento para operaciones de facturación electrónica:

| Operación | Métrica | Objetivo |
|---|---|---|
| **Generación de factura electrónica** | Tiempo desde solicitud hasta documento PDF/XML generado | < 5 segundos (percentil 95) |
| **Transmisión a DIAN** | Tiempo desde documento en cola hasta envío a DIAN | Depende de disponibilidad DIAN* |
| **Actualización de estado DIAN** | Tiempo desde respuesta DIAN hasta actualización en plataforma | < 60 segundos |
| **Generación de reportes** | Tiempo de respuesta para reportes estándar | < 30 segundos (percentil 95) |

*La DIAN no garantiza tiempos de respuesta de sus propios servicios web. IDEAL SOFTWARE S.A.S implementa reintentos automáticos y notifica al cliente cuando el retraso es atribuible a DIAN.

---

## 7. Metodología de Medición

### 7.1 Monitoreo de Disponibilidad

La disponibilidad se mide mediante **UptimeRobot** con las siguientes configuraciones:

| Monitor | URL monitoreada | Frecuencia | Protocolo |
|---|---|---|---|
| Portal web | https://app.idealsoluciones.com.co | Cada 5 minutos | HTTPS |
| API REST | https://api.idealsoluciones.com.co | Cada 5 minutos | HTTPS |

Cada verificación fallida consecutiva durante 2 ciclos (10 minutos) se registra como inicio de incidente de disponibilidad.

### 7.2 Reportes Mensuales

Al inicio de cada mes calendario, IDEAL SOFTWARE S.A.S genera y envía al contacto técnico registrado de cada cliente:

- Porcentaje de disponibilidad del mes anterior
- Detalle de incidentes registrados (fecha, duración, causa)
- Comparativo con el SLA comprometido
- Estado de las acciones correctivas si aplica

### 7.3 Período de Medición

El período de medición es el **mes calendario** (del día 1 al último día del mes). El SLA anual es el promedio de los 12 meses.

---

## 8. Créditos de Servicio por Incumplimiento

Cuando la disponibilidad mensual caiga por debajo del 99,5%, el cliente tiene derecho a los siguientes créditos sobre su tarifa mensual:

| Disponibilidad mensual | Crédito sobre tarifa mensual |
|---|---|
| 99,0% – 99,49% | 10% |
| 98,0% – 98,99% | 25% |
| < 98,0% | 50% |

### 8.1 Condiciones para Aplicación de Créditos

1. El cliente debe **solicitar el crédito por escrito** dentro de los **30 días calendario** siguientes al mes en que ocurrió el incumplimiento.
2. IDEAL SOFTWARE S.A.S verificará los registros de UptimeRobot y confirmará el incumplimiento.
3. Los créditos se aplican sobre la **próxima factura** del cliente o se descuentan de la renovación.
4. Los créditos **no son acumulables** con otros descuentos ni canjeables por dinero en efectivo.
5. Los créditos son el **único remedio disponible** por incumplimiento de disponibilidad, salvo acuerdo contractual expreso distinto.

### 8.2 Exclusiones de Créditos

No se otorgarán créditos cuando la indisponibilidad sea causada por:

- Eventos de fuerza mayor o caso fortuito (terremotos, inundaciones, apagones nacionales)
- Indisponibilidad de servicios web de la DIAN (MUISCA)
- Ataques DDoS o ciberataques externos no atribuibles a negligencia de IDEAL SOFTWARE S.A.S
- Mantenimientos programados notificados correctamente
- Acciones u omisiones del cliente (uso incorrecto de la API, credenciales inválidas, etc.)
- Incumplimiento de obligaciones de pago por parte del cliente

---

## 9. Escalamiento de Incidentes

```
NIVEL 1: Soporte Técnico (soporte@idealsoluciones.com.co)
  |
  | Si no hay resolución en 50% del tiempo de resolución comprometido
  v
NIVEL 2: Líder Técnico / CTO
  |
  | Si el incidente P1 supera 1 hora sin resolución
  v
NIVEL 3: Gerencia General + notificación a cliente por teléfono
```

---

## 10. Texto a Incorporar en Contratos de Clientes

La siguiente cláusula debe agregarse como **"Cláusula X — Niveles de Servicio"** en todos los contratos de servicio de IDEAL SOFTWARE S.A.S:

---

> **CLÁUSULA X. NIVELES DE SERVICIO.**
>
> **X.1 Disponibilidad.** EL PROVEEDOR garantiza una disponibilidad mensual del 99,5% para los servicios descritos en el objeto del presente contrato, medida de conformidad con la metodología establecida en el documento "Plan de Niveles de Servicio (SLA)" vigente, disponible a solicitud del CLIENTE.
>
> **X.2 Mantenimiento Programado.** EL PROVEEDOR podrá realizar mantenimientos programados los domingos entre las 01:00 y las 03:00 hora Colombia (COT), notificando al CLIENTE con un mínimo de 48 horas de anticipación. El tiempo de mantenimiento dentro de esta ventana no se contabilizará como inactividad para efectos del cálculo de disponibilidad.
>
> **X.3 Tiempos de Respuesta.** EL PROVEEDOR atenderá los incidentes reportados por EL CLIENTE de acuerdo con los tiempos establecidos en el Plan de Niveles de Servicio vigente, según la prioridad asignada al incidente.
>
> **X.4 Créditos de Servicio.** En caso de incumplimiento del nivel de disponibilidad comprometido, EL CLIENTE podrá solicitar créditos de servicio de conformidad con la tabla de compensaciones establecida en el Plan de Niveles de Servicio, dentro de los 30 días calendario siguientes al mes en que ocurrió el incumplimiento.
>
> **X.5 Facturación Electrónica.** EL PROVEEDOR garantiza que la generación de documentos de facturación electrónica se realizará en menos de 5 segundos (percentil 95) una vez recibida la solicitud válida. Los tiempos de transmisión a la DIAN dependen de la disponibilidad de los servicios web de la DIAN, que son ajenos al control de EL PROVEEDOR.

---

## 11. Texto a Incorporar en punto-8-infraestructura.md

La siguiente sección debe agregarse al documento `punto-8-infraestructura.md` como nueva **Sección 9. Condiciones y Niveles de Servicio** (requerida por el numeral 9 del Artículo 55 de la Resolución 00165 de 2023):

---

> ### 9. Condiciones y Niveles de Servicio
>
> IDEAL SOFTWARE S.A.S establece los siguientes niveles de servicio para los obligados a facturar electrónicamente que utilicen su plataforma:
>
> **9.1 Disponibilidad del Servicio**
>
> La plataforma de facturación electrónica garantiza una disponibilidad mensual del **99,5%**, medida mediante monitoreo continuo con herramienta UptimeRobot sobre los endpoints `api.idealsoluciones.com.co` y `app.idealsoluciones.com.co`. Las ventanas de mantenimiento programado (domingos 01:00-03:00 COT, con notificación previa de 48 horas) no se contabilizan como tiempo de inactividad.
>
> **9.2 Tiempos de Atención a Incidentes**
>
> | Prioridad | Tiempo de Respuesta | Tiempo de Resolución |
> |---|---|---|
> | P1 — Crítico (servicio no disponible) | ≤ 30 minutos | ≤ 2 horas |
> | P2 — Alto (servicio degradado) | ≤ 2 horas | ≤ 8 horas |
> | P3 — Medio (impacto parcial) | ≤ 8 horas | ≤ 24 horas |
> | P4 — Bajo (cosmético/menor) | ≤ 24 horas | ≤ 72 horas |
>
> Los incidentes P1 tienen soporte 24/7. Los demás incidentes tienen soporte de lunes a viernes, 08:00-18:00 COT.
>
> **9.3 Rendimiento de Facturación Electrónica**
>
> | Operación | Tiempo comprometido |
> |---|---|
> | Generación de factura electrónica | < 5 segundos (P95) |
> | Actualización de estado DIAN | < 60 segundos tras respuesta DIAN |
> | Generación de reportes | < 30 segundos (P95) |
>
> **9.4 Compensaciones**
>
> En caso de incumplimiento del nivel de disponibilidad, los clientes pueden solicitar créditos sobre su tarifa mensual: 10% para disponibilidad entre 99,0%-99,49%; 25% para 98,0%-98,99%; 50% para disponibilidad inferior al 98,0%.
>
> El detalle completo de condiciones, exclusiones y procedimiento de reclamación se encuentra en el documento **PLAN-sla-clientes.md** y en la cláusula de niveles de servicio incluida en los contratos de los clientes.

---

## 12. Lista de Verificación Previa a Radicación DIAN

Las siguientes acciones deben completarse **antes de radicar la solicitud de habilitación ante la DIAN**:

- [ ] **Incorporar cláusula SLA** en la plantilla de contratos de clientes (usar texto de la Sección 10 de este documento)
- [ ] **Crear cuenta en UptimeRobot** (https://uptimerobot.com) y configurar los dos monitores:
  - Monitor 1: `https://app.idealsoluciones.com.co` — tipo HTTPS, intervalo 5 min
  - Monitor 2: `https://api.idealsoluciones.com.co` — tipo HTTPS, intervalo 5 min
- [ ] **Tomar screenshot de los monitores activos** → Evidencia E-9 (ver PLAN-evidencias.md)
- [ ] **Configurar alertas de Grafana** para detección de incumplimiento de SLA (umbral: disponibilidad < 99,5% en ventana de 30 días)
- [ ] **Configurar canal de notificación** de UptimeRobot: correo electrónico, SMS o Slack
- [ ] **Crear plantilla de reporte mensual** de disponibilidad para enviar a clientes
- [ ] **Documentar números de teléfono y WhatsApp Business** de soporte y agregarlos a este documento
- [ ] **Actualizar punto-8-infraestructura.md** con el texto de la Sección 11 de este documento

---

## 13. Relación con Requisitos DIAN

| Requisito Resolución 00165/2023 | Cómo lo cumple este documento |
|---|---|
| Art. 55 numeral 9: Condiciones y niveles de servicio | Sección 4 (disponibilidad), Sección 5 (tiempos de respuesta), Sección 6 (SLA facturación) |
| Art. 55 numeral 8: Infraestructura tecnológica | Sección 7 (metodología de medición con UptimeRobot) |
| Contratos con clientes | Sección 10 (texto de cláusula contractual) |

---

*Documento preparado para uso interno de IDEAL SOFTWARE S.A.S. Versión sujeta a revisión y aprobación por la Gerencia General antes de incorporación en contratos y radicación ante la DIAN.*
