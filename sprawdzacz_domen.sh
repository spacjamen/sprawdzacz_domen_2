#!/bin/bash

#==================== program sprawdzający wybrany rekord dla domen wczytanych z pliku ==============================
#====================================================================================================================



#============================= poniższa funkcja sprawdza wskazane rekordy ==========================================
function domena(){
	c=$(wc -l listadomen | sed 's/listadomen//g')		# wyznaczenie zmiennej wskazującej liczbę domen w pliku
	echo "Sprawdzę $c domen"				# wyświetlenie liczby domen do sprawdzenia
	#============= pętla wyliczająca kolejno domeny wraz z wybranym rejestrem ==================================
	for i in $(seq 1 $c); do
		a=$(cat -n listadomen | grep -E "\b$i\b" | sed 's/[0-9]*\s//g')	# zmienna przechowująca kolejną nazwę domeny
		b=$(dig +short $a $REKORD)					# zmienna przechowująca wybrany rejestr (skrócony)
		echo -n "Domena nr $i to: "; echo "$a"  
		echo "Oto jej rejestr $REKORD:"			# wyświetlenie nazwy wybranego rejestru
		echo "$b"					# wyświetlenie treści rejestru
		echo ""
	done
}


#=================== ta część pozwala wybrać typ rekordu do sprawdzenia ============================================
echo 'Witaj użytkownik '" $USER"'. Wybierz z listy rekord, który mam sprawdzić dla domen z pliku "listadomen"'
read REKORD
case "$REKORD" in
	"A")		echo "Sprawdzam rekord A"
		domena;;
	"AAAA")		echo "Sprawdzam rekord AAAA"
		domena;;
	"CNAME")	echo "Sprawdzam rekord CNAME"
		domena;;
	"MX")		echo "Sprawdzam rekord MX"
		domena;;
	"NS")		echo "Sprawdzam rekord NS"
		domena;;
	"SOA")		echo "Sprawdzam rekord SOA"
		domena;;
	"TXT")		echo "Sprawdzam rekord TXT"
		domena;;
	*)		echo "Nie ma takiej opcji";;
esac
