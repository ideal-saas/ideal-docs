# Requerimientos Portal PQRSF — IDEAL SOFTWARE S.A.S

**Objetivo:** Portal público de Peticiones, Quejas, Reclamos, Sugerencias y Felicitaciones en `idealsoluciones.com.co/pqrs`, requerido para la acreditación como proveedor tecnológico DIAN.

**Implementación:** Formulario en WordPress, gestionado por el equipo de marketing.

---

## Campos del formulario

| # | Campo | Tipo | Requerido | Notas |
|:---:|---|---|:---:|---|
| 1 | NIT de la empresa | Texto | Sí | Validar formato NIT colombiano (ej: 902.027.596-7) |
| 2 | Razón social | Texto | Sí | Nombre completo de la empresa |
| 3 | Nombre del solicitante | Texto | Sí | Persona que envía la solicitud |
| 4 | Email de contacto | Email | Sí | Donde recibirá la respuesta |
| 5 | Teléfono | Texto | No | Opcional, para contacto rápido |
| 6 | Tipo de solicitud | Lista desplegable | Sí | Petición / Queja / Reclamo / Sugerencia / Felicitación |
| 7 | Asunto | Texto | Sí | Máximo 200 caracteres |
| 8 | Descripción | Texto largo | Sí | Máximo 2000 caracteres |
| 9 | Archivo adjunto | Archivo | No | PDF, PNG o JPG. Máximo 5 MB. Solo 1 archivo |
| 10 | Aceptar política de datos | Casilla de verificación | Sí | Con link a la política de privacidad |

## Comportamiento al enviar

- Mostrar pantalla de confirmación con número de radicado asignado
- Enviar email automático al solicitante con el número de radicado y copia de su solicitud
- Enviar notificación a `soporte@idealsoluciones.com.co`

## Número de radicado

Formato: `PQRSF-YYYY-XXXXX` (ej: `PQRSF-2026-00001`). Secuencial por año, se reinicia cada enero.

## Página de consulta

Adicional al formulario, se necesita una página donde el cliente pueda consultar el estado de su solicitud ingresando:
- Número de radicado
- Email de contacto

Debe mostrar: número de radicado, fecha, tipo, estado actual (Recibido / En proceso / Respondido / Cerrado).

## Tiempos de respuesta (SLA)

| Tipo | Primera respuesta |
|---|---|
| Queja o Reclamo | ≤ 2 horas hábiles |
| Petición | ≤ 8 horas hábiles |
| Sugerencia o Felicitación | ≤ 24 horas hábiles |
