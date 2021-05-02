from src import app
from src.config.db import DB

class DocentesModel():
    
    def lista_docentes(self):
        cursor = DB.cursor()
        cursor.execute('select * from docente')
        docentes = cursor.fetchall()
        cursor.close()
        return(docentes)
    
    def lista_materias(self):
        cursor = DB.cursor()
        cursor.execute ('select espacio_academico.id, espacio_academico.nombre, espacio_academico.semestre, semestre.desc_semestre from espacio_academico JOIN semestre ON espacio_academico.semestre=semestre.id')
        materias = cursor.fetchall()
        cursor.close()
        return(materias)

    def obtener_materia(self, id_materia):
        cursor = DB.cursor()
        cursor.execute("select id, nombre from espacio_academico where id =?", [id_materia])
        data = cursor.fetchall()
        cursor.close() 
        return (data) 

    def asignar_espacioaca(self, materia,fecha,hora_inicio,hora_final):
        cursor = DB.cursor()
        cursor.execute('insert into asignacion_espacios(espacio, fecha, hora_inicio, hora_fin) values(?,?,?,?)', (materia, fecha, hora_inicio, hora_final))
        cursor.close()

    def obtener_asignaciones(self):
        cursor = DB.cursor()
        cursor.execute("select asignacion_espacios.id, asignacion_espacios.espacio, asignacion_espacios.fecha, asignacion_espacios.hora_inicio, asignacion_espacios.hora_fin, espacio_academico.nombre from asignacion_espacios JOIN espacio_academico ON asignacion_espacios.espacio=espacio_academico.id")
        data = cursor.fetchall()
        cursor.close() 
        return (data)
    
    def obtener_asignacion_docente(self, id_docente):
        cursor = DB.cursor()
        cursor.execute("select espacio_academico.id, espacio_academico.nombre, espacio_academico.semestre, semestre.desc_semestre from espacio_academico JOIN  semestre ON espacio_academico.semestre=semestre.id WHERE espacio_academico.docente = ?", [id_docente])
        data = cursor.fetchall()
        cursor.close() 
        return (data)

    def registro_docente(self, nombre,apellido,correo, clave):
        cursor = DB.cursor()
        cursor.execute('insert into docente(nombres, apellidos,correo,clave) values(?,?,?,?)', (nombre, apellido,correo,clave))
        cursor.close() 
    
    def ingreso_docente(self, correo, clave):
        cursor = DB.cursor()
        cursor.execute('select id from docente WHERE correo=? AND clave =?', (correo,clave))
        id_usuario = cursor.fetchall()
        cursor.close()
        elid = str(id_usuario)

        caracteres = (")","(","'",",","[","]")
        id_limpio = ""

        for letters in elid:
            if letters not in caracteres:
                id_limpio = id_limpio + letters

        return (id_limpio)

    def eliminar_clase(self, id_clase):   
        cursor = DB.cursor()
        cursor.execute('DELETE FROM asignacion_espacios WHERE id = ?', [id_clase])
        cursor.close()