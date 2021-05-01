import mariadb

config = {
    'host' : 'localhost',
    'port' : 3306,
    'user' : 'root',
    'password' : '',
    'database' : 'control_asistencia',
}

DB = mariadb.connect(**config)
DB.autocommit = True