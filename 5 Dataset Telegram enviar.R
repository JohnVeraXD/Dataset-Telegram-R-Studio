# Instalar y cargar las librerías
install.packages("jsonlite")
install.packages("dplyr")
install.packages("ggplot2")


library(jsonlite)
library(dplyr)
library(ggplot2)

# Leer los datos desde el archivo JSON
datos_json <- fromJSON("C:/Users/ANNOUS SUONNA/Downloads/Telegram Desktop/ChatExport_2023-12-21/result.json")


# Filtrar mensajes de tipo "message" del json
mensajes_filtrados <- datos_json$messages %>%
  filter(type == "message")


#Seleccionar las columnas from y text (persona y mensaje)
datos_filtrados <- mensajes_filtrados %>% select(from, text)

#Crear el dataset
datos <- data.frame(
  Persona = datos_filtrados$from,
  Mensaje = datos_filtrados$text
)


# Contar la cantidad de mensajes por persona
datos_resumen <- datos %>%
  group_by(Persona) %>%
  summarise(Cantidad_Mensajes = n())


# Crear un gráfico de barras
ggplot(datos_resumen, aes(x = Persona, y = Cantidad_Mensajes, fill = Persona)) +
  geom_bar(stat = "identity") +
  labs(title = "Cantidad de Mensajes por Persona",
       x = "Persona",
       y = "Cantidad de Mensajes") +
  scale_fill_manual(values = rainbow(nrow(datos_resumen))) +  #paleta de colores
  theme_minimal()


#Crear gráfico de pastel
ggplot(datos_resumen, aes(x = "", y = Cantidad_Mensajes, fill = Persona)) +
  geom_bar(stat = "identity", width = 1, color = "white") +
  coord_polar("y") +
  theme_minimal() +
  labs(title = "Cantidad de Mensajes por Persona")



#Persona se coloca en el eje x, Cantidad_Mensajes en el eje y
#geom_bar(stat = "identity"): Agrega barras al grafico. 
#stat = "identity" significa que las alturas de las barras son proporcionales a la variable y.
#labs(title) Agrega etiquetas al gráfico
#scale_fill_manual(values = rainbow(nrow(datos_resumen))): Define manualmente los colores de las barras
#rainbow() genera paleta de colores
#theme_minimal(): Aplica un tema minimalista al grafico



