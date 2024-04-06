module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Html.Attributes exposing (href)

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

translate: Language -> LangText msg -> Html msg
translate lang text =
  case lang of
  English -> text.english
  French -> text.french
  Chinese -> text.chinese

title: LangText msg
title = {
    english = text "Galileo Grey's Personal Website",
    french = text "Page Personnelle de Galileo Grey",
    chinese = text "加利略的个人网站"
    }

subtitle: LangText msg
subtitle = {
    english = text "2nd Year Bachelor's Student in Mathematics",
    french = text "Étudiant en 2eme année de Licence de Mathematiques",
    chinese = text "学习数学的大二学生"
    }


view : Model -> Html Msg
view model =
  let tr_lang = translate model.language in

  div [style "background-color" "#CDD6E4", style "width" "100%", style "height" "100%"] [

    Html.h1 [style "color" "#2161AB"][tr_lang title],
    Html.h2 [style "color" "#2161AB"][tr_lang subtitle],

    span [style "white-space" "pre-line"] [
      a [] [text "CV"],
      a [href "mailto: galileo.grey@etu.univ-grenoble-alpes.fr"] [text "Email"],
      a [href "https://github.com/GreyGalileo"] [text "Github"]
    ],

    span [style"" ""][],


    span [] [
    button [onClick (LanguageChange English)] [ text "English"],
    button [onClick (LanguageChange French)] [ text "Français"]
    --,button [onClick (LanguageChange Chinese)] [ text "简体汉字"]
    ]
  ]
  