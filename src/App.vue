<template lang="pug">
  router-view
</template>

<script>
import SignIn from './components/SignIn'

export default {
  name: 'App',
  components: {
    SignIn
  }
}
</script>

<style lang="stylus">
  @media (min-width: 580px)
      .mobile
          display none

  @media (max-width: 360px)
      .tablet
          display none

  h1
      margin-top 0

  div
      &.container-fluid
          max-width 580px
          margin-left auto
          margin-right auto
          text-align left
          padding 0
          padding-bottom 10px

  .navbar-toggle
      background-color #428bca
      width 100%
      position absolute
      top 0px
      height 30px
      margin 0
      float none
      z-index 1
      margin-bottom -30px
      .glyphicon
          margin-top -5px
          padding-left 10px

  .navbar
      margin 0
      min-height 40px

  .navbar-collapse
      &.in
          overflow-y visible

  #connection
      display none

  .numpad .btn,
  .tippad .btn
      margin-bottom 5px
      width 6em

  .numpad h2,
  .tippad h2
      margin-bottom 2px
      margin-top 1px

  .numpad
      width 26em

  .rates
      margin-top -15px
      h2
          .label
              font-size 14px
              position relative
              top -5px

  #slide
      height 1.8em
      width 100%
      margin-bottom 2px

  @media (max-width: 360px)
      .tippad
          .btn
              width 4.3em
      .numpad
          .btn
              width 5.7em
      .rates
          width 100%
          text-align left
      #address
          font-size 16px

  .numpad,
    .tippad,
    .rates,

  #payment
      h2
          margin-bottom 2px

  .no-transition
      -webkit-transition height 0.01s
      -moz-transition height 0.01s
      -ms-transition height 0.01s
      -o-transition height 0.01s
      transition height 0.01s

  #nav
      .nav
          margin-top 30px
          li
              a
                  padding 10px 0 10px 10px

  .form-group
      label
          font-weight normal
          font-size 14px
          display block
      .form-control
          height auto
          padding 3px
          display inline-block
      .input-group-addon
          color #000
      .input-group-btn
          padding-top 24px
      .form-control-feedback
          margin-top 24px

  .form-group p,
  .form-group span,
  .form-group .form-control
      font-size 18px

  .form-group span,
  .form-group label
      color #999

  div#calculator
      #amount
          width 5em
      #received
          font-size 16px
          width 100%
      strong#total
          font-size 30px
      #address
          padding-top 10px
          a
              color #fff
              text-decoration none
      #title
          display none
          a
              color #000
              text-decoration none
      #logo
          display none
          padding 10px 0
          margin-bottom 10px
          max-height 225px
          width 100%
      #error
          margin-top 10px
      #qr
          padding-bottom 10px
          margin-left 20px
      .numpad
          .btn-primary
              background #abc

  td
      &.total
          font-weight bold
          text-align right

  #main-logo
      background-image url('/static/img/coinos_logo.png')
      width 300px
      height 80px
      margin-top 10px
      margin-bottom 10px

  .svg
      #main-logo
          background-image url('/static/img/coinos_logo.svg') !important
          background-size 300px 80px

  @page
      margin 0
</style>