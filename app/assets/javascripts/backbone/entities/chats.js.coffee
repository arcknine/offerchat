@Offerchat.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Visitor extends App.Entities.Model
    defaults:
      jid: "Visitor"

  class Entities.VisitorsCollection extends App.Entities.Collection

  class Entities.Message extends App.Entities.Model

  class Entities.MessagesCollection extends App.Entities.Collection

  API =
    setVisitor: ->
      new Entities.Visitor

    visitors: ->
      new Entities.VisitorsCollection

    setMessage: (message) ->
      new Entities.Message message

    messages: ->
      new Entities.MessagesCollection

  App.reqres.setHandler "visitor:entity", ->
    API.setVisitor()

  App.reqres.setHandler "visitors:entities", ->
    API.visitors()

  App.reqres.setHandler "message:entity", (message) ->
    API.setMessage message

  App.reqres.setHandler "messeges:entities", ->
    API.messages()