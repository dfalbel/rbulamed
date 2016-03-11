#' Default URL
#' 
#' URL básico
#' @return o url básico do site que fornce os dados
#'
default_url <- function(){
  "http://www.medicinanet.com.br"
}

#' URL da lista de remédios por letra
#'
#' @param l letra
#' @return url da lista de remédios dada a letra
#'
url_letra <- function(l){
  paste0(default_url(), "/bulas/", l, ".htm")
}


#' Lista remédios por letra
#'
#' @param l letra
#' @return data.frame com nome do remédio e url p/ bula
#'
#' @export
lista_remedios <- function(l){
  lst <- httr::GET(url_letra(l)) %>%
    httr::content() %>%
    rvest::html_nodes("#ancTop") %>%
    rvest::html_nodes("a")
  df <- dplyr::data_frame(
    nome = lst %>% rvest::html_text(),
    link = lst %>% rvest::html_attr("href")
  )
  return(df)
}


#' Texto Bula
#'
#' @rdname textobula
#' @param url url p/ a bula do remédio
#' @param time tempo entre cada requisição p/ não bloquear
#' @param progress indica se você quer ter uma barra de progresso
#' @return texto inteiro da bula do remédio
#' @note o texto pode conter partes indesejadas, como avisos do site
#' em que foi feito webscrapping.
#'
#'
texto_bula <- function(url){
  p <- httr::GET(paste0(default_url(), url))
  texto <- p %>% 
    httr::content() %>%
    rvest::html_nodes("#texto") %>%
    rvest::html_text()
  return(texto)
}

#' Texto de vários urls
#'
#' @rdname textobula
#' @export
texto_bulas <- function(url, time = 0.5, progress = T){
  progress <- ifelse(progress, "text", "none")
  plyr::laply(url, function(x) {
    text <- texto_bula(x)
    Sys.sleep(time)
    return(text)
  },
  .progress = progress
  )
}

#' Pegar nome de todos os remédios
#'
#' @return lista de todos os remédios
#' @note essa função procura remédios com todas as letras do alfabeto.
#'
lista_todos_remedios <- function(progress = T){
  progress <- ifelse(progress, "text", "none")
  plyr::ldply(letters, lista_remedios, .progress = T)
}