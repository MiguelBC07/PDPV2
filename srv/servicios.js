const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
  const db = await cds.connect.to('db');

  this.on("envioNotificacion", async (req) => {
    const { TIPO } = req.data.input;
    try {
      switch (TIPO) {
        case ARSO:
          const query = `SELECT ID, CREATED_AT FROM SOLICITUD AS D WHERE ESTADO = 'Pendiente'`;
          break;
        case DENUNCIA:

          break;
        case DOCUMENTO:

          break;

        default:
          break;
      }
      return {
        response: true,
        data: acts,
      };
    } catch (err) {
      console.error("Error en envioNotificacion:", err.message);
      return {
        rsponse: false,
        message: err.message,
      };
    }
  });

});