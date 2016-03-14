<!-- README.md is generated from README.Rmd. Please edit that file -->
rbulamed
========

Baixar as bulas de diversos remédios que estão disponíveis no site <http://www.medicinanet.com.br>

Instalação
==========

Para instalar o pacote use:

``` r
devtools::install_github("dfalbel/rbulamed")
```

Uso simples
===========

``` r
library(rbulamed)
lst_remedios <- lista_todos_remedios()
bulas <- texto_bulas(lst_remedios$link)
```
