# FLP - Logický projekt (Prolog), Hamiltonovské kružnice
Autor: Tereza Burianová (xburia28)

Akademický rok: 2023/2024

## Použitá metoda řešení
Po samotném načtení vstupu jsou vstupní vztahy mezi vrcholy (hrany) zaznamenány pomocí dynamického predikátu `rel`. Tento predikát je dále rozšířen pomocí predikátu `nodes_related`, který znázorňuje, že graf je neorientovaný - vztah mezi vrcholy platí oboustranně.

Metodou zvolenou pro hledání hamiltonovských kružnic je brute force, kde jsou v `path` rekurzivně prohledávány stále nenavštívené vrcholy dostupné z aktuálního vrcholu, který je ze seznamu nenavštívených vrcholů odstraněn. Ukončujícími podmínkami rekurze jsou prázdný seznam nenavštívených vrcholů a existence hrany mezi aktuálním a výsledným vrcholem.

## Návod k použití
Program může být přeložen v kořenové složce pomocí příkazu `make` a spuštěn pomocí příkazu `./flp23-log`. Následně očekává vstup na standardním vstupu, výstup je vypsán na standardní výstup.

Příklad validního vstupu:
```
A B
A C
A D
B C
B D
C D
```
Příklad výstupu:
```
A-B A-C B-D C-D
A-B A-D B-C C-D
A-C A-D B-C B-D
```

## Testovací vstupy
K řešení je přiloženo několik vstupů, na kterých bylo řešení testováno. Jedná se o grafy s hamiltonovskými kružnicemi, nalezeny na internetu a sdíleny spolužáky z minulých let.

Program může být s těmito vstupy spuštěn následujícím způsobem (X je číslo daného vstupu):
```
./flp23-log < input/input[cislo_vstupu].txt
```

Přibližná doba běhu testovacích vstupů na serveru merlin je zobrazena v následující tabulce:
| **Vstupní soubor** | **Doba běhu (ms)** |
|--------------------|--------------------|
| input1.txt         |                 14 |
| input2.txt         |                 15 |
| input3.txt         |                 16 |
| input4.txt         |                 13 |
| input5.txt         |                 15 |
| input6.txt         |                 14 |
| input7.txt         |             12 760 |

## Omezení
Program očekává pouze validní formát vstupu v souladu se zadáním projektu.