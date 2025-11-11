using {db} from '../db/schema';

service MyService {

  entity Form_Template_Doc             as projection on db.FORM_TEMPLATE_DOC;

  entity Form_Submission_File          as
    projection on db.FORM_SUBMISSION_FILE {
      *,
      submission : Association to one Form_Submission_Doc
                     on submission.ID = FORM_SUB_DOC
    };

  entity Job_Alerta_Simple             as projection on db.JOB_ALERTA_SIMPLE;

  entity Log_Simple                    as
    projection on db.LOG_SIMPLE {
      *,
      job_alerta_simple : Association to one Job_Alerta_Simple
                            on job_alerta_simple.ID = JOB_ALERTA_SIMPLE,
    };

  entity Alerta_Simple                 as
    projection on db.ALERTA_SIMPLE {
      *
    };

  entity Destinatario_Alerta           as
    projection on db.DESTINATARIO_ALERTA {
      *
    };

  entity Suscriptor_Job                as
    projection on db.SUSCRIPTOR_JOB {
      *,
      job     : Association to one Job_Alerta
                  on job.ID = JOB_ALERTA,
      usuario : Association to one Usuario
                  on usuario.ID = USUARIO_ID
    };

  entity Log_Ejecucion                 as
    projection on db.LOG_EJECUCION {
      *,
      job     : Association to one Job_Alerta
                  on job.ID = JOB_ALERTA,
      usuario : Association to one Usuario
                  on usuario.ID = USUARIO
    };

  entity Registro_Alerta               as
    projection on db.REGISTRO_ALERTA {
      *,
      job           : Association to one Job_Alerta
                        on job.ID = JOB_ALERTA,
      log_ejecucion : Association to one Log_Ejecucion
                        on log_ejecucion.ID = LOG_EJECUCION
    };

  entity Accion_Notificacion           as projection on db.ACCION_NOTIFICACION;

  entity Ejecucion_Accion              as
    projection on db.EJECUCION_ACCION {
      *,
      usuario : Association to one Usuario
                  on usuario.ID = USUARIO
    };

  entity Dashboard_Alerta              as projection on db.DASHBOARD_ALERTA;

  entity Opciones_Campo                as projection on db.OPCIONES_CAMPO;

  entity Respuesta_Campo_Multiple      as projection on db.RESPUESTA_CAMPO_MULTIPLE;

  entity Denuncia                      as
    projection on db.DENUNCIA {
      *,
      usuario          : Association to one Usuario
                           on usuario.ID = USUARIO,
      tipo_denuncia    : Association to one Tipo_Denuncia
                           on tipo_denuncia.ID = TIPO_DENUNCIA,
      formulario       : Association to one Formulario
                           on formulario.ID = FORMULARIO,
      envio_cliente    : Association to many Envio_De_Formulario
                           on  envio_cliente.DENUNCIA   = ID
                           and envio_cliente.TIPO_ENVIO = SOLICITUD_INICIAL,
      envios_respuesta : Association to many Envio_De_Formulario
                           on  envios_respuesta.DENUNCIA   = ID
                           and envios_respuesta.TIPO_ENVIO = RESPUESTA_EMPRESA
    };

  entity Tipo_Denuncia                 as projection on db.TIPO_DENUNCIA;

  entity Envio_Formulario_Rat          as
    projection on db.ENVIO_FORMULARIO_RAT {
      *,
      rat             : Association to one Rat
                          on rat.ID = RAT,
      envioFormulario : Association to one Envio_De_Formulario
                          on envioFormulario.ID = ENVIO_FORMULARIO
    };

  entity Envio_Formulario_Capacitacion as
    projection on db.ENVIO_FORMULARIO_CAPACITACION {
      *,
      capacitacion     : Association to one Capacitacion
                           on capacitacion.ID = CAPACITACION,
      envio_formulario : Association to one Envio_De_Formulario
                           on envio_formulario.ID = ENVIO_FORMULARIO,
      asistente        : Association to one Asistencia
                           on asistente.ID = ASISTENTE
    };

  entity Envio_Formulario_Solicitud    as
    projection on db.ENVIO_FORMULARIO_SOLICITUD {
      *,
      envio_formulario : Association to one Envio_De_Formulario
                           on envio_formulario.ID = ENVIO_FORMULARIO,
      solicitud        : Association to one Solicitud
                           on solicitud.ID = SOLICITUD
    };

  entity Envio_Formulario_Denuncia     as
    projection on db.ENVIO_FORMULARIO_DENUNCIA {
      *,
      denuncia         : Association to one Denuncia
                           on denuncia.ID = DENUNCIA,
      envio_formulario : Association to one Envio_De_Formulario
                           on envio_formulario.ID = ENVIO_FORMULARIO,
    };

  entity Solicitud                     as
    projection on db.SOLICITUD {
      *,
      version_formulario   : Association to one Version_Formulario
                               on version_formulario.ID = VERSION_FORMULARIO,
      proposito            : Association to one Proposito
                               on proposito.ID = PROPOSITO,
      usuario              : Association to one Usuario
                               on usuario.ID = USUARIO,
      formulario           : Association to one Formulario
                               on formulario.ID = FORMULARIO,
      envio_form_solicitud : Association to many Envio_Formulario_Solicitud
                               on envio_form_solicitud.ID = ENVIO_FORMULARIO_SOLICITUD
    };

  entity Credenciales                  as projection on db.CREDENCIALES;

  entity Sistema                       as
    projection on db.SISTEMA {
      *,
      NavCredenciales : Association to many Credenciales
                          on NavCredenciales.ID = CREDENCIALES,
      NavServicios    : Association to many Servicio_Sistema
                          on NavServicios.ID = SERVICIO_SISTEMA
    };

  entity Servicio_Sistema              as
    projection on db.SERVICIO_SISTEMA {
      *,
      sistema   : Association to one Sistema
                    on sistema.ID = SISTEMA,
      parametro : Association to many Parametro
                    on parametro.SERVICIO = PARAMETRO
    };

  entity Campos                        as
    projection on db.CAMPOS {
      *,
      proposito : Association to one Proposito
                    on proposito.ID = PROPOSITO,
      sistema   : Association to many Sistema
                    on sistema.ID = SISTEMA,
      parametro : Association to many Parametro
                    on parametro.ID = PARAMETRO
    };

  entity Proposito                     as
    projection on db.PROPOSITO {
      *,
      rat_id        : Association to one Rat
                        on rat_id.ID = RAT_ID,
      NavCamposPool : Association to many Campos
                        on NavCamposPool.PROPOSITO = ID
    };

  entity Usuario                       as
    projection on db.USUARIO {
      *,
      roles : Association to many Rol_Usuario
                on roles.USUARIO = ID
    };

  entity Rol                           as
    projection on db.ROL {
      *,
      usuarios : Association to many Rol_Usuario
                   on usuarios.ROL = ID
    };

  entity Rol_Usuario                   as
    projection on db.ROL_USUARIO {
      *,
    // rol : Association to one Roles on rol.ROL = ID,
    // usuario : Association to one Usuario on usuario.USUARIO = ID
    };

  entity Notificacion_Capacitacion     as
    projection on db.NOTIFICACION_CAPACITACION {
      *,
      asistencia : Association to one Asistencia
                     on asistencia.ASISTENCIA = ID
    };

  entity Documentacion                 as
    projection on db.DOCUMENTACION {
      *,
      capacitacion : Association to one Capacitacion
                       on capacitacion.ASISTENCIA = ID
    };

  entity Personalizacion               as
    projection on db.PERSONALIZACION {
      *,
      version_personalizacion : Association to many Version_Personalizacion
                                  on version_personalizacion.ID_PERSONALIZACION = ID
    };

  entity Version_Personalizacion       as projection on db.VERSION_PERSONALIZACION;

  entity Documento_Rat                 as
    projection on db.DOCUMENTO_RAT {
      *,
      rat_id  : Association to one Rat
                  on rat_id.ID = RAT_ID,
      doc_tyc : Association to one Documento_Rat
                  on doc_tyc.ID = DOC_TYC
    };

  entity Brecha                        as
    projection on db.BRECHA {
      *,
      rat_id : Association to one Rat
                 on rat_id.ID = RAT_ID
    };

  entity Subtipo_Riesgo                as projection on db.SUBTIPO_RIESGO;

  entity Evaluacion                    as
    projection on db.EVALUACION {
      *,
      control_id : Association to one Control
                     on control_id.ID = CONTROL
    };

  entity Impacto                       as projection on db.IMPACTO;

  entity Probabilidad                  as projection on db.PROBABILIDAD;

  entity Matriz_Severidad              as
    projection on db.MATRIZ_SEVERIDAD {
      *,
      impacto         : Association to one Impacto
                          on impacto.ID = IMPACTO,
      probabilidad    : Association to one Probabilidad
                          on probabilidad.ID = PROBABILIDAD,
      riesgo_residual : Association to one Riesgo_Residual
                          on riesgo_residual.ID = RIESGO_RESIDUAL
    };

  entity Riesgo_Residual               as projection on db.RIESGO_RESIDUAL;

  entity Rol_Raci                      as
    projection on db.ROL_RACI {
      *,
      actividad   : Association to one Actividad
                      on actividad.ID = ACTIVIDAD,
      rol_empresa : Association to one Rol_Empresa
                      on rol_empresa.ID = ROL_EMPRESA
    };

  entity Rol_Empresa                   as projection on db.ROL_EMPRESA;

  entity Documentos_Tyc                as projection on db.DOCUMENTOS_TYC;

  entity Procedimientos_Archivo        as projection on db.PROCEDIMIENTOS_ARCHIVO;

  entity Procedimientos_Carpeta        as projection on db.PROCEDIMIENTOS_CARPETA;

  entity Base_Licitud                  as
    projection on db.BASE_LICITUD {
      *,
      rat_base_personal : Association to many Rat_Base_Personal
                            on rat_base_personal.BASE = RAT_BASE_PERSONAL,
      rat_base_especial : Association to many Rat_Base_Especial
                            on rat_base_especial.BASE = RAT_BASE_ESPECIAL
    };

  entity Rat_Base_Personal             as
    projection on db.RAT_BASE_PERSONAL {
      *,
      rat  : Association to one Rat
               on rat.ID = RAT,
      base : Association to one Base_Licitud
               on base.ID = BASE
    };

  entity Rat_Base_Especial             as
    projection on db.RAT_BASE_ESPECIAL {
      *,
      rat  : Association to one Rat
               on rat.ID = RAT,
      base : Association to one Base_Licitud
               on base.ID = BASE
    };

  entity Consentimiento_Tipo           as projection on db.CONSENTIMIENTO_TIPO;

  entity Consentimiento_Version        as
    projection on db.CONSENTIMIENTO_VERSION {
      *,
      consentimiento : Association to one Consentimiento
                         on consentimiento.ID = ID_CONSENTIMIENTO
    };

  entity Rat_Responsable               as
    projection on db.RAT_RESPONSABLE {
      *,
      rat_id : Association to many Rat_Responsable
                 on rat_id.ID = RAT_ID
    };

  entity Rat_Dpo                       as
    projection on db.RAT_DPO {
      *,
      rat_id : Association to many Rat_Responsable
                 on rat_id.ID = RAT_ID
    };

  entity Rat_Info_Datos_Interesados    as
    projection on db.RAT_INFO_DATOS_INTERESADOS {
      *,
      rat_id : Association to many Rat_Responsable
                 on rat_id.ID = RAT_ID
    };

  entity Rat_Medidas_Seguridad         as
    projection on db.RAT_MEDIDAS_SEGURIDAD {
      *,
      rat_id : Association to many Rat_Responsable
                 on rat_id.ID = RAT_ID
    };

  entity Rat_Eipd                      as
    projection on db.RAT_EIPD {
      *,
      rat_id : Association to many Rat_Responsable
                 on rat_id.ID = RAT_ID
    };

  entity Crear_Alerta                  as
    projection on db.CREAR_ALERTA {
      *,
      alerta_dias : Association to many Crear_Alerta_Dias_Correos
                      on alerta_dias.CREAR_ALERTA = ID
    };

  entity Crear_Alerta_Dias_Correos     as
    projection on db.CREAR_ALERTA_DIAS_CORREOS {
      *,
      alerta : Association to one Crear_Alerta
                 on alerta.ID = CREAR_ALERTA
    };

  entity Configuracion_Alerta          as
    projection on db.CONFIGURACION_ALERTA {
      *,
      riesgo        : Association to one Riesgo
                        on riesgo.ID = RIESGO,
      rat           : Association to one Rat
                        on rat.ID = RAT,
      tipo_denuncia : Association to one Tipo_Denuncia
                        on tipo_denuncia.ID = TIPO_DENUNCIA,
    };

  entity Configuracion_Alerta_Nivel    as
    projection on db.CONFIGURACION_ALERTA_NIVEL {
      *,
      config_alerta : Association to one Configuracion_Alerta
                        on config_alerta.ID = CONF_ALERTA_NIVEL
    };

  entity Alerta                        as
    projection on db.ALERTA {
      *,
      nivel : Association to one Configuracion_Alerta_Nivel
                on nivel.NIVEL = ID
    };

  entity Consentimiento                as
    projection on db.CONSENTIMIENTO {
      *,
      versions : Association to many Consentimiento_Version
                   on versions.ID_CONSENTIMIENTO = ID
    };

  entity Actividad                     as
    projection on db.ACTIVIDAD {
      *,
      roles  : Association to many Rol_Raci
                 on roles.ACTIVIDAD = ID,
      rat_id : Association to one Rat
                 on rat_id.ID = RAT_ID
    };

  entity Riesgo                        as
    projection on db.RIESGO {
      *,
      rat_id  : Association to one Rat
                  on rat_id.ID = RAT_ID,
      control : Association to many Control
                  on control.ID = CONTROL
    };

  entity Control                       as
    projection on db.CONTROL {
      *,
      evaluacion : Association to many Evaluacion
                     on evaluacion.ID = EVALUACION_ID,
      riesgo     : Association to one Riesgo
                     on riesgo.ID = RIESGO_ID
    };

  entity Tipo_Riesgo                   as
    projection on db.TIPO_RIESGO {
      *,
      subcategoria : Association to many Subtipo_Riesgo
                       on subcategoria.TIPO_RIESGO = ID
    };

  entity Rat                           as
    projection on db.RAT {
      *,
      documentos             : Association to many Documento_Rat
                                 on documentos.RAT_ID = ID,
      riesgos                : Association to many Riesgo
                                 on riesgos.RAT_ID = ID,
      brechas                : Association to many Brecha
                                 on brechas.RAT_ID = ID,
      actividades            : Association to many Actividad
                                 on actividades.RAT_ID = ID,
      responsables           : Association to one Rat_Responsable
                                 on responsables.RAT_ID = ID,
      dpo                    : Association to one Rat_Dpo
                                 on dpo.RAT_ID = ID,
      info_datos_interesados : Association to many Rat_Info_Datos_Interesados
                                 on info_datos_interesados.RAT_ID = ID,
      medidas_seguridad      : Association to many Rat_Medidas_Seguridad
                                 on medidas_seguridad.RAT_ID = ID,
      eipd                   : Association to one Rat_Eipd
                                 on eipd.RAT_ID = ID,
      form                   : Association to one Form_Template_Doc
                                 on form.ID = FORM_TEMPLATE_DOC
    };

  entity Asistencia                    as
    projection on db.ASISTENCIA {
      *,
      notificaciones : Association to many Notificacion_Capacitacion
                         on notificaciones.ASISTENCIA = ID
    };

  entity Capacitacion                  as
    projection on db.CAPACITACION {
      *,
      documentos : Association to many Documentacion
                     on documentos.DOCUMENTACION = ID,
      asistencia : Association to many Asistencia
                     on asistencia.ASISTENCIA = ID,
    };

  entity Parametro                     as
    projection on db.PARAMETRO {
      *,
      servicio        : Association to one Servicio_Sistema
                          on servicio.ID = SERVICIO,
      hijos           : Association to many Parametro
                          on hijos.PARAMETRO_PADRE = ID,
      parametro_padre : Association to one Parametro
                          on parametro_padre.ID = ID
    };

  entity Envio_De_Formulario           as
    projection on db.ENVIO_DE_FORMULARIO {
      *,
      respuestas   : Association to many Respuesta_Campo
                       on respuestas.ENVIO_FORMULARIO = ID,
      version_form : Association to one Version_Formulario
                       on version_form.ID = VERSION_FORM,
      denuncia     : Association to one Denuncia
                       on denuncia.ID = DENUNCIA
    };

  entity Respuesta_Campo               as
    projection on db.RESPUESTA_CAMPO {
      *,
      opciones_multiples : Association to many Respuesta_Campo_Multiple
                             on opciones_multiples.OPCIONES_MULTIPLES = ID
    };

  entity Formulario                    as
    projection on db.FORMULARIO {
      *,
      versions : Association to many Version_Formulario
                   on versions.FORMULARIO = ID
    };

  entity Version_Formulario            as
    projection on db.VERSION_FORMULARIO {
      *,
      fields : Association to many Campos_Formulario
                 on fields.VERSION = ID,
      parent : Association to one Formulario
                 on parent.VERSIONES = ID
    };

  entity Campos_Formulario             as
    projection on db.CAMPOS_FORMULARIO {
      *,
      options : Association to many Opciones_Campo
                  on options.CAMPO_FORMULARIO = ID
    };

  entity Job_Alerta                    as
    projection on db.JOB_ALERTA {
      *,
      suscriptores : Association to many Suscriptor_Job
                       on suscriptores.JOB_ALERTA = ID,
      ejecuciones  : Association to many Log_Ejecucion
                       on ejecuciones.JOB_ALERTA = ID,
    };

  entity Form_Submission_Doc           as
    projection on db.FORM_SUBMISSION_DOC {
      *,
      files            : Association to many Form_Submission_File
                           on files.FORM_SUB_DOC = ID,
      template         : Association to one Form_Template_Doc
                           on template.FORM_SUB_DOC = ID,
      solicitante      : Association to one Usuario
                           on solicitante.FORM_SUB_DOC = ID,
      ref_rat          : Association to one Rat
                           on ref_rat.FORM_SUB_DOC = ID,
      ref_capacitacion : Association to one Capacitacion
                           on ref_capacitacion.FORM_SUB_DOC = ID,
      ref_denuncia     : Association to one Denuncia
                           on ref_denuncia.FORM_SUB_DOC = ID,
      ref_solicitud    : Association to one Solicitud
                           on ref_solicitud.FORM_SUB_DOC = ID

    };

  entity Tipo_Documento                as projection on db.TIPO_DOCUMENTO;
  entity Sistema_Fuente                as projection on db.SISTEMA_FUENTE;
  entity Proceso_Sistema               as projection on db.PROCESO_SISTEMA;

  entity Propiedad_Adicional           as projection on db.PROPIEDAD_ADICIONAL;

  entity Destination                   as
    projection on db.DESTINATION {
      *,
      propiedad_adicional : Association to many Propiedad_Adicional
                              on propiedad_adicional.DESTINATION_ID = ID,
      servicio : Association to one Servicio
                      on servicio.DESTINATION_ID = ID
    };

  entity Sistema_Externo               as
    projection on db.SISTEMA_EXTERNO {
      *,
      destination : Association to many Destination
                      on destination.SISTEMA_EXTERNO_ID = ID,
      servicio : Association to many Servicio
                      on servicio.SISTEMA_EXTERNO_ID = ID
    };

  entity Servicio                      as
    projection on db.SERVICIO {
      *,
      destination : Association to one Destination
                      on destination.ID = DESTINATION_ID,
      sistema_externo : Association to one Sistema_Externo
                      on sistema_externo.ID = SISTEMA_EXTERNO_ID,
      servicio_parametro : Association to many Servicio_Parametro
                      on servicio_parametro.SERVICIO_ID = ID
  };

  entity Servicio_Parametro as projection on db.SERVICIO_PARAMETRO {
    *,
    servicio : Association to one Servicio
                      on servicio.ID = SERVICIO_ID
  };

}

@protocol: 'rest'
@path    : '/services'
service alerta {
  @open
  type object {};

  function envioNotificacion(input: object) returns object;
}
