
<!-- rnb-text-begin -->

---
title: "R Notebook"
output: html_notebook
---
La base de datos de UserBenchmark de GPU contiene informacion de tarjetas graficas. Podemos usarla para revisar market share, revisar performance promedio por compañia, y veamos que tan completa es la informacion de precios. Luego, podemos revisar


<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuXG5saWJyYXJ5KGhhdmVuKVxubGlicmFyeShkcGx5cilcbmxpYnJhcnkocmVhZHhsKVxubGlicmFyeShnZ3Bsb3QyKVxubGlicmFyeSh0aWR5dmVyc2UpXG5saWJyYXJ5KGhyYnJ0aGVtZXMpXG5saWJyYXJ5KGx1YnJpZGF0ZSlcbiNpbnN0YWxsLnBhY2thZ2VzKFwiVkdBTVwiKVxubGlicmFyeShWR0FNKVxuI3BhcmEgYWJyaXIgQVBJU1xubGlicmFyeShodHRyKVxubGlicmFyeShqc29ubGl0ZSlcblxuc2V0d2QoXCJHOi9iaXRjb2luL1wiKVxuR1BVIDwtcmVhZC5jc3YoXCJHUFVfVXNlckJlbmNobWFya3MuY3N2XCIpXG5OSCA9cmVhZF9leGNlbChcIk5IX1Byb2ZpdF9HUFUueGxzeFwiKVxuYGBgIn0= -->

```r

library(haven)
library(dplyr)
library(readxl)
library(ggplot2)
library(tidyverse)
library(hrbrthemes)
library(lubridate)
#install.packages("VGAM")
library(VGAM)
#para abrir APIS
library(httr)
library(jsonlite)

setwd("G:/bitcoin/")
GPU <-read.csv("GPU_UserBenchmarks.csv")
NH =read_excel("NH_Profit_GPU.xlsx")
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->





<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuI2luc3RhbGwucGFja2FnZXMoJ3F1YW50bW9kJylcblxuI0ZlY2hhIGRlIGludGVyZXMgbWF5byAoMDUvMjAyMSkgMjAyMS0wNS0wMSwgdG89MjAyMS0wNS0zMVxuZGVzZGUgPSAgXCIyMDIxLTAzLTAxXCJcbmhhc3RhID0gXCIyMDIxLTA2LTAxXCJcblxubGlicmFyeShxdWFudG1vZClcblxuXG4jQlRDLmNsb3NlIDwtIG5hLm9taXQoZ2V0U3ltYm9scygnQlRDLVVTRCcsIGZyb20gPSBkZXNkZSwgdG89aGFzdGEgLCBzcmM9XCJ5YWhvb1wiLCBhdXRvLmFzc2lnbiA9IEYpIFssYyhcIkJUQy1VU0QuT3BlblwiKV0pXG5cblxuXG5cblxuXG5CVEMuY2xvc2UgPC0gbmEub21pdChnZXRTeW1ib2xzKCdCVEMtVVNEJywgZnJvbSA9IGRlc2RlLCB0bz1oYXN0YSAsc3JjPVwieWFob29cIiwgYXV0by5hc3NpZ24gPSBGKSBbLGMoXCJCVEMtVVNELkNsb3NlXCIpXSlcblxuQlRDLm9wZW4gPC0gbmEub21pdChnZXRTeW1ib2xzKCdCVEMtVVNEJywgZnJvbSA9IGRlc2RlLCB0bz1oYXN0YSAsc3JjPVwieWFob29cIiwgYXV0by5hc3NpZ24gPSBGKSBbLGMoXCJCVEMtVVNELk9wZW5cIildKVxuXG5CVEMucGN0PSAoQlRDLm9wZW4tQlRDLmNsb3NlKS9CVEMub3BlblxuXG5OVklESUEuY2xvc2UgPC0gbmEub21pdChnZXRTeW1ib2xzKFwiTlZEQVwiLGZyb20gPSBkZXNkZSwgdG89aGFzdGEgLHNyYz1cInlhaG9vXCIsIGF1dG8uYXNzaWduID0gRikgWyxjKFwiTlZEQS5DbG9zZVwiKV0pXG5cbk5WSURJQS5vcGVuIDwtIG5hLm9taXQoZ2V0U3ltYm9scyhcIk5WREFcIiwgZnJvbSA9IGRlc2RlLCB0bz1oYXN0YSAsc3JjPVwieWFob29cIiwgYXV0by5hc3NpZ24gPSBGKSBbLGMoXCJOVkRBLk9wZW5cIildKVxuXG5OVklESUEucGN0PSAoTlZJRElBLm9wZW4tTlZJRElBLmNsb3NlKS9OVklESUEub3BlblxuXG5NU0ZULkNsb3NlIDwtIG5hLm9taXQoZ2V0U3ltYm9scyhcIk1TRlRcIiwgZnJvbSA9IGRlc2RlLCB0bz1oYXN0YSAsc3JjPVwieWFob29cIiwgYXV0by5hc3NpZ24gPSBGKSBbLGMoXCJNU0ZULkNsb3NlXCIpXSlcblxuXG5NU0ZULk9wZW4gPC0gbmEub21pdChnZXRTeW1ib2xzKFwiTVNGVFwiLCBmcm9tID0gXCIyMDE5LTAxLTAxXCIsIHRvID0gXCIyMDIyLTAxLTAxXCIgLHNyYz1cInlhaG9vXCIsIGF1dG8uYXNzaWduID0gRikgWyxjKFwiTVNGVC5PcGVuXCIpXSlcblxuTVNGVC5wY3Q9IChNU0ZULk9wZW4tTVNGVC5DbG9zZSkvTVNGVC5PcGVuXG5cblxuYWNjaW9uZXMucGN0PWNiaW5kKEJUQy5wY3QsIE1TRlQucGN0LCBOVklESUEucGN0KVxuYGBgIn0= -->

```r
#install.packages('quantmod')

#Fecha de interes mayo (05/2021) 2021-05-01, to=2021-05-31
desde =  "2021-03-01"
hasta = "2021-06-01"

library(quantmod)


#BTC.close <- na.omit(getSymbols('BTC-USD', from = desde, to=hasta , src="yahoo", auto.assign = F) [,c("BTC-USD.Open")])






BTC.close <- na.omit(getSymbols('BTC-USD', from = desde, to=hasta ,src="yahoo", auto.assign = F) [,c("BTC-USD.Close")])

BTC.open <- na.omit(getSymbols('BTC-USD', from = desde, to=hasta ,src="yahoo", auto.assign = F) [,c("BTC-USD.Open")])

BTC.pct= (BTC.open-BTC.close)/BTC.open

NVIDIA.close <- na.omit(getSymbols("NVDA",from = desde, to=hasta ,src="yahoo", auto.assign = F) [,c("NVDA.Close")])

NVIDIA.open <- na.omit(getSymbols("NVDA", from = desde, to=hasta ,src="yahoo", auto.assign = F) [,c("NVDA.Open")])

NVIDIA.pct= (NVIDIA.open-NVIDIA.close)/NVIDIA.open

MSFT.Close <- na.omit(getSymbols("MSFT", from = desde, to=hasta ,src="yahoo", auto.assign = F) [,c("MSFT.Close")])


MSFT.Open <- na.omit(getSymbols("MSFT", from = "2019-01-01", to = "2022-01-01" ,src="yahoo", auto.assign = F) [,c("MSFT.Open")])

MSFT.pct= (MSFT.Open-MSFT.Close)/MSFT.Open


acciones.pct=cbind(BTC.pct, MSFT.pct, NVIDIA.pct)
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->




<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxudD10aW1lKEJUQy5jbG9zZSlcbkJUQz0gY2JpbmQodCAsIGFzLmRhdGEuZnJhbWUoQlRDLmNsb3NlKSlcbmdncGxvdChCVEMsIGFlcyh4PXQseT1CVEMuY2xvc2UpKStcbiAgZ2VvbV9saW5lKCkrXG4gIGdlb21fdmxpbmUoeGludGVyY2VwdD1hcy5EYXRlKCcyMDIxLTA1LTIxJykgLCBjb2xvcj1cInJlZFwiLCBzaXplPTEpK1xuICB0aGVtZV9wdWJjbGVhbigpK1xuICBsYWJzKHg9XCJGZWNoYSBkZWwgMS02LTIwMjAgYSAzMS0xLTIwMjJcIixcbiAgeT0gXCJQcmVjaW8gZGUgY2llcnJyZSBkZSBCaXRjb2luIGVuIFVTRFwiKVxuICBcbnROPXRpbWUoTlZJRElBLmNsb3NlKVxuTlZEPSBjYmluZCh0TiAsIGFzLmRhdGEuZnJhbWUoTlZJRElBLmNsb3NlKSlcblxuZ2dwbG90KE5WRCwgYWVzKHg9dE4seT1OVklESUEuY2xvc2UpKStcbiAgZ2VvbV9saW5lKCkrXG4gIGdlb21fdmxpbmUoeGludGVyY2VwdD1hcy5EYXRlKCcyMDIxLTA1LTIxJykgLCBjb2xvcj1cInJlZFwiLCBzaXplPTEpK1xuICB0aGVtZV9wdWJjbGVhbigpK1xuICBsYWJzKHg9XCJGZWNoYSBkZWwgMS02LTIwMjAgYSAzMS0xLTIwMjJcIixcbiAgeT0gXCJQcmVjaW8gZGUgY2llcnJyZSBkZSBOdmlkaWEgZW4gVVNEXCIpXG5cblxuYGBgIn0= -->

```r
t=time(BTC.close)
BTC= cbind(t , as.data.frame(BTC.close))
ggplot(BTC, aes(x=t,y=BTC.close))+
  geom_line()+
  geom_vline(xintercept=as.Date('2021-05-21') , color="red", size=1)+
  theme_pubclean()+
  labs(x="Fecha del 1-6-2020 a 31-1-2022",
  y= "Precio de cierrre de Bitcoin en USD")
  
tN=time(NVIDIA.close)
NVD= cbind(tN , as.data.frame(NVIDIA.close))

ggplot(NVD, aes(x=tN,y=NVIDIA.close))+
  geom_line()+
  geom_vline(xintercept=as.Date('2021-05-21') , color="red", size=1)+
  theme_pubclean()+
  labs(x="Fecha del 1-6-2020 a 31-1-2022",
  y= "Precio de cierrre de Nvidia en USD")

```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->




<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxubGlicmFyeShnZ3B1YnIpXG5CaXRnID0gZ2dwbG90KGFjY2lvbmVzLnBjdCwgXG4gICAgICAgICAgICAgIGFlcyhcbiAgICAgICAgICAgICAgICAgIHg9dGltZShhY2Npb25lcy5wY3QpLFxuICAgICAgICAgICAgICAgICAgeT1hY2Npb25lcy5wY3QkQlRDLlVTRC5PcGVuKjEwMCxcbiAgICAgICAgICAgICAgICAgIFxuICAgICAgICAgICAgICAgICAgKSBcbiAgICAgICAgICAgICAgKStcbiAgZ2VvbV9wb2ludChjb2xvcj1pZmVsc2UoXG4gICAgICAgICAgICAgICAgICAgIHRlc3Q9YXMuZGF0YS5mcmFtZShhY2Npb25lcy5wY3QkQlRDLlVTRC5PcGVuKjEwMCk+PTAsXG4gICAgICAgICAgICAgICAgICAgIHllcyA9LCBcImdyZWVuXCIsXG4gICAgICAgICAgICAgICAgICAgIG5vPSBcInJlZFwiKSxcbiAgICAgICAgICAgICBzaGFwZT1pZmVsc2UoXG4gICAgICAgICAgICAgICAgICAgIHRlc3Q9YXMuZGF0YS5mcmFtZShhY2Npb25lcy5wY3QkQlRDLlVTRC5PcGVuKjEwMCk+PTAsXG4gICAgICAgICAgICAgICAgICAgIHllcyA9IDIsXG4gICAgICAgICAgICAgICAgICAgIG5vPSA2KSxcbiAgICAgICAgICAgICBzaXplPSAzLFxuICAgICAgICAgICAgIGZpbGw9aWZlbHNlKFxuICAgICAgICAgICAgICAgICAgICB0ZXN0PWFzLmRhdGEuZnJhbWUoYWNjaW9uZXMucGN0JEJUQy5VU0QuT3BlbioxMDApPj0wLFxuICAgICAgICAgICAgICAgICAgICB5ZXMgPSwgXCJncmVlblwiLFxuICAgICAgICAgICAgICAgICAgICBubz0gXCJyZWRcIiksXG4gICAgICAgICAgICAgI3lsYWI9KFwiRmVjaGFcIiksIFxuICAgICAgICAgICAgICAjICAgIHhsYWI9IChcIkNhbWJpbyAlIEJUQy1VU0RcIiksXG4gICAgICAgICAgICAgI3lsaW09YygtMjAsMTApXG4gICAgICAgICAgICAgKStcbiAgZ2VvbV9saW5lKHNpemU9MSwgc2hhcGU9MikrXG4gIGdlb21fdmxpbmUoeGludGVyY2VwdD1hcy5EYXRlKCcyMDIxLTA1LTIxJykgLCBjb2xvcj1cImdyZXlcIiwgc2l6ZT0xKStcbiAgdGhlbWVfcHViY2xlYW4oKStcbiAgeWxpbSgtMjAsMTApXG5cbiAgXG5OVmc9IGdncGxvdChhY2Npb25lcy5wY3QsIGFlcyh4PXRpbWUoYWNjaW9uZXMucGN0KSx5PWFjY2lvbmVzLnBjdCROVkRBLk9wZW4qMTAwLCB5bGFiPSBcIkNhbWJpbyAlIE52aWRpYVwiKSkrXG4gIGdlb21fcG9pbnQoY29sb3I9aWZlbHNlKFxuICAgICAgICAgICAgICAgICAgICB0ZXN0PWFzLmRhdGEuZnJhbWUoYWNjaW9uZXMucGN0JE5WREEuT3BlbioxMDApPj0wLFxuICAgICAgICAgICAgICAgICAgICB5ZXMgPSwgXCJncmVlblwiLFxuICAgICAgICAgICAgICAgICAgICBubz0gXCJyZWRcIiksXG4gICAgICAgICAgICAgc2hhcGU9aWZlbHNlKFxuICAgICAgICAgICAgICAgICAgICB0ZXN0PWFzLmRhdGEuZnJhbWUoYWNjaW9uZXMucGN0JE5WREEuT3BlbioxMDApPj0wLFxuICAgICAgICAgICAgICAgICAgICB5ZXMgPSAyLFxuICAgICAgICAgICAgICAgICAgICBubz0gNiksXG4gICAgICAgICAgICAgc2l6ZT0gMyxcbiAgICAgICAgICAgICBmaWxsPWlmZWxzZShcbiAgICAgICAgICAgICAgICAgICAgdGVzdD1hcy5kYXRhLmZyYW1lKGFjY2lvbmVzLnBjdCROVkRBLk9wZW4qMTAwKT49MCxcbiAgICAgICAgICAgICAgICAgICAgeWVzID0sIFwiZ3JlZW5cIixcbiAgICAgICAgICAgICAgICAgICAgbm89IFwicmVkXCIpLFxuICAgICAgICAgICAgICAgICAgICAjeWxhYj0oXCJGZWNoYVwiKSwgXG4gICAgICAgICAgICAgICAgICAjeGxhYj0oXCJQcmVjaW8gTlZEQVwiKSxcbiAgICAgICAgICAgICB5bGltPWMoLTIwLDEwKVxuICAgICAgICAgICAgICkrXG4gIGdlb21fbGluZShzaXplPTEpK1xuICBnZW9tX3ZsaW5lKHhpbnRlcmNlcHQ9YXMuRGF0ZSgnMjAyMS0wNS0yMScpICwgY29sb3I9XCJncmV5XCIsIHNpemU9MSkrXG4gIHRoZW1lX3B1YmNsZWFuKCkrXG4gIHlsaW0oLTIwLDEwKVxuXG5cblxuXG5cbk1TZz1nZ3Bsb3QoYWNjaW9uZXMucGN0LCBhZXMoeD10aW1lKGFjY2lvbmVzLnBjdCkseT1hY2Npb25lcy5wY3QkTVNGVC5PcGVuKjEwMCwgeWxhYj0gXCJDYW1iaW8gJSBNU0ZUXCIpLHlsaW09YygtMjAsMTApKStcbiAgZ2VvbV9wb2ludChjb2xvcj1pZmVsc2UoXG4gICAgICAgICAgICAgICAgICAgIHRlc3Q9YXMuZGF0YS5mcmFtZShhY2Npb25lcy5wY3QkTVNGVC5PcGVuKjEwMCk+PTAsXG4gICAgICAgICAgICAgICAgICAgIHllcyA9LCBcImdyZWVuXCIsXG4gICAgICAgICAgICAgICAgICAgIG5vPSBcInJlZFwiKSxcbiAgICAgICAgICAgICBzaGFwZT1pZmVsc2UoXG4gICAgICAgICAgICAgICAgICAgIHRlc3Q9YXMuZGF0YS5mcmFtZShhY2Npb25lcy5wY3QkTVNGVC5PcGVuKjEwMCk+PTAsXG4gICAgICAgICAgICAgICAgICAgIHllcyA9IDIsXG4gICAgICAgICAgICAgICAgICAgIG5vPSA2KSxcbiAgICAgICAgICAgICBzaXplPSAzLFxuICAgICAgICAgICAgIGZpbGw9aWZlbHNlKFxuICAgICAgICAgICAgICAgICAgICB0ZXN0PWFzLmRhdGEuZnJhbWUoYWNjaW9uZXMucGN0JE1TRlQuT3BlbioxMDApPj0wLFxuICAgICAgICAgICAgICAgICAgICB5ZXMgPSwgXCJncmVlblwiLFxuICAgICAgICAgICAgICAgICAgICBubz0gXCJyZWRcIiksXG4gICAgICAgICAgICAgeWxhYj0oXCJGZWNoYVwiKSwgXG4gICAgICAgICAgICAgICAgICB4bGFiPSAoXCJ2YXJpYWNpw7NuICUgTVNGVFwiKSxcbiAgICAgICAgICAgICB5bGltPWMoLTIwLDEwKSkrXG4gIGdlb21fbGluZShzaXplPTEpK1xuICBnZW9tX3ZsaW5lKHhpbnRlcmNlcHQ9YXMuRGF0ZSgnMjAyMS0wNS0yMScpICwgY29sb3I9XCJncmV5XCIsIHNpemU9MSkrXG4gIHRoZW1lX3B1YmNsZWFuKCkrXG4gIHlsaW0oLTIwLDEwKVxuXG5cblxuZ2dhcnJhbmdlKEJpdGcsIE5WZywgTVNnICsgcnJlbW92ZShcIngudGV4dFwiKSwgXG4gICAgICAgICAgICAgICAgICAgIG5jb2wgPSAxLCBucm93ID0gMylcblxuYGBgIn0= -->

```r
library(ggpubr)
Bitg = ggplot(acciones.pct, 
              aes(
                  x=time(acciones.pct),
                  y=acciones.pct$BTC.USD.Open*100,
                  
                  ) 
              )+
  geom_point(color=ifelse(
                    test=as.data.frame(acciones.pct$BTC.USD.Open*100)>=0,
                    yes =, "green",
                    no= "red"),
             shape=ifelse(
                    test=as.data.frame(acciones.pct$BTC.USD.Open*100)>=0,
                    yes = 2,
                    no= 6),
             size= 3,
             fill=ifelse(
                    test=as.data.frame(acciones.pct$BTC.USD.Open*100)>=0,
                    yes =, "green",
                    no= "red"),
             #ylab=("Fecha"), 
              #    xlab= ("Cambio % BTC-USD"),
             #ylim=c(-20,10)
             )+
  geom_line(size=1, shape=2)+
  geom_vline(xintercept=as.Date('2021-05-21') , color="grey", size=1)+
  theme_pubclean()+
  ylim(-20,10)

  
NVg= ggplot(acciones.pct, aes(x=time(acciones.pct),y=acciones.pct$NVDA.Open*100, ylab= "Cambio % Nvidia"))+
  geom_point(color=ifelse(
                    test=as.data.frame(acciones.pct$NVDA.Open*100)>=0,
                    yes =, "green",
                    no= "red"),
             shape=ifelse(
                    test=as.data.frame(acciones.pct$NVDA.Open*100)>=0,
                    yes = 2,
                    no= 6),
             size= 3,
             fill=ifelse(
                    test=as.data.frame(acciones.pct$NVDA.Open*100)>=0,
                    yes =, "green",
                    no= "red"),
                    #ylab=("Fecha"), 
                  #xlab=("Precio NVDA"),
             ylim=c(-20,10)
             )+
  geom_line(size=1)+
  geom_vline(xintercept=as.Date('2021-05-21') , color="grey", size=1)+
  theme_pubclean()+
  ylim(-20,10)





MSg=ggplot(acciones.pct, aes(x=time(acciones.pct),y=acciones.pct$MSFT.Open*100, ylab= "Cambio % MSFT"),ylim=c(-20,10))+
  geom_point(color=ifelse(
                    test=as.data.frame(acciones.pct$MSFT.Open*100)>=0,
                    yes =, "green",
                    no= "red"),
             shape=ifelse(
                    test=as.data.frame(acciones.pct$MSFT.Open*100)>=0,
                    yes = 2,
                    no= 6),
             size= 3,
             fill=ifelse(
                    test=as.data.frame(acciones.pct$MSFT.Open*100)>=0,
                    yes =, "green",
                    no= "red"),
             ylab=("Fecha"), 
                  xlab= ("variación % MSFT"),
             ylim=c(-20,10))+
  geom_line(size=1)+
  geom_vline(xintercept=as.Date('2021-05-21') , color="grey", size=1)+
  theme_pubclean()+
  ylim(-20,10)



ggarrange(Bitg, NVg, MSg + rremove("x.text"), 
                    ncol = 1, nrow = 3)

```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuXG4jRmVjaGEgZGUgZXh0cmFjY2lvbiAyIGRlIGVuZXJvIDIwMjJcbkJUQ19yZWYgPSA0NzI5MS44M1xuRnVzaW9uPWxlZnRfam9pbihOSCxHUFUsIGJ5PShcIk1vZGVsXCIpKVxuICBcbkNBUkRTPUZ1c2lvbiU+JXJlbmFtZShcIkJyYW5kXCIgPSBCcmFuZC54LFxuICAgICAgICAgICAgICAgICAgICAgIFwiRW5lcmd5X1dcIj0gYGVuZXJneV9jb25zdW1wdGlvbl9XQVRUKCoxMClgLFxuICAgICAgICAgICAgICAgICAgICAgIFwiRWZpY2llbmNpYV9VU0RfV0FUVFwiPWBlZmljaWVuY2lhX1VTRC9XQVRUYCklPiVcbiAgICAgICAgICAgICAgICBzZWxlY3QoLWMoQnJhbmQueSwgVVJMKSklPiVcbiAgICAgICAgICAgICAgICBtdXRhdGUocHJvZml0X0JUQz0gYXMubnVtZXJpYyhuZXRfcHJvZml0X1VTX0RBWSkvQlRDX3JlZixcbiAgICAgICAgICAgICAgICAgICAgICAgQ29zdHNfQlRDPWFzLm51bWVyaWMoYEVsZWN0cmljX2Nvc3RfVVNEKDVjZW50KWApL0JUQ19yZWYsXG4gICAgICAgICAgICAgICAgICAgICAgIGVmaWNpZW5jaWFfQlRDPSBDb3N0c19CVEMvRW5lcmd5X1cpXG4gICAgICAgICAgICAgICAgXG4gIFxuICBcbiAgXG5gYGAifQ== -->

```r

#Fecha de extraccion 2 de enero 2022
BTC_ref = 47291.83
Fusion=left_join(NH,GPU, by=("Model"))
  
CARDS=Fusion%>%rename("Brand" = Brand.x,
                      "Energy_W"= `energy_consumption_WATT(*10)`,
                      "Eficiencia_USD_WATT"=`eficiencia_USD/WATT`)%>%
                select(-c(Brand.y, URL))%>%
                mutate(profit_BTC= as.numeric(net_profit_US_DAY)/BTC_ref,
                       Costs_BTC=as.numeric(`Electric_cost_USD(5cent)`)/BTC_ref,
                       eficiencia_BTC= Costs_BTC/Energy_W)
                
  
  
  
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->



<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuQ0FSRFMlPiVcbiAgZ2dwbG90KGFlcyh5PUJlbmNobWFyaywgeD1hcy5udW1lcmljKG5ldF9wcm9maXRfVVNfREFZKSwgY29sb3I9QnJhbmQsIHNoYXBlID0gQnJhbmQsIFxuICAgICAgICAgICAgIClcbiAgICAgICAgICkrXG4gIGdlb21fcG9pbnQoc2l6ZT0yKStcbiAgICB0aGVtZV9wdWJjbGVhbigpK1xuICBsYWJzKCB0aXRsZSA9IFwiQ2FsaWRhZCB0ZWNuaWNhIHJlc3BlY3RvIGEgQmVuZWZpY2lvIGRlIE1pbmEgZGUgR1BVc1wiLHg9IFwiQmVuZWZpY2lvIERpYXJpbyBOZXRvIGRlIE1pbmEgKFVTRClcIiwgeT1cIkluZGljZSBJbnRlZ3JhZG8gZGUgQ2FsaWRhZFwiKStcbiAgZ2VvbV9zbW9vdGgobWV0aG9kID0gXCJsbVwiLCBzZSA9IEZBTFNFKVxuICB4bGltKC0xLDYpXG5cbmBgYCJ9 -->

```r
CARDS%>%
  ggplot(aes(y=Benchmark, x=as.numeric(net_profit_US_DAY), color=Brand, shape = Brand, 
             )
         )+
  geom_point(size=2)+
    theme_pubclean()+
  labs( title = "Calidad tecnica respecto a Beneficio de Mina de GPUs",x= "Beneficio Diario Neto de Mina (USD)", y="Indice Integrado de Calidad")+
  geom_smooth(method = "lm", se = FALSE)
  xlim(-1,6)

```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->




<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuQ0FSRFMlPiVcbiAgZ3JvdXBfYnkoQnJhbmQpJT4lXG4gIHN1bW1hcmlzZShuID0gbigpLFxuICAgICAgICAgICAgbXVlc3RyYXMgPXN1bShTYW1wbGVzLG5hLnJtID0gVCksXG4gICAgICAgICAgICBQb2RlciA9bXVlc3RyYXMvbixcbiAgICAgICAgICAgIFJBTks9IG1lYW4oUmFuaywgbmEucm0gPSBUKSxcbiAgICAgICAgICAgIEVmaWNpZW5jaWEgPSBtZWFuKGVmaWNpZW5jaWFfQlRDLG5hLnJtID0gVCksXG4gICAgICAgICAgICBCRU5DSCA9IG1lYW4oQmVuY2htYXJrICxuYS5ybSA9IFQpLFxuICAgICAgICAgICAgZW5lcmdpYSA9bWVhbihFbmVyZ3lfVyxuYS5ybSA9IFQpLFxuICAgICAgICAgICAgcHJvZml0PSBtZWFuKHByb2ZpdF9CVEMsIG5hLnJtID0gVCkpJT4lXG4gIGFycmFuZ2UoUG9kZXIpXG5cbmBgYCJ9 -->

```r
CARDS%>%
  group_by(Brand)%>%
  summarise(n = n(),
            muestras =sum(Samples,na.rm = T),
            Poder =muestras/n,
            RANK= mean(Rank, na.rm = T),
            Eficiencia = mean(eficiencia_BTC,na.rm = T),
            BENCH = mean(Benchmark ,na.rm = T),
            energia =mean(Energy_W,na.rm = T),
            profit= mean(profit_BTC, na.rm = T))%>%
  arrange(Poder)

```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->

Intentemos abrir API de Comparacion de mina de Cryptos

<!-- rnb-text-end -->


<!-- rnb-chunk-begin -->


<!-- rnb-source-begin eyJkYXRhIjoiYGBgclxuTkNIU0ggPSBHRVQoXCJodHRwczovL2FwaTIubmljZWhhc2guY29tL21haW4vYXBpL3YyL21pbmluZy9leHRlcm5hbC97YnRjQWRkcmVzc30vcmlnczJcIilcbk5DU0hNS1QgPSBHRVQoXCJodHRwczovL2FwaTIubmljZWhhc2guY29tL21haW4vYXBpL3YyL21pbmluZy9tYXJrZXRzXCIpXG5cbnJhd1RvQ2hhcihOQ1NITUtUJGNvbnRlbnQpXG5NS1QgPSBmcm9tSlNPTihyYXdUb0NoYXIoTkNTSE1LVCRjb250ZW50KSlcbm5hbWVzKE1LVClcbmBgYCJ9 -->

```r
NCHSH = GET("https://api2.nicehash.com/main/api/v2/mining/external/{btcAddress}/rigs2")
NCSHMKT = GET("https://api2.nicehash.com/main/api/v2/mining/markets")

rawToChar(NCSHMKT$content)
MKT = fromJSON(rawToChar(NCSHMKT$content))
names(MKT)
```

<!-- rnb-source-end -->

<!-- rnb-chunk-end -->


<!-- rnb-text-begin -->







<!-- rnb-text-end -->

