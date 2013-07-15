@Offerchat.module "AgentsApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Base

    initialize: ->
      @layout = @getLayoutView()
      user = App.request("get:current:user:json")
      agents = App.request "agents:entities"
      @websites = App.request "site:entities"
      @sites = App.request "site:new:entity"


      App.execute "when:fetched", @websites, =>
        self = @
        @websites.each (item) ->
          if item.get("owner_id") is user.id
            self.sites.add item

      @layout.on "show", =>
        @showAgents agents

      App.mainRegion.show @layout

    showSeats: (seats) ->
      seatsView = @getSeatsView seats
      @layout.seatsRegion.show seatsView

    showAgents: (agents) ->
      agentsView = @getAgentsView agents
      @listenTo agentsView, "childview:agent:selection:clicked", (item)->

        showAgentView = @getShowAgentView(item.model, @sites)
        modalAgentView = App.request "modal:wrapper", showAgentView

        @listenTo modalAgentView, "modal:close", (item)->
          modalAgentView.close()

        App.modalRegion.show modalAgentView

      @layout.agentsRegion.show agentsView

    getLayoutView: ->
      new List.Layout

    getAgentsView: (agents) ->
      new List.Agents
        collection: agents

    getSeatsView: (seats) ->
      new List.Seats seats

    getShowAgentView: (model, websites) ->
      new List.ShowAgent
        model: model
        websites: websites
