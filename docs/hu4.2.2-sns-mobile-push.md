# HU4.2.2 · SNS Mobile Push en desarrollo

## Propósito

Permitir que `insuranceclaims_service` publique cambios de estado de siniestros en una plataforma SNS de FCM HTTP v1.

## Recursos y secretos

La plataforma SNS se crea fuera de Terraform porque la credencial de cuenta de servicio FCM no debe entrar al estado. Su ARN se entrega al despliegue mediante el secreto `SNS_PLATFORM_APPLICATION_ARN`.

El rol usado por el `ServiceAccount` `solventa-app-sa` requiere la política `iam-policies/insuranceclaims-sns-mobile-push.json` con estas sustituciones en el entorno:

- `SNS_PLATFORM_APPLICATION_ARN`: ARN de la plataforma SNS `app/GCM/...`.
- `SNS_PLATFORM_ENDPOINT_ARN_WILDCARD`: ARN de endpoints `endpoint/GCM/<aplicacion>/*`.

No se almacenan claves FCM, tokens de dispositivos, ARN concretos ni claves AWS en este repositorio.

## Despliegue

1. Crear la plataforma SNS FCM HTTP v1 y conservar su ARN en el gestor de secretos.
2. Aplicar la política al rol de aplicación asociado por Pod Identity.
3. Exponer al despliegue de `insuranceclaims_service`:
   - `NOTIFICACIONES_HABILITADAS=true`
   - `NOTIFICADOR_PUSH=sns`
   - `SNS_PLATFORM_APPLICATION_ARN` desde secreto.
4. Verificar que el `ServiceAccount` conserva la asociación Pod Identity antes de desplegar.

## Alcance de la prueba local

La prueba local usa `NOTIFICADOR_PUSH=registro`; no requiere EKS, Pod Identity ni este cambio de infraestructura. La política es necesaria para la prueba real desde el entorno dev de AWS.
