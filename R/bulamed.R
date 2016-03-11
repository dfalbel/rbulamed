#' Pagina inicial
#'
url_inicial <- function(){
  "http://www.bulas.med.br/?C=A&V=66466F6C64657249443D3832"
}

#' Letras
#'
#' Páginas iniciais das letras
#'
paginas_letras <- function(){
  p <- httr::GET(url_inicial()) %>%
    httr::content() %>%
    rvest::html_nodes(".cx-step-wrapper") %>%
    html_nodes("a") %>%
    html_attr("href")
}