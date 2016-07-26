module Components.Story exposing (..)

import Html exposing (Html, div, h4, text)
import Html.Attributes exposing (id, class)
import Html.Attributes.Extra exposing (innerHtml)
import Html.Events exposing (onClick)
import Model exposing (Item (..), ItemData, runWithDefault)
import Components.Comment as Comment exposing (comments)


type Msg = GoBack


view : Maybe Item -> Html Msg
view mbStory =
  let
    renderStory mbStory =
      case mbStory of
        Just storyItem ->
          runWithDefault storyItem fullStory emptyStory

        Nothing ->
          emptyStory
  in
    div [ class "story" ] <| renderStory mbStory


emptyStory : List (Html a)
emptyStory =
  []


fullStory : ItemData -> List (Html Msg)
fullStory story =
  [ div [ class "story-title", onClick GoBack ]
      [ text story.title ]
  , div [ class "story-body" ]
      [ div [ class "story-text", innerHtml story.text ] []
      , div [ class "story-comments" ]
          <| comments story.kids
      ]
  ]
