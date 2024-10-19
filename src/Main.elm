module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Html.Attributes exposing (href)
import Bootstrap.Utilities.Flex as Flex
import Html.Attributes exposing (download)

-- MAIN
main =
  Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }

-- MODEL
type alias Model =
  {language : Language}


init : () -> (Model, Cmd Msg)
init _ =
  (Model English, Cmd.none)



-- UPDATE

type Language = English | French | Chinese --| German
type Msg = LanguageChange Language


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
  LanguageChange lang -> (Model lang, Cmd.none)
    
        
-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


-- VIEW
type alias LangText msg = {english: Html msg, french: Html msg, chinese: Html msg}

type alias LangAttr msg = {english: Attribute msg, french: Attribute msg, chinese: Attribute msg}

translate: Language -> LangText msg -> Html msg
translate lang text =
  case lang of
  English -> text.english
  French -> text.french
  Chinese -> text.chinese

title: LangText msg
title = {
    english = text "Galileo Grey",
    french = text "Galileo Grey",
    chinese = text "加利略的个人网站"
    }

subtitle: LangText msg
subtitle = {
    english = text "3rd Year Bachelor's Student in Mathematics",
    french = text "Étudiant en 3eme année de Licence de Mathematiques",
    chinese = text "学习数学的大二学生"
    }                             

text_cv : LangText msg
text_cv = {
    english = text "CV (english)",
    french = text "CV (français)",
    chinese = text "CV (英文)"
    }

lagrange = {
    english = text "Interactive Lagrange interpolation",
    french = text "Interpolation de Lagrange interactive",
    chinese = text "拉格朗日内插"
    }

internship_report1 = {
  english = text "Laboratoire Jean Kutzmann internship report",
  french = text "Rapport de stage Laboratoire Jean Kuntzmann",
  chinese = text "___cn___"
  }

internship_report2 = {
  english = text "Institut Fourier internship report",
  french = text "Rapport de stage Institut Fourier",
  chinese = text "___cn___"
  }


translate_attribute: Language -> LangAttr msg -> Attribute msg
translate_attribute lang text =
  case lang of
  English -> text.english
  French -> text.french
  Chinese -> text.chinese


link_cv : LangAttr msg
link_cv = {
    english = href "../english_cv.pdf",
    french = href "../french_cv.pdf",
    chinese = href "../english_cv.pdf"
    }



view : Model -> Html Msg
view model =
  let tr_lang = translate model.language in 
  let tr_attr = translate_attribute model.language  in

  div [style "width" "100%", style "height" "100%"] [

    Html.h1 [style "color" "#2161AB", style "margin" "0px"][tr_lang title],
    Html.h2 [style "color" "#2161AB"][tr_lang subtitle],

    pre [style "white-space" "pre-line"] [
     p [style "margin" "1px"] [a [tr_attr link_cv] [tr_lang text_cv]],
     p [style "margin" "1px"] [a [href "mailto: galileo.grey@etu.univ-grenoble-alpes.fr"] [text "Email"]],
     p [style "margin" "1px"] [a [href "https://github.com/GreyGalileo"] [text "Github"]]
    ],
  div [style "width" "40%"][

        span [Flex.col] [
    div [Flex.row, Flex.justifyCenter, style "margin" "10px", style "border" "2px solid black", style "background-color" "#D3D3D3"] [
        h3 [] [text "Institut Fourier (2024)"],
        p [] [a [href "if_report.pdf"] [tr_lang internship_report2]]
      ]
    ],                                
  

    span [Flex.col] [
    div [Flex.row, Flex.justifyCenter, style "margin" "10px",  style "border" "2px solid black", style "background-color" "#D3D3D3"] [
        h3 [] [text "Laboratoire Jean Kuntzmann (2023)"],
        p [] [a [href "ljk_report.pdf"] [tr_lang internship_report1]],
        p [] [a [href "https://greygalileo.github.io/elm-interpolation/"] [tr_lang lagrange]]
      ]
    ]


      ],

      span [] [
      button [onClick (LanguageChange English)] [ text "English"],
      button [onClick (LanguageChange French)] [ text "Français"]
      --,button [onClick (LanguageChange Chinese)] [ text "简体汉字"]
      ]
    ]
