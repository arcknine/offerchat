@Offerchat.module "NavigationApp.Show", (Show, App, Backbone, Marionette, $, _) ->

  class Show.Controller extends App.Controllers.Base

    initialize: ->
      user_json = App.request "get:current:user:json"
      user = App.request "set:current:user", user_json

      navView = @getNavView user

      @listenTo navView, "profile:status:toggled", (child) ->
        params =
          element: child
          openClass: "profile-status"
          activeClass: false

        navView.toggleDropDown(params)

      @listenTo navView, "profile:settings:toggled", (child) ->
        params =
          element: child
          openClass: "profile-settings"
          activeClass: false

        navView.toggleDropDown(params)

      @listenTo navView, "root:path:clicked", (child) ->
        App.navigate Routes.root_path(), trigger: true
        @hideDropdowns child

      @listenTo navView, "account:menu:clicked", (child) ->
        App.navigate Routes.profiles_path(), trigger: true
        @hideDropdowns child

      @listenTo navView, "websites:menu:clicked", (child) ->
        App.navigate Routes.websites_path(), trigger: true
        @hideDropdowns child

      @listenTo navView, "agent:menu:clicked", (child) ->
        App.navigate Routes.agents_path(), trigger: true
        @hideDropdowns child

      @listenTo navView, "history:menu:clicked", (child) ->
        params =
          element: child
          openClass: "history-menu-link"
          activeClass: false
        navView.toggleDropDown(params)

        # @hideDropdowns child

      @listenTo navView, "reports:menu:clicked", (child) ->
        params =
          element: child
          openClass: "reports-menu-link"
          activeClass: false
        navView.toggleDropDown(params)

      @listenTo navView, "agent:menu:clicked", (child) ->
        @hideDropdowns child

      # @listenTo navView, "knowlegdebase:menu:clicked", (child) ->
      #   console.log child

      # @listenTo navView, "integrations:menu:clicked", (child) ->
      #   console.log child

      # @listenTo navView, "labs:menu:clicked", (child) ->
      #   console.log child

      App.navigationRegion.show navView

    getNavView: (user)->
      new Show.Nav
        model: user

    hideDropdowns: (child) ->
      childViews = $(child.view.el)
      dropdowns  = childViews.find(".dropdowns")

      $.each dropdowns, (key, value) ->
        unless $(value).hasClass("hide")
          $(value).addClass("hide")
          $(value).prev().removeClass("active")