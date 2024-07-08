################################################################################
rm(list=ls())  #limpiar Environment
cat("\014")    #limpiar consola  
graphics.off() #limpiar visor de gráficas
################################################################################
getwd() #consultar directorio actual
#setwd("Insert/wd") #Insertar directorio
getwd()
dir() #archivos del directorio
################################################################################

##Factor
eye.colors <- c("brown", "blue", "blue", "green",
                "brown", "brown", "brown")
is.vector(eye.colors) #TRUE
is.factor(eye.colors) #FALSE
levels(eye.colors)    #NULL

eye.colors <- factor(c("brown", "blue", "blue", "green",
                       "brown", "brown", "brown"))
is.vector(eye.colors) #FALSE
is.factor(eye.colors) #TRUE
levels(eye.colors)
eye.colors


survey.results <- factor(c("Disagree", "Neutral", "Strongly Disagree",
       "Neutral", "Agree", "Strongly Agree", "Disagree", "Strongly Agree", 
       "Neutral","Strongly Disagree", "Neutral", "Agree"),
    levels=c("Strongly Disagree", "Disagree", "Neutral", "Agree", 
             "Strongly Agree"), ordered=TRUE)

survey.results
#ordered=TRUE genera jerarquía

rm(list=ls()) #limpiar Environment

factor(1:3)
factor(1:3, levels=1:5)
factor(1:3, labels=c("A", "B", "C"))
factor(1:5, exclude=4)
ff <- factor(c(2, 4), levels=2:5)
ff
rm(ff)

estado <- c("tas", "sa", "qld", "nsw", "nsw", "nt", "wa", "wa",
            "qld", "vic", "nsw", "vic", "qld", "qld", "sa", "tas",
            "sa", "nt", "wa", "vic", "qld", "nsw", "nsw", "wa",
            "sa", "act", "nsw", "vic", "vic", "act")
table(estado)
is.vector(estado)
is.factor(estado)

FactorEstado <- factor(estado)
FactorEstado
is.vector(FactorEstado)
is.factor(FactorEstado)
levels(FactorEstado)
table(FactorEstado)

#rm(estado) #borrar estado
Peso <- c(90,120,56)
Altura <- c(1.90,1.87,1.70)

################################################################################
################################################################################
#Data.Frame
datos1 <- data.frame(Peso, Altura)
datos1
is.data.frame(datos1)

#cbind() permite unir columnas en una tabla
#Tambien se puede con la funciones cbind()
datos1 <- cbind(Peso, Altura)
rm(Peso, Altura)
is.data.frame(datos1)
#posteriormente asignando formato data.frame manualmente
datos1 <- as.data.frame(datos1)
is.data.frame(datos1)
#La función rbind() permite unir filas en una tabla



datos2 <- data.frame(datos1, Sexo=c("Hombre","Hombre","Mujer"))
datos2
str(datos2)
#El vector "Sexo" se puede transformar en un factor.

#Consultar a R si datos1 pertenece a cada estructura de datos
is.vector(datos1)
is.matrix(datos1)
is.data.frame(datos1)
is.factor(datos1)
#Consultar a R si la variable (vector) Altura es de tipo factor
is.factor(datos1[2])
is.factor(datos1$Altura)
#Consultar a R si la variable (vector) Sexo es de tipo factor
is.factor(datos2[3])
is.factor(datos2$Sexo)
#Recordar
datos2[3] == datos2$Sexo
datos2[3]
#La variable sexo debería ser de tipo factor...


#Para introducir un vector de nombres como tales, sin transformarlo... 
#... en factores, debe utilizar la función I( ).

nombres<-c("Pepe","Paco","Pepita")
nombres

datos3 <- data.frame(datos2, Nombres=I(nombres))
str(datos3)

#Otra forma de incorporar variables
datos4 <- transform(datos3,logPeso=log(Peso))
datos4 <- transform(datos4,IMC=Peso/(Altura)^2)
datos4



#Si desea seleccionar un subconjunto de una hoja de datos, puede hacerlo...
#... con la función subset(). También se puede utilizar en vectores.
datos3
subset(datos3,select=c(Sexo,Nombres))  #select: filtrando columnas (variables)
subset(datos3,subset=c(Sexo=="Mujer")) #subset: filtrando filas
subset(datos3,Sexo=="Hombre"& Peso >100)  #subset: filtrando filas

subset(datos3,select=c(Sexo,Nombres),subset=c(Sexo=="Mujer")) #filtrando ambas

#Tambien se puede filtrar el data frame con el uso de [,]
datos3[,c("Sexo","Nombres")]  #filtrando columnas (variables)
datos3[,3:4]                  #filtrando columnas (variables)

datos3[datos3$Sexo=="Mujer",] #filtrando filas
datos3[which(datos3$Sexo=="Mujer"),] #filtrando filas  

datos3[datos3$Sexo=="Mujer",c("Sexo","Nombres")] #filtrando ambas
datos3[which(datos3$Sexo=="Mujer"),c("Sexo","Nombres")] #filtrando ambas


rm(list=ls())
################################################################################
################################################################################
###Cargar bases de datos

#Desde la Web
library(quantmod)

#Cargar Datos SP500 by yahoo
#SP500 <- na.omit(getSymbols("^GSPC", from = "2010-01-01", src="yahoo", auto.assign = F))
SP500 <- na.omit(getSymbols("BTC-USD", from = "2010-01-01", src="yahoo", auto.assign = F) [,c("GSPC.Close")])
#SP500 <- na.omit(getSymbols("^GSPC", from = "2010-01-01", to = "2020-01-01" ,src="yahoo", auto.assign = F) [,c("GSPC.Close")])
head(SP500)
plot(SP500)
SP500 <- as.data.frame(SP500)
plot(time(SP500),SP500)

#Cargar 3 series desde FRED
list_RATE <- c("IR3TIB01AUM156N" ,"IR3TIB01ATM156N" ,"IR3TIB01BEM156N")
# import data from FRED 
getSymbols( list_RATE, src = "FRED")
plot(IR3TIB01AUM156N)
plot(IR3TIB01ATM156N)
plot(IR3TIB01BEM156N)

#Importar archivo dta (STATA)
library(haven)
MROZ <- read_dta("MROZ.DTA")

#Importar archivo CSV
library(readr)
usedcars <- read.csv("usedcars.csv", stringsAsFactors = FALSE)

#Importar archivo Excel
library(readxl)
cps_ch3 <- read_excel("cps_ch3.xlsx")

rm(list=ls())
################################################################################
################################################################################
n <- 50
x <- 1:50
y <- x^2 + rnorm(n)*20

round(cbind(x,y),2)
##Funciones gráficas
#----------------------------------------------------|
#plot
plot(x)      #graficar los valores de x (en el eje y) ordenados en el eje x
plot(x,y)    #gráfico bivariado de x (en el eje x) y y (en el eje y)
plot(y~x)    #equivalente al anterior

#xlim=, ylim= especifica los límites inferiores y superiores de los ejes
plot(x,y,xlim=c(1,50),ylim=c(0,2500),type="l")
plot(x,y,xlim=c(1,50),ylim=c(0,2500),type="s")
plot(x,y,xlim=c(1,50),ylim=c(0,2500),type="o")
#type="p" 
#"p": puntos, 
#"l": líneas, 
#"b": puntos conectados por líneas 
#"o": igual al anterior, pero las líneas están sobre los puntos 
#"h": líneas verticales, 
#"s": escaleras, los datos se representan como la parte superior de las líneas verticales, 
#"S": escaleras, los datos se representan como la parte inferior de las líneas verticales
#"n": No se realiza ningún gráfico, aunque se dibujan los ejes 

plot(x, y, xlab="Diez numeros al azar", ylab="Otros diez numeros",
     xlim=c(1,50),ylim=c(0,2500), pch=22, col="red",
     bg="yellow", bty="l", tcl=0.4,
     main="Como personalizar un grafico en R", las=1, cex=1.5)
#xlab=, ylab= títulos en los ejes; deben ser variables de tipo caracter
#main= título principal; debe ser de tipo caracter
#sub= sub-título (escrito en una letra más pequea)
#add=FALSE #si es TRUE superpone el gráfico en el ya existente (si existe)
#axes=TRUE #si es FALSE no dibuja los ejes ni la caja del gráfico


#points
plot(-4:4, -4:4, type = "n") #Solamente los ejes
#points() #agrega puntos (se puede usar la opción type=)
# Representamos 20 números aleatorios de una distribución normal en rojo
points(rnorm(20), rnorm(20), col = "red")
# Representamos 10 números aleatorios de una distribución normal en azul 
points(rnorm(10), rnorm(10), col = "blue", cex = 3)
points(rnorm(5), rnorm(5), col = 8, cex = 4, pch=2)
#pch: tipo de punto
#cex: tamaño puntos
abline(h=0,col="gray",lty=2)
#abline( ) Función que añade líneas rectas.
#col: color de la línea en este caso
#lty: tipo de línea
abline(v=2,col="orange",lty=3)

#abline(a,b) dibuja una línea con pendiente b e intercepto a
#abline(h=y) dibuja una línea horizontal en la ordenada y
#abline(v=x) dibuja una línea vertical en la abcisa x


#curve
curve(sin, -2*pi, 2*pi,add=T)
#add=T: permite que se incorpore al mismo grafico
curve(sin, -2*pi, 2*pi,add=F)
curve(sin, -2*pi, 2*pi)
#add=F: genera un grafico nuevo
#lo mismo para abline()


plot(-4:4, -4:4, type = "n") #Solamente los ejes
title(main="Hola",sub="Mundo")  #agrega un título y opcionalmente un sub-título
#Agregar líneas rectas
abline(2,0.5, col=2, lty=2)
abline(h=0,col="gray",lty=3)
#legend
legend("topright",legend=c("recta","cero"),lty=c(2,3), col=c(2,"gray"))
#agrega la leyenda en el punto (x,y) con s´imbolos dados por legend


x <- rnorm(n)
y <- rnorm(n)
par(bg="lightyellow", col.axis="blue", mar=c(4, 4, 2.5, 0.25))
plot(x, y, xlab="Diez numeros al azar", ylab="Otros diez numeros",
     xlim=c(-2, 2), ylim=c(-2, 2), pch=22, col="red", bg="yellow",
     bty="l", tcl=-.25, las=1, cex=1.5)
title("Como personalizar un grafico en R (bis)", font.main=3, adj=1)



par(bg="lightgray", mar=c(2.5, 1.5, 2.5, 0.25))
plot(x, y, type="n", xlab="", ylab="", xlim=c(-2, 2),
     ylim=c(-2, 2), xaxt="n", yaxt="n")
rect(-3, -3, 3, 3, col="cornsilk")
points(x, y, pch=10, col="red", cex=2)
axis(side=1, c(-2, 0, 2), tcl=-0.2, labels=FALSE)
axis(side=2, -1:1, tcl=-0.2, labels=FALSE)
title("Como personalizar un grafico en R (ter)",
      font.main=4, adj=1, cex.main=1)
mtext("Diez numeros al azar", side=1, line=1, at=1, cex=0.9, font=3)
mtext("Otros diez numeros", line=0.5, at=-1.8, cex=0.9, font=3)
mtext(c(-2, 0, 2), side=1, las=1, at=c(-2, 0, 2), line=0.3,
      col="blue", cex=0.9)
mtext(-1:1, side=2, las=1, at=-1:1, line=0.2, col="blue", cex=0.9)



graphics.off()
##barplot
x <- c(1,2,3,1,2,1,2,4,1,3,2,4,1,2,3,1,2,4,2,1)
table(x)
frec.x <- table(x)
barplot(frec.x, main="Frecuencia relativa", xlab="Valores de la variable")


barplot(height = cbind(x = c(4, 9), y = c(8, 2), z = c(3, 7) ), beside = TRUE,
        width = c(45, 50, 35), col = c(1, 2), legend.text = c("hombre", "mujer"))


#pie
muestra <- c(15, 12,4, 16, 8)
paises <- c("USA", "Inglaterra", "Australia", "Alemania", "Francia")
pie(muestra, labels = paises, main="Diagrama de sectores de países")

muestra <- c(15, 12, 4, 16, 8)
paises <- c("USA", "Inglaterra", "Australia", "Alemania", "Francia")
pct <- round(muestra/sum(muestra)*100)
paises <- paste(paises, pct)
paises <- paste(paises,"%",sep="")
pie(muestra,labels = paises, col=rainbow(length(paises)),
      main="Diagrama de sectores de países")

Provincias.estudiantes<-c("GR", "CO", "MA", "GR","GR", "MA", "GR","GR", "CO")
table(Provincias.estudiantes)
pie(table(Provincias.estudiantes), col=c("red","blue","green"))
title("Provincias de nacimiento")

# install.packages("plotrix")
library(plotrix)
votos <- c(125, 120, 4, 16, 8)
partidos <- c("PSOE", "PP", "IU", "CIU", "PNV")
pie3D(votos,labels=partidos,explode=0.1, main="Elecciones Nacionales")



#Histograma
x<-rnorm(1000)
hist(x)
hist(x, nclass=n/2)
hist(x, breaks=n/2)

hist(x, freq = FALSE, breaks = 12, col="lightblue", border="pink")
hist(x, freq = FALSE, breaks = 3, col="red", border="green")

hist(x,col="red",freq=F,xlim=c(-5,5))
curve(dnorm(x),-5,5,add=T,col="blue")


#boxplots
boxplot(mpg~cyl,data=mtcars, main="Kilometraje",
        xlab="Cilindros", ylab="Kilómetros por litro")


boxplot(mpg~cyl,data=mtcars, main="Kilometraje",
       xlab="Cilindros", ylab="Kilómetros por litro",
       col=(c("gold","darkgreen")))


