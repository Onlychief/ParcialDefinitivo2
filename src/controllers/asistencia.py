
from flask import render_template, request, redirect, url_for,Flask,jsonify,make_response, session, flash
from src import app
from src.models.asistencia import AsistenciaModel
from random import choice
from urllib.request import urlopen
from datetime import datetime
import time
import webbrowser
import hashlib

app.secret_key = "diaz"

@app.route('/asistencia/asistir_a_clase/<id_espacio>', methods = ['POST', 'GET'])
def asistir_a_clase(id_espacio):

    if "user" in session:
        id_estudiante = session["user"]

        hora_entrada = time.strftime('%H:%M:%S', time.localtime())
        hora_salida = time.strftime('%H:%M:%S', time.localtime())
        asistenciaModel = AsistenciaModel()
        asistenciaModel.registrar_asistencia("Asistió", id_espacio, id_estudiante, hora_entrada, hora_salida)
        return render_template('estudiantes/revisando_temas.html')

@app.route('/id_para_asistencia/<id_espacio>', methods = ['POST', 'GET'])
def revisar_asistencia(id_espacio):
    if request.method == 'POST':
        session["idespacio"] = id_espacio
        return redirect(url_for('ver_asistencia'))

@app.route('/ver_asistencia', methods = ['POST', 'GET'])
def ver_asistencia():
    if "idespacio" in session:
        id_espacio = session["idespacio"]  
        
        if request.method == 'GET':
            asistenciaModel = AsistenciaModel()
            asistencias = asistenciaModel.listar_asistencias(id_espacio)
            return render_template('docentes/ver_asistencias.html', asistencias = asistencias )
    else:
        return redirect(url_for('login'))