# HU4.2.3 · Cola SQS de eventos paramétricos

Diseño: wiki *Tácticas y Patrones – Escalabilidad 2* (ASR-ESC-002 / HA8): la ingesta de MS Siniestros publica el evento
externo en un bus durable y responde a la fuente solo cuando SQS lo confirma; consumidores sin estado lo procesan con
idempotencia por `event_id`, reintentos por visibilidad y DLQ.

## Recursos (Terraform, dev y prod)

Definidos en `src/environments/<env>/main.tf` con el módulo `src/modules/sqs`, igual que `paymentapproved` e
`insurancepolicyemitted`:

| Módulo | Cola | Configuración |
|---|---|---|
| `parametricevents_queue` | `solventa-<env>-parametricevents` | `VisibilityTimeout = sqs_parametricevents_visibility_timeout_seconds` (60 s: tiempo antes de reintentar un mensaje fallido), retención `sqs_message_retention_seconds`, `RedrivePolicy` → DLQ con `maxReceiveCount = sqs_parametricevents_max_receive_count` (5) |
| `parametricevents_dlq` | `solventa-<env>-parametricevents-dlq` | Retención `sqs_message_retention_seconds` (14 días) para análisis y reproceso |

Salidas: `parametricevents_queue_url` y `parametricevents_dlq_url` → secretos `EVENTOS_PARAMETRICOS_QUEUE_URL` y
`EVENTOS_PARAMETRICOS_DLQ_URL` de MS Siniestros (`solventa-<env>-app-secrets`).

## Despliegue

1. PR a `main` → workflow **Terraform Plan** (manual, entorno `dev`) para revisar que solo se crean las dos colas y sus políticas.
2. Workflow **Terraform Deploy** (`dev`).
3. Copiar las salidas a los secretos del servicio (o al `.env` local para pruebas).

## Permisos

Política `iam-policies/insuranceclaims-sqs-parametric-events.json` (reemplazar `<ACCOUNT_ID>` y `<ENV>`):
- Rol del `ServiceAccount` `solventa-app-sa` (EKS Pod Identity) de MS Siniestros.
- Para pruebas locales, el usuario del perfil local (`SQS_AWS_PROFILE`).

## Configuración del servicio

`EVENTOS_BUS=sqs`, `EVENTOS_PARAMETRICOS_QUEUE_URL`, `EVENTOS_PARAMETRICOS_DLQ_URL`.
