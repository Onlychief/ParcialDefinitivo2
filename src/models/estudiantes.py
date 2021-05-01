from src import app
from src.config.db import DB

class EstudiantesModel():
    
    def traer_estudiantes(self):
        
        cursor = DB.cursor()
        cursor.execute('select estudiantes.id, estudiantes.nombres, estudiantes.apellidos, estudiantes.celular, estudiantes.correo, semestre.desc_semestre from estudiantes JOIN semestre ON estudiantes.semestre=semestre.id')
        estudiantes = cursor.fetchall()
        cursor.close()
        return(estudiantes)

    def registro_estudiante(self,nombre,apellido, celular, correo, clave, semestre):
        cursor = DB.cursor()
        cursor.execute('insert into estudiantes(nombres, apellidos,celular,correo,clave,semestre) values(?,?,?,?,?,?)', (nombre, apellido, celular,correo,clave,semestre))
        cursor.close()

    def eliminar_estudiante(self, id_estudiante):   
        cursor = DB.cursor()
        cursor.execute('DELETE FROM estudiantes WHERE id = ?', [id_estudiante])
        cursor.close()

    def ingreso_estudiante(self, correo, clave):
        
        cursor = DB.cursor()
        cursor.execute('select id from estudiantes WHERE correo=? AND clave =?', (correo,clave))
        id_usuario = cursor.fetchall()
        cursor.close()
        elid = str(id_usuario)

        caracteres = (")","(","'",",","[","]")
        id_limpio = ""

        for letters in elid:
            if letters not in caracteres:
                id_limpio = id_limpio + letters
        return (id_limpio)

    def consulta_semestre (self, id_estudiante):
        cursor = DB.cursor()
        cursor.execute('select semestre from estudiantes where id =?', [id_estudiante])
        id_semestre = cursor.fetchall()
        cursor.close()
        elid = str(id_semestre)

        caracteres = (")","(","'",",","[","]")
        id_limpio = ""

        for letters in elid:
            if letters not in caracteres:
                id_limpio = id_limpio + letters
        return (id_limpio)
        

    def lista_materias_semestre(self, id_semestre):
    
        cursor = DB.cursor()
        cursor.execute ('select espacio_academico.id, espacio_academico.nombre, espacio_academico.semestre, espacio_academico.docente, semestre.desc_semestre from espacio_academico JOIN semestre ON espacio_academico.semestre=semestre.id WHERE espacio_academico.semestre = ? ', [id_semestre])
        materias_por_semestre = cursor.fetchall()
        cursor.close()
        return(materias_por_semestre)

    def obtener_asignaciones_programadas(self,fecha_actual,hora_fin):
        cursor = DB.cursor()
        cursor.execute("select asignacion_espacios.id, asignacion_espacios.espacio, asignacion_espacios.fecha, asignacion_espacios.hora_inicio, asignacion_espacios.hora_fin, espacio_academico.nombre from asignacion_espacios JOIN espacio_academico ON asignacion_espacios.espacio=espacio_academico.id WHERE fecha >= ? AND hora_fin > ?",[fecha_actual, hora_fin])
        data = cursor.fetchall()
        cursor.close() 
        return (data)

    def consulta_id_semestre (self, semestre):
        cursor = DB.cursor()
        cursor.execute('select id from semestre where desc_semestre =?', [semestre])
        id_semestre = cursor.fetchall()
        cursor.close()
        elid = str(id_semestre)

        caracteres = (")","(","'",",","[","]")
        id_limpio = ""

        for letters in elid:
            if letters not in caracteres:
                id_limpio = id_limpio + letters
        return (id_limpio)