@Offerchat.module "WebsitesApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Base

    initialize: ->
      sites = App.request "site:entities"

      sitesView = @getWebsitesView sites

      @listenTo sitesView, "childview:click:delete:website", (site) =>
        if confirm("Are you sure you want to delete this website?")
          site.model.destroy()

      @listenTo sitesView, "childview:click:edit:website", (site) =>
        modalView = @getEditWebsiteModalView site
        formView  = App.request "modal:wrapper", modalView

        @listenTo formView, "modal:close", (item)->
          formView.close()

        App.modalRegion.show formView
        # @listenTo modalView, "click:close:modal", =>
        #   App.modalRegion.hideModal modalView

        # App.modalRegion.showModal formView

      App.mainRegion.show sitesView

    getWebsitesView: (sites) ->
      new List.Websites
        collection: sites

    getEditWebsiteModalView: (site) ->
      new List.ModalWebsite
        model: site.model