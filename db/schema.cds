namespace db;

using {
  cuid,
  managed
} from '@sap/cds/common';

// ======================================================
// TYPES / ENUMS
// ======================================================

type EstadoBrecha            : Integer enum {
  REGISTRADA = 1;
  INVESTIGACION = 2;
  CONTENIDA = 3;
  CERRADA = 4;
}

type UnidadTiempo            : Integer enum {
  DIAS = 1;
  SEMANAS = 2;
  MESES = 3;
}

type Criticidad              : String enum {
  BAJA = 'Baja';
  MEDIA = 'Media';
  ALTA = 'Alta';
}

type CategoriaFormulario     : String enum {
  PRIVACIDAD = 'Privacidad';
  DATOS_PERSONALES = 'Datos Personales';
  INCIDENCIA = 'Incidencia';
  CONSULTA_GENERAL = 'Consulta General';
  OTRO = 'Otro';
}

type DerechosDisponibles     : Integer enum {
  ACCESO = 1;
  RECTIFICACION = 2;
  SUPRESION = 3;
  OPOSICION = 4;
  PORTABILIDAD = 5;
}

type EstadoCapacitacion      : Integer enum {
  PENDIENTE = 1;
  FINALIZADO = 2;
}

type EstadoFormulario        : String enum {
  ACTIVO = 'Activo';
  INACTIVO = 'Inactivo';
  BORRADOR = 'Borrador';
  PUBLICADO = 'Publicado';
  ARCHIVADO = 'Archivado';
}

type EstadoGeneral           : String enum {
  ACTIVO = 'Activo';
  EN_REVISION = 'En Revisión';
  COMPLETADO = 'Completado';
  ARCHIVADO = 'Archivado';
  BORRADOR = 'Borrador';
}

type EstadoJob               : String enum {
  ACTIVO = 'Activo';
  INACTIVO = 'Inactivo';
  EJECUTANDO = 'Ejecutando';
  ERROR = 'Error';
  PAUSADO = 'Pausado';
}

type EstadoVersionFormulario : String enum {
  BORRADOR = 'Borrador';
  ACTIVA = 'Activa';
  ARCHIVADA = 'Archivada';
}

type Evaluacion              : Integer enum {
  APLICA = 1;
  NO_APLICA = 2;
}

type InteresLegitimo         : Integer enum {
  APLICA = 1;
  NO_APLICA = 2;
}

type POperacional            : String enum {
  OPERACIONAL = 'Operacional';
  FINANCIERO = 'Financiero';
  ESTRATEGICO = 'Estratégico';
  CUMPLIMIENTO = 'Cumplimiento';
  TECNOLOGICO = 'Tecnológico';
  OTRO = 'Otro';
}

type PrioridadNotificacion   : String enum {
  LOW = 'LOW';
  NEUTRAL = 'NEUTRAL';
  HIGH = 'HIGH';
}

type TipoAlerta              : String enum {
  DENUNCIA_SIN_RESPONDER = 'DenunciaSinResponder';
  CAPACITACION_PROXIMA = 'CapacitacionProxima';
  EVALUACION_PENDIENTE = 'EvaluacionPendiente';
  RAT_REVISION_PENDIENTE = 'RatRevisionPendiente';
  BRECHA_CRITICA = 'BrechaCritica';
  CONTROL_VENCIDO = 'ControlVencido';
}

type TipoAlertas             : Integer enum {
  PLAZO_CONSERVACION = 1;
  DENUNCIAS = 2;
  PLAZOS_RAT = 3;
  SOLICITUDES_ARSO = 4;
  CONTROLES_RIESGO = 5;
}

type TipoArco                : String enum {
  ACCESO = 'Acceso';
  RECTIFICACION = 'Rectificación';
  CANCELACION = 'Cancelación';
  OPOSICION = 'Oposición';
}

type TipoDatoCampo           : String enum {
  TEXTO = 'Texto';
  TEXTO_LARGO = 'Texto Largo';
  NUMERO = 'Número';
  FECHA = 'Fecha';
  FECHA_HORA = 'Fecha y Hora';
  BOOLEAN = 'Booleano';
  OPCIONES = 'Opciones';
  EMAIL = 'Email';
  TELEFONO = 'Teléfono';
  ADJUNTO = 'Adjunto';
  TITULO = 'Título';
  SUBTITULO = 'Subtítulo';
  SEPARADOR = 'Separador';
  TEXTO_INFORMATIVO = 'Texto Informativo';
  ESPACIADOR = 'Espaciador';
}

type TipoDoc                 : Integer enum {
  TIPO_DOC1 = 1;
  TIPO_DOC2 = 2;
}

type TipoEnvioFormulario     : String enum {
  SOLICITUD_INICIAL = 'Solicitud Inicial';
  RESPUESTA_EMPRESA = 'Respuesta Empresa';
}

type TipoFormulario          : String enum {
  CAPACITACION = 'Capacitación';
  CONSULTA = 'Consulta';
  DENUNCIA = 'Denuncia';
  SOLICITUD = 'Solicitud';
  RAT = 'RAT';
}

type DatosAfectados          : String enum {
  DATOS_PERSONALES = 'Datos Personales';
  DATOS_SENSIBLES = 'Datos Sensibles';
  FINANCIEROS = 'Financieros';
  SALUD = 'Salud';
  OTROS = 'Otros';
}

type OrigenBrecha            : Integer enum {
  INTERNO = 1;
  EXTERNO = 2;
  MIXTO = 3;
  DESCONOCIDO = 4;
}

// ======================================================
// ENTITIES
// ======================================================

entity ACCION_NOTIFICACION : cuid, managed {
  TIPO_ALERTA      : TipoAlerta           @title: 'Tipo de Alerta';
  ACCION_ID        : String(100)          @title: 'ID de Acción'         @mandatory;
  NOMBRE_ACCION    : String(100)          @title: 'Nombre de la Acción'  @mandatory;
  DESCRIPCION      : String(255)          @title: 'Descripción';
  ACTIVO           : Boolean default true @title: 'Activo';
  ENDPOINT_HANDLER : String(255)          @title: 'Handler del Endpoint';
  PARAMETROS_JSON  : LargeString          @title: 'Parámetros JSON';
}

entity ACTIVIDAD : cuid, managed {
  NOMBRE_ACTIVIDAD : String(255)  @title: 'Nombre de la Actividad'  @mandatory;
  DESCRIPCION      : String(1000) @title: 'Descripción';
  FECHA_CREACION   : Date         @title: 'Fecha de Creación';
  FECHA_INICIO     : Date         @title: 'Fecha de Inicio';
  FECHA_FIN        : Date         @title: 'Fecha de Fin';
  ESTADO           : String(50)   @title: 'Estado';
  PRIORIDAD        : String(50)   @title: 'Prioridad';
  RAT_ID           : String(50);
}

entity ALERTA : cuid {
  FECHA            : DateTime;
  ESTADO_EJECUCION : Boolean;
}

entity ALERTA_SIMPLE : cuid, managed {
  TIPO         : TipoAlerta  @title: 'Tipo';
  DESTINATARIO : String(100) @title: 'Destinatario';
  MENSAJE      : String(500) @title: 'Mensaje';
  ENVIADO_OK   : Boolean     @title: 'Enviado OK';
}

entity ASISTENCIA : cuid, managed {
  NOMBRE                : String(100);
  RUT                   : String(20);
  CORREO                : String(100);
  TIPO_ASISTENCIA       : String(45);
  ASISTIO               : Boolean;
  CODIGO_EVALUACION     : String(8)             @title: 'Código de Evaluación';
  EVALUACION_COMPLETADA : Boolean default false @title: 'Evaluación Completada';
  FECHA_EVALUACION      : Timestamp             @title: 'Fecha de Evaluación';
  ASISTENCIA            : String(70);
}

entity BASE_LICITUD : cuid, managed {
  NOMBRE_BASE_LEGAL  : String(255);
  DOCUMENTO_ASOCIADO : String(255);
  URL_DOC_ASOCIADO   : String(255);
  ESTADO             : String(255);
  DESCRIPCION        : String(500);
  RAT_BASE_PERSONAL  : String(70);
  RAT_BASE_ESPECIAL  : String(70);
}

entity BRECHA : cuid, managed {
  // Información Básica
  NOMBRE               : String(255);
  TIPO                 : String(100);
  TIEMPO_DETECCION     : DateTime;
  TIEMPO_INCIDENTE     : DateTime;
  DESCRIPCION          : String(1000);
  ESTADO               : EstadoBrecha; // enum
  // Alcance y Origen
  DATOS_AFECTADOS      : DatosAfectados; // enum
  NUMERO_TITULAR       : Integer;
  ORIGEN               : OrigenBrecha;
  // RAT
  RAT_ID               : String(70);
  //Evaluación de Gravedad
  NIVEL_GRAVEDAD       : String(50);
  DETALLE_RIESGOS      : String(250);
  REPORTE_AGENCIA      : Boolean;
  COMUNICACION_TITULAR : Boolean;
}

entity CAMPOS : cuid, managed {
  NOMBRE_CAMPO      : String(255);
  DESCRIPCION_CAMPO : String(255);
  TIPO_DATOS        : String(255);
  PLAZO_INDIVIDUAL  : Integer;
  PROPOSITO         : String(70);
  SISTEMA           : String(70);
  PARAMETRO         : String(70);
}

entity CAMPOS_FORMULARIO : cuid, managed {
  NOMBRE      : String(80);
  LABEL       : String;
  TIPO        : TipoDatoCampo;
  OBLIGATORIO : Boolean default false;
  ES_MULTIPLE : Boolean default false;
  ORDEN       : Integer;
  ACTIVO      : Boolean default true;
  VERSION     : String(70);
}

entity CAPACITACION : cuid, managed {
  NOMBRE              : String(100);
  DESCRIPCION         : String(400);
  TIPO                : Integer;
  ESTADO              : EstadoCapacitacion;
  FECHA_PROGRAMADA    : Timestamp;
  FECHA_REALIZACION   : Timestamp;
  DURACION_HH         : Integer;
  CODIGOS_GENERADOS   : Boolean default false @title: 'Códigos Generados';
  CODIGO_CAPACITACION : String(8)             @title: 'Código de Capacitación';
  URL_REUNION         : String(1000);
  URL_FORMS           : String(1000);
  ASISTENCIA          : String(70);
  FORM_SUB_DOC        : String(70);
}

entity CONFIGURACION_ALERTA : cuid, managed {
  TIPO_ALERTA   : String(20);
  TIPO_ARSO     : String(1);
  RIESGO        : String(70);
  RAT           : String(70);
  TIPO_DENUNCIA : String(70);
}

entity CONFIGURACION_ALERTA_NIVEL : cuid, managed {
  NIVEL             : Integer;
  DIAS              : Integer;
  CORREOS           : String(200);
  CONF_ALERTA_NIVEL : String(70);
}

entity CONSENTIMIENTO : cuid, managed {
  NOMBRE_CONSENTIMIENTO : String(100);
  ESTADO                : Integer;
}

entity CONSENTIMIENTO_TIPO : cuid, managed {
  NOMBRE_CONSENTIMIENTO_TIPO : String(255);
  ESTADO                     : Integer;
}

entity CONSENTIMIENTO_VERSION : cuid, managed {
  URL_DOCUMENTO          : String(1000);
  VERSION_CONSENTIMIENTO : Integer;
  INFORMACION_EXTRA      : String(1000);
  DESDE                  : Date;
  HASTA                  : Date;
  ID_CONSENTIMIENTO      : String(70);
}

entity CONTROL : cuid, managed {
  NOMBRE                 : String(255)   @title: 'Nombre del Control'       @mandatory;
  CONTROL_CLAVE          : Boolean       @title: 'Control Clave';
  DESCRIPCION_CONTROL    : String(1000)  @title: 'Descripción del Control'  @mandatory;
  RESPONSABLE            : String(255)   @title: 'Responsable';
  EJECUTOR               : String(255)   @title: 'Ejecutor';
  EVIDENCIA_CONTROL      : String(255)   @title: 'Evidencia del Control';
  PERIOCIDAD_OPORTUNIDAD : String(255)   @title: 'Periodicidad/Oportunidad';
  OBSERVACIONES          : String(1000)  @title: 'Observaciones';
  COBERTURA_CONTROL      : String(255)   @title: 'Cobertura del Control';
  OPORTUNIDAD_CONTROL    : String(255)   @title: 'Oportunidad del Control';
  SEGREGACION_FUNCIONAL  : String(255)   @title: 'Segregación Funcional';
  DONDE_EVIDENCIA        : String(255)   @title: 'Dónde se Evidencia';
  DOCUMENTADO            : String(255)   @title: 'Documentado';
  AUTOMATIZACION         : Boolean       @title: 'Automatización';
  EFICIENCIA             : String(255)   @title: 'Eficiencia';
  FECHA_IMPLEMENTACION   : Date          @title: 'Fecha de Implementación';
  FECHA_ULTIMA_REVISION  : Date          @title: 'Fecha de Última Revisión';
  RIESGO_ID              : String(70);
  EVALUACION_ID          : String(70);
}

entity CREAR_ALERTA : cuid {
  TIPO_ALERTA               : TipoAlertas;
  TIPO_DOCUMENTO            : TipoDoc;
  NIVEL_ALERTA              : Integer;
  CREAR_ALERTA_DIAS_CORREOS : String(70);
}

entity CREAR_ALERTA_DIAS_CORREOS : cuid {
  DIAS         : String(100);
  CORREOS      : String(100);
  CREAR_ALERTA : String(70);
}

entity CREDENCIALES : cuid, managed {
  TIPO_AUTH : String(255);
  TOKEN     : String(255);
  URI       : String(255);
  USUARIO   : String(255);
  CLAVE     : String(255);
}

entity DASHBOARD_ALERTA : cuid {
  FECHA               : Date       @title: 'Fecha';
  TIPO_ALERTA         : TipoAlerta @title: 'Tipo de Alerta';
  TOTAL_ALERTA        : Integer    @title: 'Total Alertas';
  ALERTAS_EXITOSAS    : Integer    @title: 'Alertas Exitosas';
  ALERTAS_FALLIDAS    : Integer    @title: 'Alertas Fallidas';
  ACCIONES_EJECUTADAS : Integer    @title: 'Acciones Ejecutadas';
}

entity DENUNCIA : cuid, managed {
  ASUNTO            : String(255);
  SOLICITUD_INICIAL : String(100);
  RESPUESTA_EMPRESA : String(100);
  FORM_SUB_DOC      : String(70);
  USUARIO           : String(70);
  TIPO_DENUNCIA     : String(70);
  FORMULARIO        : String(70);
}

entity DESTINATARIO_ALERTA : cuid, managed {
  TIPO_ALERTA : String(100)          @title: 'Tipo de Alerta'      @mandatory;
  CORREO      : String(255)          @title: 'Correo Electrónico'  @mandatory;
  NOMBRE      : String(255)          @title: 'Nombre del Destinatario';
  ACTIVO      : Boolean default true @title: 'Activo';
}

entity DOCUMENTACION : cuid, managed {
  ARCHIVO_ADJUNTO : String(5000);
  DOCUMENTACION   : String(70);
}

entity DOCUMENTO_RAT : cuid, managed {
  RAT_ID           : String(50);
  DOC_TYC          : String(50);
  NOMBRE_DOCUMENTO : String(255)  @title: 'Nombre del Documento'  @mandatory;
  TIPO_DOCUMENTO   : String(100)  @title         : 'Tipo de Documento';
  DESCRIPCION      : String(1000) @title         : 'Descripción';
  FECHA_CREACION   : Date         @title         : 'Fecha de Creación';
  FECHA_VIGENCIA   : Date         @title         : 'Fecha de Vigencia';
  ESTADO           : String(50)   @title         : 'Estado';
  VERSION          : String(50)   @title         : 'Versión';
  CONTENIDO        : LargeBinary  @Core.MediaType: 'mimeType';
  MIMETYPE         : String;
}

entity DOCUMENTOS_TYC : cuid, managed {
  NOMBRE         : String(255)  @title: 'Nombre'  @mandatory;
  TIPO_DOCUMENTO : String(255)  @title: 'Tipo de Documento';
  DOCUMENTO      : String(255)  @title: 'Documento';
  ESTADO         : Integer      @title: 'Estado';
  VERSION        : String(50)   @title: 'Versión';
  AUTOR          : String(255)  @title: 'Autor';
}

entity EJECUCION_ACCION : cuid, managed {
  NOTIFICATION_ID  : String(100)  @title: 'ID de Notificación';
  ACCION_ID        : String(100)  @title: 'ID de Acción';
  PARAMETROS_JSON  : LargeString  @title: 'Parámetros de Ejecución';
  RESULTADO        : String(1000) @title: 'Resultado';
  ESTADO_EJECUCION : String(50)   @title: 'Estado';
  ERROR_DETALLE    : String(1000) @title: 'Detalle del Error';
  USUARIO          : String(50);
}

entity ENVIO_DE_FORMULARIO : cuid, managed {
  CONTEXTO     : TipoFormulario;
  TIPO_ENVIO   : TipoEnvioFormulario;
  VERSION_FORM : String(70);
  DENUNCIA     : String(70);
  RESPUESTAS   : String(70);
}

entity ENVIO_FORMULARIO_CAPACITACION : cuid, managed {
  CAPACITACION     : String(70);
  ENVIO_FORMULARIO : String(70);
  ASISTENTE        : String(70);
}

entity ENVIO_FORMULARIO_DENUNCIA : cuid, managed {
  TIPO_ARCO        : TipoArco;
  DENUNCIA         : String(70);
  ENVIO_FORMULARIO : String(70);
}

entity ENVIO_FORMULARIO_RAT : cuid, managed {
  RAT              : String(70);
  ENVIO_FORMULARIO : String(70);
}

entity ENVIO_FORMULARIO_SOLICITUD : cuid, managed {
  TIPO_ARCO        : TipoArco;
  ENVIO_FORMULARIO : String(70);
  SOLICITUD        : String(70);
}

entity EVALUACION : cuid, managed {
  EVALUADOR     : String(255)   @title: 'Evaluador'            @mandatory;
  EVALUACION    : String(255)   @title: 'Evaluación';
  FECHA         : Date          @title: 'Fecha de Evaluación'  @mandatory;
  OBSERVACIONES : String(1000)  @title: 'Observaciones';
  PUNTUACION    : Decimal(5, 2) @title: 'Puntuación';
  CONTROL       : String(70);
}

entity FORM_SUBMISSION_DOC : cuid, managed {
  CONTEXT      : TipoFormulario;
  TIPO_ENVIO   : TipoEnvioFormulario;
  ESTADO       : EstadoFormulario default 'ACTIVO';
  IDX_A        : String(255);
  IDX_B        : String(255);
  IDX_C        : String(255);
  DATA_JSON    : LargeString;
  TAGS         : String(500);
  FORM_SUB_DOC : String(70);

}

entity FORM_SUBMISSION_FILE : cuid, managed {
  FILENAME     : String(255);
  CONTENT      : LargeBinary @Core.MediaType: 'mimeType';
  mimeType     : String(100);
  NOTE         : String(500);
  FORM_SUB_DOC : String(70);
}

entity FORM_TEMPLATE_DOC : cuid, managed {
  NAME         : String(100) @mandatory;
  DESCRIPTION  : String(500);
  CONTEXT      : TipoFormulario;
  CATEGORY     : CategoriaFormulario;
  VERSION      : String(20) default '1.0';
  STATUS       : EstadoVersionFormulario default 'ACTIVA';
  ACTIVE       : Boolean default true;
  SCHEMA_JSON  : LargeString;
  UI_JSON      : LargeString;
  TAGS         : String(500);
  TIPO_ARCO    : TipoArco;
  FORM_SUB_DOC : String(70);
}

entity FORMULARIO : cuid, managed {
  NOMBRE_FORM : String(80);
  DESCRIPCION : String(255);
  ESTADO      : EstadoFormulario;
  TIPO        : TipoFormulario;
  CATEGORIA   : CategoriaFormulario;
  VERSIONES   : String(70);
}

entity IMPACTO : cuid, managed {
  NOMBRE       : String(255)  @title: 'Nombre'  @mandatory;
  PUNTAJE      : Integer      @title: 'Puntaje';
  COLOR_PICKER : String(50)   @title: 'Color';
  DESCRIPCION  : String(500)  @title: 'Descripción';
}

entity JOB_ALERTA : cuid, managed {
  NOMBRE_JOB         : String(255)          @title: 'Nombre del Job'  @mandatory;
  DESCRIPCION        : String(1000)         @title: 'Descripción';
  TIPO_ALERTA        : TipoAlerta           @title: 'Tipo de Alerta'  @mandatory;
  CRON_EXPRESION     : String(100)          @title: 'Expresión Cron'  @mandatory;
  ACTIVO             : Boolean default true @title: 'Activo';
  ESTADO             : EstadoJob            @title: 'Estado';
  ULTIMA_EJECUCION   : Timestamp            @title: 'Última Ejecución';
  PROXIMA_EJECUCION  : Timestamp            @title: 'Próxima Ejecución';
  DIAS_ANTICIPACION  : Integer              @title: 'Días de Anticipación';
  CONFIGURACION_JSON : LargeString          @title: 'Configuración JSON';
  SCHEDULER_JOB_ID   : String(100)          @title: 'ID Job Scheduler';
  SCHEDULER_JOB_NAME : String(255)          @title: 'Nombre Job Scheduler';
}

entity JOB_ALERTA_SIMPLE : cuid, managed {
  NOMBRE_JOB       : String(255)          @title: 'Nombre del Job';
  TIPO_ALERTA      : TipoAlerta           @title: 'Tipo de Alerta';
  ACTIVO           : Boolean default true @title: 'Activo';
  ESTADO           : EstadoJob            @title: 'Estado';
  ULTIMA_EJECUCION : Timestamp            @title: 'Última Ejecución';
}

entity LOG_EJECUCION : cuid, managed {
  FECHA_INICIO      : Timestamp    @title: 'Fecha de Inicio';
  FECHA_FIN         : Timestamp    @title: 'Fecha de Fin';
  ESTADO            : String(50)   @title: 'Estado';
  ALERTAS_GENERADAS : Integer      @title: 'Alertas Generadas';
  MENSAJE_ERROR     : String(1000) @title: 'Mensaje de Error';
  EJECUTADO_MANUAL  : Boolean      @title: 'Ejecutado Manualmente';
  DETALLES_JSON     : LargeString  @title: 'Detalles JSON';
  JOB_ALERTA        : String(50);
  USUARIO           : String(50);
}

entity LOG_SIMPLE : cuid, managed {
  ESTADO            : String(50)   @title: 'Estado';
  ALERTAS_GENERADAS : Integer      @title: 'Alertas Generadas';
  MENSAJE           : String(1000) @title: 'Mensaje';
  JOB_ALERTA_SIMPLE : String(50);
}

entity MATRIZ_SEVERIDAD : cuid, managed {
  VALOR_SEVERIDAD : Integer     @title: 'Valor de Severidad';
  RI              : Integer     @title: 'RI';
  COLOR_PICKER    : String(50)  @title: 'Color';
  DESCRIPCION     : String(500) @title: 'Descripción';
  IMPACTO         : String(70);
  PROBABILIDAD    : String(70);
  RIESGO_RESIDUAL : String(70);
}

entity NOTIFICACION_CAPACITACION : cuid, managed {
  NOTIFICADO : Boolean;
  ASISTENCIA : String(70);
}

entity OPCIONES_CAMPO : cuid, managed {
  VALOR            : String(255);
  ORDEN            : Integer;
  CAMPO_FORMULARIO : String(70);
}

entity PARAMETRO : cuid, managed {
  NOMBRE_CAMPO    : String(255)          @assert.notNull;
  TIPO_CAMPO      : String(50)           @assert.notNull;
  DESCRIPCION     : String(1000);
  INPUT           : Boolean default true @assert.notNull;
  ORDEN           : Integer default 0;
  SERVICIO        : String(70);
  PARAMETRO_PADRE : String(70);
}

entity PERSONALIZACION : cuid, managed {
  TITULO              : String(255);
  BANNER              : String(255);
  LOGO                : String(255);
  DETALLES            : String(255);
  FECHA_CREACION      : Date;
  FECHA_ACTUALIZACION : Date;
  VERSION_ACTUAL      : Integer;
}

entity PROBABILIDAD : cuid, managed {
  NOMBRE       : String(255)  @title: 'Nombre'  @mandatory;
  PUNTAJE      : Integer      @title: 'Puntaje';
  COLOR_PICKER : String(50)   @title: 'Color';
  DESCRIPCION  : String(500)  @title: 'Descripción';
}

entity PROCEDIMIENTOS_ARCHIVO : cuid, managed {
  NOMBRE      : String(255)  @title: 'Nombre'  @mandatory;
  PESO        : String(255)  @title: 'Peso';
  EXTENSION   : String(255)  @title: 'Extension';
  CODIGO      : String(255)  @title: 'Codigo';
  RAT_ID      : String(255)  @title: 'Rat_id';
  CARPETA     : String(255)  @title: 'Carpeta';
  DESCRIPCION : String(255)  @title: 'Descripción';
  RESPONSABLE : String(255)  @title: 'Responsable';
}

entity PROCEDIMIENTOS_CARPETA : cuid, managed {
  NOMBRE : String(255)  @title: 'Nombre'  @mandatory;
  NIVEL  : String(255)  @title: 'Nivel';
  PADRE  : String(255)  @title: 'Padre';
  ORDEN  : String(255)  @title: 'Orden';
}

entity PROPOSITO : cuid, managed {
  NOMBRE       : String(255);
  DESCRIPCION  : String(255);
  PLAZO_GLOBAL : Integer;
  ACTIVO       : Boolean default true @title: 'Activo';
  RAT_ID       : String(70);
}

entity RAT : cuid, managed {
  NOMBRE_RAT                       : String(255)     @title: 'Nombre del RAT'                                     @mandatory;
  RESPONSABLE_RAT                  : String(255)     @title: 'Responsable'                                        @mandatory;
  DESCRIPCION_RAT                  : String(1000)    @title: 'Descripción'                                        @mandatory;
  FINALIDAD_TRATAMIENTO            : String(500)     @title: 'Finalidad del Tratamiento'                          @mandatory;
  BASE_LEGAL_PROC_DATOS_PERSONALES : String(500)     @title: 'Base Legal para Procesamiento de Datos Personales'  @mandatory;
  BASE_LEGAL_PROC_DATOS_ESPECIALES : String(500)     @title: 'Base Legal para Procesamiento de Datos Especiales';
  INTERESES_LEGITIMOS_PROC         : String(500)     @title: 'Intereses Legítimos para Procesamiento Descripción';
  FECHA_CREACION                   : Date            @title: 'Fecha de Creación';
  FECHA_ACTUALIZACION              : Date            @title: 'Fecha de Actualización';
  ESTADO                           : EstadoGeneral   @title: 'Estado';
  PROCESO_OPERACIONAL              : POperacional    @title: 'Proceso Operacional';
  CONSERVACION                     : String(250)     @title: 'Programa de Conservación del conjunto de datos';
  ENLACE_INTERESES                 : String(250)     @title: 'Enlace al registro de evaluación de intereses legítimos';
  DIAS                             : Integer;
  MESES                            : Integer;
  ANIOS                            : Integer;
  INTERES_LEGITIMO                 : InteresLegitimo @title: 'Aplica y no aplica';
  JUSTIFICACION_BASE_LEGAL         : String(255);
  FORM_TEMPLATE_DOC                : String(70);
  FORM_SUB_DOC                     : String(70);
}

entity RAT_BASE_ESPECIAL : cuid {
  RAT  : String(70);
  BASE : String(70);
}

entity RAT_BASE_PERSONAL : cuid {
  RAT  : String(70);
  BASE : String(70);
}

entity RAT_DPO : cuid {
  NOMBRE             : String(100);
  RUT                : String(100);
  CORREO             : String(100);
  TELEFONO           : String(100);
  NOMBRE_CONTROLADOR : String(100);
  RAT_ID             : String(70);
}

entity RAT_EIPD : cuid {
  EVALUACION  : Evaluacion;
  DESCRIPCION : String(200);
  PROGRESO    : String(200);
  ENLACE      : String(200);
  RAT_ID      : String(70);
}

entity RAT_INFO_DATOS_INTERESADOS : cuid {
  CATEGORIA_DATOS         : String(255);
  CATEGORIA               : String(255);
  CATEGORIA_DESTINATARIOS : String(255);
  DATOS                   : String(255);
  DERECHOS_DISPONIBLES    : DerechosDisponibles;
  FUENTE                  : String(255);
  UBICACION               : String(255);
  RAT_ID                  : String(70);
}

entity RAT_MEDIDAS_SEGURIDAD : cuid {
  DESCRIPCION          : String(255);
  ENLACE_CONTRATO      : String(255);
  JURISDICCIONES_NOAUT : String(255);
  SALVAGUARDIAS        : String(255);
  DECISIONES           : String(255);
  RAT_ID               : String(70);
}

entity RAT_RESPONSABLE : cuid {
  NOMBRE_RESPONSABLE : String(100);
  RUT                : String(50);
  CORREO_PERSONAL    : String(200);
  TELEFONO           : String(200);
  DIRECCION_DERECHOS : String(200);
  DESCRIPCION_CARGO  : String(200);
  CORRESPONSABLES    : String(200);
  RAT_ID             : String(50); // debería ir a usuario ?
}

entity REGISTRO_ALERTA : cuid, managed {
  NOTIFICATION_TYPE : TipoAlerta            @title: 'Tipo de Notificación';
  RECIPIENTS_JSON   : LargeString           @title: 'Destinatarios JSON';
  DATA_JSON         : LargeString           @title: 'Datos JSON';
  PRIORIDAD         : PrioridadNotificacion @title: 'Prioridad';
  ENTIDAD_ORIGEN    : String(100)           @title: 'Entidad Origen';
  ID_ENTIDAD_ORIGEN : String(36)            @title: 'ID Entidad Origen';
  ENVIADO_EXITOSO   : Boolean               @title: 'Enviado Exitoso';
  ERROR_ENVIO       : String(1000)          @title: 'Error de Envío';
  NOTIFICATION_ID   : String(100)           @title: 'ID Notificación BWZ';
  JOB_ALERTA        : String(50);
  LOG_EJECUCION     : String(50);
}

entity RESPUESTA_CAMPO : cuid, managed {
  VALOR_TEXTO      : LargeString;
  VALOR_NUMERO     : Decimal(15, 2);
  VALOR_FECHA      : Timestamp;
  VALOR_BOOLEAN    : Boolean;
  VALOR_ADJUNTO    : LargeBinary @Core.MediaType: 'mimeType';
  MIMETYPE         : String(70);
  ENVIO_FORMULARIO : String(70);
}

entity RESPUESTA_CAMPO_MULTIPLE : cuid, managed {
  VALOR_OPCION       : String(255);
  OPCIONES_MULTIPLES : String(70);
}

entity RIESGO : cuid, managed {
  NOMBRE                    : String(255)   @title: 'Nombre del Riesgo'       @mandatory;
  DESCRIPCION               : String(1000)  @title: 'Descripción del Riesgo'  @mandatory;
  ESTRATEGIA_ADMINISTRACION : String(255)   @title: 'Estrategia de Administración';
  CAUSA_RIESGO              : String(255)   @title: 'Causa del Riesgo';
  OBSERVACION               : String(1000)  @title: 'Observación';
  EVENTO_RIESGO             : String(255)   @title: 'Evento de Riesgo';
  FECHA_IDENTIFICACION      : Date          @title: 'Fecha de Identificación';
  FECHA_EVALUACION          : Date          @title: 'Fecha de Evaluación';
  RAT_ID                    : String(50);
  CONTROL                   : String(70);
}

entity RIESGO_RESIDUAL : cuid, managed {
  NIVEL_RIESGO   : String(255)  @title: 'Nivel de Riesgo'  @mandatory;
  RANGO_INFERIOR : Integer      @title: 'Rango Inferior';
  RANGO_SUPERIOR : Integer      @title: 'Rango Superior';
  COLOR_PICKER   : String(50)   @title: 'Color';
  DESCRIPCION    : String(500)  @title: 'Descripción';
}

entity ROL_EMPRESA : cuid, managed {
  NOMBRE_ROL   : String(255)  @title: 'Nombre del Rol'  @mandatory;
  DESCRIPCION  : String(500)  @title: 'Descripción';
  DEPARTAMENTO : String(255)  @title: 'Departamento';
  ACTIVO       : Boolean      @title: 'Activo';
}

entity ROL_RACI : cuid, managed {
  RESPONSABLE : Boolean      @title: 'Responsable (R)';
  APROBADOR   : Boolean      @title: 'Aprobador (A)';
  CONSULTADO  : Boolean      @title: 'Consultado (C)';
  IINFORMADO  : Boolean      @title: 'Informado (I)';
  COMENTARIOS : String(1000) @title: 'Comentarios';
  ACTIVIDAD   : String(70);
  ROL_EMPRESA : String(70);
}

entity ROL : cuid, managed {
  NOMBRE_ROL  : String(100);
  DESCRIPCION : String(255);
}

entity ROL_USUARIO : managed {
  key ROL     : String(70);
  key USUARIO : String(70);
}

entity SERVICIO_SISTEMA : cuid, managed {
  NOMBRE        : String(255) @assert.notNull;
  DESCRIPCION   : String(1000);
  TIPO_SERVICIO : String(100);
  METODO        : String(10) default 'GET';
  PATH          : String(500) @assert.notNull;
  HOST          : String(255) @assert.notNull;
  ESTADO        : Boolean default true;
  TIPO_LLAMADO  : String(1) default 'C';
  SISTEMA       : String(70);
  PARAMETRO     : String(70);
}

entity SISTEMA : cuid, managed {
  NOMBRE           : String(255);
  DESCRIPCION      : String(255);
  ESTADO           : Integer;
  CREDENCIALES     : String(70);
  SERVICIO_SISTEMA : String(70);
}

entity SOLICITUD : cuid, managed {
  CRITICIDAD                 : Criticidad;
  PLAZO                      : String(300);
  ESTADO                     : String(50) default 'Pendiente';
  VERSION_FORMULARIO         : String(50);
  PROPOSITO                  : String(50);
  USUARIO                    : String(50);
  FORMULARIO                 : String(50);
  ENVIO_FORMULARIO_SOLICITUD : String(50);
  FORM_SUB_DOC               : String(70);
}

entity SUBTIPO_RIESGO : cuid, managed {
  NOMBRE      : String(255)          @title: 'Nombre'  @mandatory;
  DESCRIPCION : String(1000)         @title: 'Descripción';
  ACTIVO      : Boolean default true @title: 'Activo';
  TIPO_RIESGO : String(70);
}

entity SUSCRIPTOR_JOB : cuid, managed {
  ACTIVO            : Boolean default true @title: 'Activo';
  NOTIFICAR_ERRORES : Boolean default true @title: 'Notificar Errores';
  JOB_ALERTA        : String(50);
  USUARIO_ID        : String(50);
}

entity TIPO_DENUNCIA : cuid, managed {
  NOMBRE_TIPO : String(80);
  ACTIVO      : Boolean;
}

entity TIPO_RIESGO : cuid, managed {
  NOMBRE      : String(255)          @title: 'Nombre'  @mandatory;
  DESCRIPCION : String(1000)         @title: 'Descripción';
  ACTIVO      : Boolean default true @title: 'Activo';
}

entity USUARIO : cuid, managed {
  @unique RUT  : String(20);
  NOMBRE       : String(100);
  APELLIDOS    : String(100);
  AREA_TRABAJO : String(30);
  CORREO       : String(100);
  TELEFONO     : String(20);
  ACTIVO       : Boolean default true;
  FORM_SUB_DOC : String(70);
}

entity VERSION_FORMULARIO : cuid, managed {
  VERSION    : String(20);
  ESTADO     : EstadoVersionFormulario default 'BORRADOR';
  FORMULARIO : String(70);
}

entity VERSION_PERSONALIZACION : cuid, managed {
  VERSION            : Integer;
  ID_PERSONALIZACION : String(70);
}

entity TIPO_DOCUMENTO : cuid, managed {
  NOMBRE             : String(100);
  PLAZO_CONSERVACION : String(100);
  INICIO_VIGENCIA    : Date;
  FIN_VIGENCIA       : Date;
  UNIDAD_TIEMPO      : UnidadTiempo;

}

entity SISTEMA_FUENTE : cuid, managed {
  NOMBRE : String(100);
}

entity PROCESO_SISTEMA : cuid, managed {
  SISTEMA        : String(100);
  PROCESO_NOMBRE : String(100);
  LLAVE_PUBLICA  : String(100);
  NOMBRE         : String(100);
}

entity PROPIEDAD_ADICIONAL : cuid, managed {
  LLAVE          : String(100);
  VALOR          : String(200);
  DESTINATION_ID : String(70);
}

entity DESTINATION : cuid, managed {
  NOMBRE             : String(100);
  URL                : String(100);
  TIPO_CONEXION      : String(100);
  UBICACION          : String(100);
  TIPO_AUTENTICACION : String(100);
  USUARIO_AUTH       : String(100);
  PASS_AUTH          : String(100);
  SISTEMA_EXTERNO_ID : String(100);
}

entity SISTEMA_EXTERNO : cuid, managed {
  NOMBRE      : String(100);
  DESCRIPCION : String(100);
  ESTADO      : String(100);
}

entity SERVICIO : cuid, managed {
  NOMBRE             : String(100);
  ENDPOINT           : String(100);
  DESCRIPCION        : String(100);
  METODO             : String(100);
  ESTADO             : String(100);
  TIPO_ARSO          : String(100);
  SISTEMA_EXTERNO_ID : String(100);
  DESTINATION_ID     : String(100);
}

entity SERVICIO_PARAMETRO : cuid, managed {
  NOMBRE_CAMPO    : String(100);
  TIPO_CAMPO      : String(100);
  DESCRIPCION     : String(100);
  OBLIGATORIO     : String(100);
  PARAMETRO_PADRE : String(100);
  SERVICIO_ID     : String(100);
}
