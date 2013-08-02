@Offerchat.module "AccountsApp.Profile", (Profile, App, Backbone, Marionette, $, _) ->

  class Profile.Layout extends App.Views.Layout
    template: "accounts/profile/layout"
    tagName: "span"

    regions:
      accountSidebarRegion:                       "#accounts-sidebar-region"
      accountRegion:                              "#accounts-main-region"

  class Profile.Navs extends App.Views.ItemView
    template: "accounts/profile/sidebar"
    triggers:
      "click a" :                                 "nav:clicked"
      "click a.profile" :                         "nav:accounts:clicked"
      "click a.password" :                        "nav:password:clicked"
      "click a.invoices" :                        "nav:invoices:clicked"
      #"click a.notifications" :                   "nav:notifications:clicked"

  class Profile.View extends App.Views.Layout
    template: "accounts/profile/profile"
    regions:
      uploadPhotoRegion:                          "#upload-photo-profile-region"
      editProfileRegion:                          "#edit-profile-region"
    events:
      "click .block-message a.close" :  "closeNotification"

    closeNotification: (e) ->
      $(e.currentTarget).parent("div").fadeOut()

  class Profile.Photo extends App.Views.ItemView
    template: "accounts/profile/upload_photo"
    className: "form"
    triggers:
      "click div.btn-action-selector"   : "change:photo:clicked"
      "change input.file-input"         : "upload:button:change"
      "blur input.file-input"           : "upload:button:blur"
    modelEvents:
      "change"                          : "render"
    form:
      buttons:
        nosubmit: false
        primary: false
        cancel: false

    onShow: ->
      self = @
      @$el.fileupload
        url: Routes.update_avatar_profiles_path()
        formData: {authenticity_token: App.request("csrf-token")}
        add: (e, data) ->
          types = /(\.|\/)(gif|jpe?g|png)$/i
          file = data.files[0]
          if types.test(file.type) || types.test(file.name)
            App.request "show:preloader"
            data.submit().done (e,data)->
              self.model.set
                avatar: e.avatar
              App.execute "avatar:change", e.avatar
              App.request "hide:preloader"
              self.trigger "show:notification", "Your avatar have been saved!"
          else
            self.trigger "show:notification", "#{file.name} is not a gif, jpeg, or png image file"

        done: (e, data) ->
          # after upload


  class Profile.Edit extends App.Views.ItemView
    template: "accounts/profile/edit"
    className: "form"
    form:
      buttons:
        nosubmit: false
        primary: "Save Changes"
        cancel: false