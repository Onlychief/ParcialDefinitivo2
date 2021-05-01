
from flask import render_template, request, redirect, url_for,Flask,jsonify,make_response, session, flash
from src import app
from src.models.estudiantes import EstudiantesModel
from random import choice
from urllib.request import urlopen
from datetime import datetime
import time
import webbrowser
import hashlib

app.secret_key = "yesid"

@app.route('/ver_estudiantes', methods =['GET', 'POST'])
def ver_estudiantes():
    if request.method == 'GET':
        estudiantesModel = EstudiantesModel()
        estudianteslista = estudiantesModel.traer_estudiantes()
        return render_template('estudiantes/ver_estudiantes.html', estudianteslista = estudianteslista)

@app.route('/estudiantes/eliminar/<id_estudiante>', methods =['GET', 'POST'])
def estudiantes_eliminar(id_estudiante):
    if request.method == 'GET':
        estudiantesModel = EstudiantesModel()
        estudiantesModel.eliminar_estudiante(id_estudiante)
        return redirect(url_for('ver_estudiantes'))

@app.route('/ver_materias_semestre', methods =['GET', 'POST'])
def ver_materias_semestre():
    if "semestre" in session:
        
        id_semestre = session["semestre"]

        if request.method == 'GET':
            estudiantesModel =EstudiantesModel()
            materias_semestre = estudiantesModel.lista_materias_semestre(id_semestre)
            return render_template('estudiantes/ver_materias_semestre.html', materias_semestre = materias_semestre)
    else:
        return redirect(url_for('ingreso_estudiantes'))
@app.route('/registro_estudiantes', methods =['GET', 'POST'])
def registro_estudiantes():
    if request.method == 'GET':
        return render_template('/estudiantes/registro.html')
    else:
        nombre = request.form.get('nombre')
        apellido = request.form.get('apellido')
        celular = request.form.get('celular')
        correo = request.form.get('correo')
        clave = request.form.get('clave')
        semestref = request.form.get('semestre')
        semestreModel = EstudiantesModel()
        semestre = semestreModel.consulta_id_semestre(semestref)
        encriptado = hashlib.md5(clave.encode())
        claveEncriptada = encriptado.hexdigest()
        estudiantesModel = EstudiantesModel()
        estudiantesModel.registro_estudiante(nombre, apellido, celular,correo,claveEncriptada, semestre)
        return redirect(url_for('ver_estudiantes'))

@app.route('/ingreso_estudiantes', methods =['GET', 'POST'])
def login_estudiante():
    
    if request.method == 'GET':
        return render_template('/estudiantes/ingreso.html')
    else:
        correo = request.form.get('correo')
        clave = request.form.get('clave')
        encriptado = hashlib.md5(clave.encode())
        claveEncriptada = encriptado.hexdigest()
        estudiantesModel = EstudiantesModel()
        id_estudiante = estudiantesModel.ingreso_estudiante(correo, claveEncriptada)

        user = id_estudiante
        semestre = estudiantesModel.consulta_semestre(id_estudiante)

        session["user"] = user
        session["semestre"] = semestre

        if user == "":
            return redirect(url_for("login_estudiante"))
        else:
            return redirect(url_for("ver_materias_semestre"))

@app.route('/clases_programadas', methods =['GET', 'POST'])
def clases_programadas():
    if request.method == 'GET':
        fecha_actual = datetime.now().date()
        hora_fin = time.strftime('%H:%M:%S', time.localtime())
        clasesModel = EstudiantesModel()
        asignaciones = clasesModel.obtener_asignaciones_programadas(fecha_actual, hora_fin)
        return render_template('estudiantes/ver_asignaciones.html', asignaciones = asignaciones)

