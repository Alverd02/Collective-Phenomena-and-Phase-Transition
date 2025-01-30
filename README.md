# Collective-Phenomena-and-Phase-Transition
\documentclass{article}
\usepackage[total={7in, 8in}]{geometry}
\usepackage[utf8]{inputenc}
\usepackage{graphicx}
\graphicspath{{image/}}
\usepackage{float}
\usepackage{amsmath}
\usepackage{amssymb}

\title{%
  Pràctiques de Fenòmens col·lectius i transicions de fase\\
  \large Model de Ising en 2D}
\author{Albert Montané i Muñoz}
\date{Gener 2024}

\begin{document}

\maketitle

\section{Introducció teòrica}
\begin{enumerate}
\item \textbf{Hamiltonià del model d’Ising en unitats reduïdes.}\\
El Hamiltonià del model d'Ising en unitats reduïdes és el següent:
\begin{equation}
    H^* = -\sum_{<ij>}S_iS_j - h^*\sum_{i=1}^NS_i
\end{equation}
On $H^*= \frac{H}{J}$ i $h^* = \frac{h}{J}$.\\
En el nostre estudi, considerem el model amb camp magnètic $h = 0$. Per tant, acabem treballant amb:
\begin{equation}
    H^* = -\sum_{<ij>}S_iS_j
\end{equation}

\item \textbf{Propietats cadena de Markov per tenir distribució estacionària.}\\
Per garantir l'existència d'una distribució estacionaria, cal que la cadena de Markov compleixi les següents propietats:
\begin{itemize}
    \item C.M. irreduïble, és a dir, es pot arribar a qualsevol estat Y des de qualsevol estat X.
    \item C.M. aperiòdica, és a dir, des d'un estat X s'hi pot tornar en qualsevol nombre de passos.
\end{itemize}
\item \textbf{Distribució estacionaria dels mètodes Markov-Chain Monte-Carlo (MC-MC) pròpia de la col·lectivitat canònica.}\\
Volem que la probabilitat estacionaria sigui $\Pi(X) = \frac{f(X)}{Z}$. On $f(X) = e^{-\beta H^*(X)}$ i $Z = \int_{\Omega}e^{-\beta H^*(X)}dX$\\
Partim de l'equació de balanç detallat:
\begin{equation}
    W(Y->X)f(Y) = W(X->Y)f(X)
\end{equation}
Si ara ens centrem en el cas del factor de Boltzmann:
\begin{equation}
    W(Y->X) e^{-\beta H^*(Y)} = W(X->Y) e^{-\beta H^*(X)}
\end{equation}
\begin{equation}
    \frac{W(Y->X)}{W(X->Y)} = e^{-\beta [H^*(X)-H^*(Y)]}
\end{equation}
\item \textbf{Les cadenes de Markov de l’algorisme de Metròpolis compleixen balanç detallat i global.}\\
A l'algoritme de Metròpolis es proposa un canvi del tipus $T(X->Y) = T(Y->X)$, es tracta d'una probabilitat simètrica, i s'accepta o es rebutja d'acord amb una probabilitat d'acceptació $Q(X->Y)$. Per tant, $W(X->Y)=T(X->Y)Q(X->Y)$.\\ Substituïm a l'equació de balança detallat:
\begin{equation}
    \frac{W(X->Y)}{W(Y->X)}=\frac{T(X->Y)Q(X->Y)}{T(Y->X)Q(Y->X)}=\frac{Q(X->Y)}{Q(Y->X)}=e^{-\beta [H^*(X)-H^*(Y)]}
\end{equation}
Es condició suficient de balanç global.\\
Metròpolis va proposar fer servir $Q(X->Y) = min(1,e^{-\beta [H^*(Y)-H^*(X)]})$.\\
Quan s'accepta $e^{-\beta [H^*(Y)-H^*(X)]}>1$ i $Q(X->Y) = 1$. Això vol dir que el canvi $Q(Y->X)=e^{-\beta [H^*(X)-H^*(Y)]}$\\
\begin{equation}
    \frac{Q(X->Y)}{Q(Y->X)}=\frac{1}{e^{-\beta [H^*(X)-H^*(Y)]}} = e^{-\beta [H^*(Y)-H^*(X)]}   
\end{equation}
Per altra banda, quan es rebutja $e^{-\beta [H^*(Y)-H^*(X)]}<1$. $Q(Y->X)=1$ i $Q(X->Y)=e^{-\beta [H^*(Y)-H^*(X)]}$
\begin{equation}
    \frac{Q(X->Y)}{Q(Y->X)}=\frac{e^{-\beta [H^*(Y)-H^*(X)]}}{1} = e^{-\beta [H^*(X)-H^*(Y)]}
\end{equation}
\item \textbf{Matriu de probabilitat de proposta de canvi $T(X->Y)$ i una matriu de probabilitat d’acceptació $Q(X->Y)$ que compleixi balanç detallat en un sistema de 2 spins amb interacció ferromagnètica i un camp extern B.}\\
-El sistema de 2 spins pot prendre els valors +1 o -1.\\
-Interacció ferromagnètica entre els spins $(J>0)$.\\
-Camp extern (B) que afecta als spins.\\
L'energia en unitats reduïdes és: 
\begin{equation}
    E^* = -S_1S_2 - B^*(S_1+S_2)
\end{equation}
Que tindrà els següent valors possibles:\\
-$E^*(++) = -1- 2B^*$\\
-$E^*(+-) = +1$\\
-$E^*(--) = -1+ 2B^*$\\
-$E^*(-+) = +1$\\

Matriu de proposta per passar d'un estat a un altre amb un canvi de spin:
\begin{equation}
T = 
\begin{pmatrix}
0 & 1/2 & 1/2 & 0\\
1/2 & 0 & 0 & 1/2\\
1/2 & 0 & 0 & 1/2\\
0 & 1/2 & 1/2 & 0
\end{pmatrix}
\end{equation}
Com em vist abans $Q(X->Y) = min(1,e^{-\beta [H^*(Y)-H^*(X)]})$ i compleix el balanç detallat. Per tant:
\begin{equation}
Q = 
\begin{pmatrix}
0 & min(1,e^{+\beta 2[1+B^*]}) & min(1,e^{+\beta 2[1+B^*]}) & 0\\
min(1,e^{-\beta 2[1+B^*]}) & 0 & 0 & min(1,e^{-\beta 2[1-B^*]})\\
min(1,e^{-\beta 2[1+B^*]}) & 0 & 0 & min(1,e^{-\beta 2[1-B^*]})\\
0 & min(1,e^{+\beta 2[1-B^*]}) & min(1,e^{+\beta 2[1-B^*]}) & 0
\end{pmatrix}
\end{equation}

\section{Detalls de la simulació.}
\item \textbf{Simulació MC per 500 passes MC, a T=1.5 i emprant 5 llavors diferents. Configuració final de spins i el valor instantàni de magnetització i energia.}
\begin{figure}[H]
\centering
\begin{minipage}{.5\textwidth}
  \centering
  \includegraphics[width=1\linewidth]{6/conv_e_seeds.png}
  \caption{Convergència de la energia en funció dels passos(500) de Montecarlo per a diferents seeds a T = 1.5 i L=  48.}
  \label{fig:test1}
\end{minipage}%
\begin{minipage}{.5\textwidth}
  \centering
  \includegraphics[width=1\linewidth]{6/conv_m_seeds.png}
  \caption{Convergència de la magnetització en funció dels passos(500) de Montecarlo per a diferents seeds a T = 1.5 i L=  48.}
  \label{fig:test2}
\end{minipage}
\end{figure}

\begin{figure}[H]
\centering
\begin{minipage}{.5\textwidth}
  \centering
  \includegraphics[width=1\linewidth]{6/spins_48185051.jpeg}
  \caption{Configuració final dels spins amb seed 48185051 després de 500 passos de Montecarlo per a T = 1.5 i L=  48.}
  \label{fig:test1}
\end{minipage}%
\begin{minipage}{.5\textwidth}
  \centering
  \includegraphics[width=1\linewidth]{6/spins_48185052.jpeg}
  \caption{Configuració final dels spins amb seed 48185052 després de 500 passos de Montecarlo per a T = 1.5 i L=  48.}
  \label{fig:test2}
\end{minipage}
\end{figure}

\begin{figure}[H]
\centering
\begin{minipage}{.5\textwidth}
  \centering
  \includegraphics[width=1\linewidth]{6/spins_48185053.jpeg}
  \caption{Configuració final dels spins amb seed 48185053 després de 500 passos de Montecarlo per a T = 1.5 i L=  48.}
  \label{fig:test1}
\end{minipage}%
\begin{minipage}{.5\textwidth}
  \centering
  \includegraphics[width=1\linewidth]{6/spins_48185054.jpeg}
  \caption{Configuració final dels spins amb seed 48185054 després de 500 passos de Montecarlo per a T = 1.5 i L=  48.}
  \label{fig:test2}
\end{minipage}
\end{figure}

\begin{figure}[H]
\centering
  \centering
  \includegraphics[width=0.5\linewidth]{6/spins_48185055.jpeg}
  \caption{Configuració final dels spins amb seed 48185055 després de 500 passos de Montecarlo per a T = 1.5 i L=  48.}
  \label{fig:test1}
\end{figure}
El valor instantani de la energia i la magnetització per a cada seed:
\begin{itemize}
    \item 48185051: E = -4496.00 i M = 2274.00 
    \item 48185052: E = -4552.00 i M = 2290.00
    \item 48185053: E = -4492.00 i M = 2274.00
    \item 48185054: E = -4236.00 i M = 512.00
    \item 48185055: E = -4556.00 i M = -2290.00
\end{itemize}

Fixem-nos que per les cinc seeds la energia tendeix mes o menys al mateix valor. Aquest és el mes negatiu possible, ja que ens trobem a una temperatura baixa i el sistema tendeix a minimitzar la energia, que és d'esperar en una situació d'equilibri. Per altra banda, la magnetitzacio presenta un comportament esperat per totes les seed menys al 48185054. Per un lloc, tenim les quatre que tendeixen a ordenar el sistema sigui orientant els spins up o down, minimitzan així l'energia com es d'esperar. Per altra part, la seed 48185054 no arriba a tenir una orientació completament definida i la seva energia final es la que difereix més respecte les altres quatre. És possible que justament per aquesta seed, 500 passes de MC no siguin suficients per arribar a la convergència. En general en aquesta simulació s'utilitzaran de 7000 passes en endavant, així que 500 es queden molt curts.

\item \textbf{Evolució de la magnetització i energia en funció del nombre de passes MC.}

\begin{figure}[H]
\centering
\begin{minipage}{.5\textwidth}
  \centering
  \includegraphics[width=1\linewidth]{7/conv_e.png}
  \caption{Convergència de la energia en funció dels passos(7000) de Montecarlo per a diferents temperatures i L=  92.}
  \label{fig:test1}
\end{minipage}%
\begin{minipage}{.5\textwidth}
  \centering
  \includegraphics[width=1\linewidth]{7/conv_m.png}
  \caption{Convergència de la magnetització en funció dels passos(7000) de Montecarlo per a diferents temperatures i L=  92.}
  \label{fig:test2}
\end{minipage}
\end{figure}

Com podem veure, a mesura que augmentem la temperatura, augmenta l'energia. El sistema minimitza l'energia per temperatures baixes com T = 1.8, a partir de T = 2.6 augmenta però mes progressivament. Per tant, la temperatura crítica està entre 1.8 i 2.6. Per la magnetització, veiem com per temperatura baixa, el sistema està ordenat(spins alineats negativament per T = 1.8 i T = 2.1). Per T = 2.6 cap a munt, el valor esperat de la magnetització es zero perquè tenim dos fases coexistint ($m=\pm1$). La temperatura crítica deu estar al voltant de T = 2.3, veiem que te un comportament molt fluctuant, això es deu a que està transicionant de fase.

\item \textbf{Passes consecutives independents un cop assolida la distribució estacionaria.}

En general les mesures consecutives no són completament independents en general. Hi ha diferents factors que fan variar la dependència segons els estats anteriors.\\
La temperatura es un dels factors més importants. A temperatures altes, el sistema està molt desordenat de manera que el canvi d'un spin no suposa una variació molt significativa i els estats successius tendeixen a ser més independents. A temperatures baixes, quan el sistema està ordenat es tendeix a minimitzar l'energia i a rebutjar molts canvis d'spins per no augmentar l'energia, hi ha una forta correlació entre estats successius. A $T_c$ hi ha una longitud de correlació molt gran, de manera que els estats consecutius tenen correlacions significatives.\\
La mida del sistema també es rellevant quan parlem de correlacions. En un sistema gran, un petit canvi local no suposa una variació significativa.\\
Tambe és important fer un nombre gran de passes MC perquè per poques passades és possible que el sistema canviï de forma lenta i mantingui una correlació forta entre passes.
\item \textbf{Paràmetres MCINI i MCD}

Tenint en compte el que hem vist en els punts anteriors, per evitar tenir correlacions amb les passes anteriors introduïm els paràmetres MCINI i MCD. MCINI salta unes quantes passes inicials i MCD agafa configuracions cada cert nombre.\\
Veien les imatges podem veure que un $MCINI = 1000-2000$ seria idoni ja que amb aquestes passes ja s'ha assolit l'estat estacionari. Per $MCD = 10-20$ seria uns valors raonables.

\item \textbf{Dificultat de la temperatura baixa}

A baixa temperatura, la cadena de Markov presenta encara correlacions amb l'estat inicial. Això passa perquè a baixa temperatura l'espai de fases està separat en dues regions simètriques que corresponen a $M>0$ i $M<0$ i que estan separades per barreres energètiques molt difícils de saltar.\\
Per evitar això farem promitjos sobre diferents seeds començat amb configuracions inicials diferents. Hi ha la mateixa probabilitat d'estar en la regió $M>0$ que en la $M<0$, de manera que meitat de les seeds cauran a un costat i la meitat a l'altra.

\item \textbf{Temps d'execució}
\begin{itemize}
    \item T = 2.3 L = 8 MCTOT = 10000 CPUTIME = 8
    \item T = 2.3 L = 16 MCTOT = 10000 CPUTIME = 29.61
    \item T = 2.3 L = 32 MCTOT = 10000 CPUTIME = 121.46875
    \item T = 2.3 L = 64 MCTOT = 10000 CPUTIME = 491.203
    \item T = 2.3 L = 128 MCTOT = 10000 CPUTIME = 2075.297
\end{itemize}


\begin{figure}[H]
\centering
  \centering
  \includegraphics[width=0.5\linewidth]{11/temps.png}
  \caption{Dependència temporal en funció de L. T = 2.3, MCTOT = 10000 i nseed = 200}
  \label{fig:test1}
\end{figure}

Com es veu a la figura, fent un ajust parabòlic ens queda l'equació:
\begin{equation}
    y = 0.1337x^2 - 0.9848x + 10.453
\end{equation}

Seguint aquesta equació podem extrapolar quan pot trigar una simulació per MCTOT = 10000, T = 2.3 i L = 6114:
\begin{center}
    \item T = 2.3 L = 128 MCTOT = 10000 CPUTIME = 4991829
\end{center}

\section{Estudi del punt crític a partir de la simulació de model d'Ising.}

\item \textbf{Promitjos E, $|M|$, Xi i Cv en funció de T per a diferents L.}

\begin{figure}[H]
\centering
\begin{minipage}{.5\textwidth}
  \centering
  \includegraphics[width=1\linewidth]{12/e.png}
  \caption{Evolució de l'energia en funció de la temperatura per a diferents L.}
  \label{fig:test1}
\end{minipage}%
\begin{minipage}{.5\textwidth}
  \centering
  \includegraphics[width=1\linewidth]{12/m.png}
  \caption{Evolució del valor absolut de la magnetització en funció de la temperatura per a diferents L.}
  \label{fig:test2}
\end{minipage}
\end{figure}

\begin{figure}[H]
\centering
\begin{minipage}{.5\textwidth}
  \centering
  \includegraphics[width=1\linewidth]{12/x.png}
  \caption{Evolució de la susceptibilitat en funció de la temperatura per a diferents L.}
  \label{fig:test1}
\end{minipage}%
\begin{minipage}{.5\textwidth}
  \centering
  \includegraphics[width=1\linewidth]{12/c.png}
  \caption{Evolució de la capacitat calorífica en funció de la temperatura per a diferents L.}
  \label{fig:test2}
\end{minipage}
\end{figure}

Per les mesures de L = 32 i L = 64 s'ha utilitzat un rang de temperatures mes petit, al voltant del punt crític. Es veu clarament quina es la temperatura critica, quan l'energia o la magnetització canvien de fase i quan la capacitat calorífica o la susceptibilitat divergeixen.

\item \textbf{Temperatura crítica}

Amb les dades de les figures 13 i 14 farem ajustos parabòlics per trobar la temperatura critica en funció de L.

\begin{table}[H]
\centering
\begin{tabular}{|l|l|l|}
\hline
L  & Tc       & Cv(Tc)  \\ \hline
8  & 2.609943 & 6.155   \\ \hline
16 & 2.541387 & 6.01    \\ \hline
32 & 2.39     & 7.3513  \\ \hline
48 & 2.35     & 7.8025  \\ \hline
64 & 2.33     & 9.40396 \\ \hline
\end{tabular}
\caption{Taula amb el valor de la temperatura crítica per diferents mides del sistema i el seu pic de Cv.}
\end{table}

\begin{table}[H]
\centering
\begin{tabular}{|l|l|l|}
\hline
L  & Tc   & X(Tc)    \\ \hline
8  & 2.66 & 1.66078  \\ \hline
16 & 2.50 & 5.317032 \\ \hline
32 & 2.40 & 15.3395  \\ \hline
48 & 2.36 & 28.61348 \\ \hline
64 & 2.36 & 31.6916  \\ \hline
\end{tabular}
\caption{Taula amb el valor de la temperatura crítica per diferents mides del sistema i el seu pic de X.}
\end{table}

Els pics que es mostren a les taules no coincideixen amb els pics de les figures 13 i 14 sobretot per mies grans. Això es deu a l'ajut parabòlic no es perfecte i encara que estiguen molt aprop del punt crític, petites diferencies comporten canvis molt grans a Cv i X.
\end{enumerate}
\end{document}
