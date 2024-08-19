import pyodbc
import os
import sys

def read_database():
    try:
        with open('./database.sql', "r", encoding='utf-8') as f:
            scripts_database = f.read()
    except FileNotFoundError:
        print("\n\n[●] El archivo database.sql no se encuentra.")
        respuesta = input('¿Deseas continuar? (yes/no): ').strip().lower()
        if respuesta != 'yes':
            sys.exit(0)
        scripts_database = ""
    except IOError as e:
        print(f"[●] Error al leer el archivo: {e}")
        sys.exit(1)
    
    output = scripts_database.replace('\nGO', ';').replace('\ngo', ';')
    return output




def create_database(sql_commands):
    server_name = '.'
    database_name = input('Ingrese el nombre de la base de datos: ')
    try:
        conn_string = f"DRIVER={{SQL Server}};SERVER={server_name};trusted_connection=yes;"
        
        print('\n\n========================================')
        print('      CREACION DE LA BASE DE DATOS      ')
        print('========================================\n')

        with pyodbc.connect(conn_string, autocommit=True) as conn:
            with conn.cursor() as cursor:
                cursor.execute(f"CREATE DATABASE {database_name}")
                print(f"[✓] La base de datos '{database_name}' fue creada exitosamente.")
                
                cursor.execute(f"USE {database_name}")
        
        new_conn_string = f"DRIVER={{SQL Server}};SERVER={server_name};DATABASE={database_name};trusted_connection=yes;"            
        
        with pyodbc.connect(new_conn_string, autocommit=True) as conn:
            with conn.cursor() as cursor:
                cursor.execute(f"{sql_commands}")
                print(f"[✓] Las tablas fueron creadas exitosamente")
                
                cursor.execute(f"USE {database_name}")

    except pyodbc.Error as e:
        print(f"Error al conectar con la base de datos: {e}")
    
    return database_name


def insert_data(database_name):
    print('\n\n========================================')
    print('           INSERCIÓN DE DATOS          ')
    print('======================================== \n')
    directories = os.listdir('./DATA')
    server_name = '.'
    conn_string = f"DRIVER={{SQL Server}};SERVER={server_name};DATABASE={database_name};trusted_connection=yes;"
    
    if not directories:
        print("[●] No hay scripts para insertar datos")
        return
    
    with pyodbc.connect(conn_string, autocommit=True) as conn:
            with conn.cursor() as cursor:
                cursor.execute(f"USE {database_name}")

                for filename in directories:
                    filepath = os.path.join('./DATA', filename)
                    with open(filepath, "r", encoding='utf-8' , errors='ignore') as f:
                        content = f.read().replace('\nGO', ';').replace('\ngo', ';')
                        try:
                            cursor.execute(content)
                            print(f"[✓] {filename.split('_')[1].split('.')[0]}")
                        except pyodbc.Error as e:
                            print(f"[x] Hubo un error y no se pudo crear la tabla {filename.split('_')[1].split('.')[0]}: {e}")

def create_constraints(database_name):
    print('\n\n========================================')
    print('        CREACION DE RESTRICCIONES       ')
    print('======================================== \n')
    directories = os.listdir('./CONSTRAINTS')
    server_name = '.'
    conn_string = f"DRIVER={{SQL Server}};SERVER={server_name};DATABASE={database_name};trusted_connection=yes;"
    
    if not directories:
        print("[●] No hay scripts para la creacion de restricciones")
        return

    with pyodbc.connect(conn_string, autocommit=True) as conn:
            with conn.cursor() as cursor:
                cursor.execute(f"USE {database_name}")

                for filename in directories:
                    filepath = os.path.join('./CONSTRAINTS', filename)
                    with open(filepath, "r", encoding='utf-8' , errors='ignore') as f:
                        content = f.read().replace('\nGO', ';').replace('\ngo', ';')
                        try:
                            cursor.execute(content)
                            print(f"[✓] {filename.replace('_', '')}")
                        except pyodbc.Error as e:
                            print(f"[x] Hubo un error y no se pudo crear la restriccion para {filename.replace('_', '')}: {e}")

def set_defaults(database_name):
    print('\n\n========================================')
    print('                DEFAULTS       ')
    print('======================================== \n')
    directories = os.listdir('./DEFAULT')
    server_name = '.'
    conn_string = f"DRIVER={{SQL Server}};SERVER={server_name};DATABASE={database_name};trusted_connection=yes;"
    
    if not directories:
        print("[●] No hay scripts para la creacion de defaults")
        return
    
    with pyodbc.connect(conn_string, autocommit=True) as conn:
            with conn.cursor() as cursor:
                cursor.execute(f"USE {database_name}")

                for filename in directories:
                    filepath = os.path.join('./DEFAULT', filename)
                    with open(filepath, "r", encoding='utf-8' , errors='ignore') as f:
                        content = f.read().replace('\nGO', ';').replace('\ngo', ';')
                        try:
                            cursor.execute(content)
                            print(f"[✓] {filename.replace('_', ' ')}")
                        except pyodbc.Error as e:
                            print(f"[x] Hubo un error y no se pudo crear los defaults para {filename.replace('_', '')}: {e}")

def create_stored_procedures(database_name):
    print('\n\n========================================')
    print(' CREACION DE PROCEDIMIENTOS ALMACENADOS  ')
    print('======================================== \n')
    directories = os.listdir('./STORED_PROCEDURES')
    server_name = '.'
    conn_string = f"DRIVER={{SQL Server}};SERVER={server_name};DATABASE={database_name};trusted_connection=yes;"

    if not directories:
        print("[●] No hay scripts para la creacion de procedimientos almacenados")
        return
    
    with pyodbc.connect(conn_string, autocommit=True) as conn:
            with conn.cursor() as cursor:
                cursor.execute(f"USE {database_name}")

                for filename in directories:
                    filepath = os.path.join('./STORED_PROCEDURES', filename)
                    with open(filepath, "r", encoding='utf-8' , errors='ignore') as f:
                        content = f.read().replace('\nGO', ';').replace('\ngo', ';')
                        try:
                            cursor.execute(content)
                            print(f"[✓] {filename.replace('_', ' ')}")
                        except pyodbc.Error as e:
                            print(f"[x] Hubo un error y no se pudo crear el procedimiento almacenado {filename.replace('_', '')}: {e}")
                

def create_views(database_name):
    print('\n\n========================================')
    print('          CREACION DE VISTAS  ')
    print('======================================== \n')
    directories = os.listdir('./VIEWS')
    server_name = '.'
    conn_string = f"DRIVER={{SQL Server}};SERVER={server_name};DATABASE={database_name};trusted_connection=yes;"
    if not directories:
        print("[●] No hay scripts para la creacion vistas")
        return
        
    with pyodbc.connect(conn_string, autocommit=True) as conn:
            with conn.cursor() as cursor:
                cursor.execute(f"USE {database_name}")

                for filename in directories:
                    filepath = os.path.join('./VIEWS', filename)
                    with open(filepath, "r", encoding='utf-8' , errors='ignore') as f:
                        content = f.read().replace('\nGO', ';').replace('\ngo', ';')
                        try:
                            cursor.execute(content)
                            print(f"[✓] {filename.replace('_', ' ')}")
                        except pyodbc.Error as e:
                            print(f"[x] Hubo un error y no se pudo crear el la vista {filename.replace('_', '')}: {e}")
                

scripts_database = read_database()

database_name = create_database(scripts_database)

create_constraints(database_name)
set_defaults(database_name)
insert_data(database_name)
create_views(database_name)
create_stored_procedures(database_name)

print(f"\n\n")