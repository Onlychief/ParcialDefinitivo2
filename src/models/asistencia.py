from src import app
from src.config.db import DB

class AsistenciaModel():
    
    def registrar_asistencia(self,falta,espacio,estudiante,hora_entradaest,hora_salidaest):
    
        cursor = DB.cursor()
        cursor.execute('insert into asistencia(falta, asignacion_espacios, estudiantes, hora_entradaest, hora_salidaest) values(?,?,?,?,?) ', (falta, espacio, estudiante, hora_entradaest, hora_salidaest))
        cursor.close()

    def listar_asistencias(self, id_espacio):
    
        cursor = DB.cursor()
        cursor.execute ('select asistencia.id, asistencia.falta, asistencia.estudiantes, asistencia.hora_entradaest, asistencia.hora_salidaest, estudiantes.nombres, estudiantes.apellidos from asistencia JOIN estudiantes ON asistencia.estudiantes=estudiantes.id WHERE asignacion_espacios = ?',[id_espacio])
        materias = cursor.fetchall()
        cursor.close()
        return(materias)