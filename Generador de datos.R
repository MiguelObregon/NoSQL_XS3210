library(jsonlite)
library(dplyr)

#Generar fechas aleatorias
generar_fechas <- function(n) {
  start_date <- as.POSIXct("2024-01-01 08:00:00")
  end_date <- as.POSIXct("2024-12-31 16:00:00")
  as.POSIXct(runif(n, as.numeric(start_date), as.numeric(end_date)), origin = "1970-01-01")
}

# Listas 
nombres_unicos <- c("Juan", "María", "Carlos", "Ana", "Luis", "Pedro", "Sofía", "Camila", 
                    "José", "Miguel", "Fernando", "Valeria", "Andrea", "Roberto", "Julia", 
                    "Lucas", "Alejandro", "Gabriel", "Isabel", "Daniel", "Samuel", "Marta", 
                    "Carmen", "Manuel", "Joaquín", "Álvaro", "Cristina", "Tomás", "Ricardo", 
                    "Patricia", "Adriana", "Esteban", "Beatriz", "Nicolás", "Diego", "David", 
                    "Guillermo", "Javier", "Fabián", "Iván", "Renata", "Lucía", "Carolina", 
                    "Paula", "Francisco", "Inés", "Victoria", "Elsa", "Pablo", "Sergio", 
                    "Rafael", "Carlos", "Mónica", "Eduardo", "Alicia", "Bárbara", "Olga", 
                    "Jorge", "Rodrigo", "Sebastián", "Gonzalo", "Raquel", "Hugo", "Cristóbal", 
                    "Marcos", "Jacobo", "Elena", "Felipe", "Héctor", "Ignacio", "Leonardo", 
                    "Matías", "Lorena", "Ángel", "Luis", "Irene", "Ester", "Adolfo", "Rocío", 
                    "Mario", "Tania", "Gerardo", "Sara", "Víctor", "Rubén", "Mauricio", 
                    "Natalia", "Pilar", "Gustavo", "Santiago", "Patricio", "Marcela", "Gisela", 
                    "Margarita", "Gabriela", "Antonia", "Clara", "Alonso", "Benjamín", "Verónica")

apellidos_unicos <- c("Pérez", "Gómez", "López", "Rodríguez", "Fernández", "Martínez", 
                      "García", "Ruiz", "Hernández", "Torres", "Rojas", "Vargas", 
                      "Ramírez", "Morales", "Castro", "Jiménez", "Navarro", "Soto", 
                      "Mora", "Castillo", "Cordero", "Montero", "Araya", "Chacón", 
                      "Solano", "Porras", "Valverde", "Zamora", "Esquivel", "Salas", 
                      "Campos", "Fonseca", "Brenes", "Carvajal", "Sánchez", "Barquero", 
                      "Cruz", "Leiva", "Arias", "Villalobos", "Cascante", "Alfaro", 
                      "Guevara", "Alvarado", "Ulate", "Méndez", "Vega", "Corrales", 
                      "Aguilar", "Madrigal", "Quesada", "Murillo", "Solis", "Bolaños", 
                      "Martí", "Cubero", "Ocampo", "Loría", "Cabrera", "Zúñiga", 
                      "Venegas", "Villatoro", "Bermúdez", "Arrieta", "Ledezma", "Núñez", 
                      "Picado", "Acosta", "Viales", "Borges", "Sandí", "Obando", 
                      "Calvo", "Vásquez", "Chaves", "Elizondo", "Zúñiga", "Aguilera", 
                      "Salazar", "Mora", "Monge", "Vega", "Acuña", "Chinchilla", 
                      "Gutiérrez", "Barboza", "Cubillo", "Oviedo", "Sibaja", "Serrano", 
                      "Conejo", "Quirós", "Bermúdez", "Ortiz", "Zamora", "Zárate", 
                      "Céspedes", "Madriz", "Hidalgo", "Blanco")

dominios_email <- c("@gmail.com", "@yahoo.com", "@hotmail.com", "@outlook.com", "@protonmail.com")

#Genera números de teléfono aleatorios
generar_telefonos <- function(n) {
  unique_telefonos <- c()
  while (length(unique_telefonos) < n) {
    num <- paste0("+506", sprintf("%08d", sample(0:99999999, 1)))
    if (!(num %in% unique_telefonos)) {
      unique_telefonos <- c(unique_telefonos, num)
    }
  }
  return(unique_telefonos)
}


#Creación pacientes
pacientes <- data.frame(
  tipo_documento = rep("paciente", 100),
  paciente_id = paste0("PAC", sprintf("%05d", 1:100)),
  nombre = sample(nombres_unicos, 100, replace = FALSE),
  apellido1 = sample(apellidos_unicos, 100, replace = FALSE),
  apellido2 = sample(apellidos_unicos, 100, replace = FALSE),
  telefono = generar_telefonos(100),  # Generar números de teléfono únicos
  fecha_nacimiento = generar_fechas(100),
  alergias = sample(c("Penicilina", "Ninguna", "Ibuprofeno", "Gluten"), 100, replace = TRUE)
)


pacientes$correo <- paste0(tolower(pacientes$nombre), ".", tolower(pacientes$apellido1), sample(dominios_email, 100, replace = TRUE))

#Convertir a JSON
pacientes_json <- toJSON(pacientes, pretty = TRUE, auto_unbox = TRUE)
write(pacientes_json, file = "pacientes_odontologia.json")

#Genera datos citas 
estados <- c("confirmada", "cancelada", "perdida")
motivos <- c("consulta general", "tratamiento", "control")

citas <- data.frame(
  tipo_documento = rep("cita", 100),
  cita_id = paste0("CITA", sprintf("%05d", 1:100)),
  fecha_hora = generar_fechas(100),
  estado = sample(estados, 100, replace = TRUE),
  motivo = sample(motivos, 100, replace = TRUE),
  paciente_id = pacientes$paciente_id,
  notas = sample(c("Paciente debe llegar 15 minutos antes.", "Revisar antecedentes.", "Traer examen de sangre.", ""), 100, replace = TRUE)
)

#Convertir a JSON
citas_json <- toJSON(citas, pretty = TRUE, auto_unbox = TRUE)
write(citas_json, file = "citas_odontologia.json")

#Genera datos sustituciones
sustituciones <- data.frame(
  tipo_documento = rep("sustitucion", 100),
  sustitucion_id = paste0("SUST", sprintf("%05d", 1:100)),
  cita_id_original = citas$cita_id,
  paciente_id_original = citas$paciente_id,
  paciente_id_sustituto = sample(pacientes$paciente_id, 100, replace = TRUE),
  nueva_fecha_hora = generar_fechas(100),
  notas = sample(c("Reprogramación por inasistencia.", "Sustitución a petición del paciente."), 100, replace = TRUE)
)

#Convertir a JSON
sustituciones_json <- toJSON(sustituciones, pretty = TRUE, auto_unbox = TRUE)
write(sustituciones_json, file = "sustituciones_odontologia.json")

#Genera datos inasistencias 
inasistencias <- data.frame(
  tipo_documento = rep("inasistencia", 100),
  inasistencia_id = paste0("INA", sprintf("%05d", 1:100)),
  cita_id = citas$cita_id,
  paciente_id = citas$paciente_id,
  fecha_cita = citas$fecha_hora,
  razones = sample(c("Problemas de transporte", "Enfermedad", "No informó razones"), 100, replace = TRUE)
)

#Convertir a JSON
inasistencias_json <- toJSON(inasistencias, pretty = TRUE, auto_unbox = TRUE)
write(inasistencias_json, file = "inasistencias_odontologia.json")
