
from flask import render_template, request, redirect, url_for,Flask,jsonify,make_response, session, flash
from src import app
from src.models.docentes import DocentesModel
from random import choice
from urllib.request import urlopen
import webbrowser
import hashlib

app.secret_key = "jhonatan"

@app.route('/ver_materias', methods =['GET', 'POST'])
def ver_materias():
    if "docente" in session:
        id_docente = session["docente"]
        if request.method == 'GET':
            materiasModel =DocentesModel()
            materias = materiasModel.obtener_asignacion_docente(int(id_docente))
        return render_template('docentes/ver_materias.html', materias = materias)
    else:
        return redirect(url_for('login'))

@app.route('/docentes/espacios/<id_materia>', methods = ['POST', 'GET'])
def obtener_materia(id_materia):
    
    docentesModel = DocentesModel()
    lista = docentesModel.obtener_materia(id_materia)
    return render_template('docentes/asignarespacio.html', contact = lista[0])

@app.route('/docentes/asignar_espacio/<id_materia>', methods=['POST'])
def asignar_espacio(id_materia):
    if request.method == 'POST':
        fecha = request.form.get('fecha')
        hora_inicio = request.form.get('hora_inicio')
        hora_final = request.form.get('hora_final')
        docentesModel = DocentesModel()
        docentesModel.asignar_espacioaca(int(id_materia),fecha,hora_inicio,hora_final)
        return redirect(url_for('ver_asignaciones'))

@app.route('/ver_asignaciones', methods =['GET', 'POST'])
def ver_asignaciones():
    if "docente" in session:
        if request.method == 'GET':
            asignacionesModel = DocentesModel()
            asignaciones = asignacionesModel.obtener_asignaciones()
            return render_template('docentes/ver_asignaciones.html', asignaciones = asignaciones)
    else: 
        return redirect(url_for('login'))

@app.route('/registro', methods =['GET', 'POST'])
def registro_docentes():
    if request.method == 'GET':
        return render_template('/docentes/registro.html')
    else:
        nombre = request.form.get('nombre')
        apellido = request.form.get('apellido')
        correo = request.form.get('correo')
        clave = request.form.get('clave')
        encriptado = hashlib.md5(clave.encode())
        claveEncriptada = encriptado.hexdigest()
        docentesModel = DocentesModel()
        docentesModel.registro_docente(nombre, apellido,correo,claveEncriptada)
        return redirect(url_for('ver_materias'))

@app.route('/ingreso', methods =['GET', 'POST'])
def login():

    if request.method == 'GET':
        return render_template('/docentes/ingreso.html')
    else:
        correo = request.form.get('correo')
        clave = request.form.get('clave')
        encriptado = hashlib.md5(clave.encode())
        claveEncriptada = encriptado.hexdigest()
        docentesModel = DocentesModel()
        id_docente = docentesModel.ingreso_docente(correo, claveEncriptada)
        docente = id_docente
        session["docente"] = docente
        if docente == "":
           return redirect(url_for("login"))
        else:
            return redirect(url_for("ver_materias"))

@app.route('/inicio', methods =['GET', 'POST'])
def inicio():
    if request.method == 'GET':
        return render_template('/docentes/inicio.html')

@app.route('/clases_programadas/eliminar/<id_clase>', methods =['GET', 'POST'])
def eliminar_clase(id_clase):
    if request.method == 'GET':
        docentesModel = DocentesModel()
        docentesModel.eliminar_clase(id_clase)
        return redirect(url_for('ver_asignaciones'))