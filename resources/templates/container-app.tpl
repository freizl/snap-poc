<apply template="page" >

  <!-- Navigation -->
<div class="topbar">
  <div class="topbar-inner">
    <div class="container">
      <a class="brand" href="#">Happy Snap</a>
      <nav />

      <ifLoggedIn>
        <a href="/logout">Log Out</a>
      </ifLoggedIn>
      <ifLoggedOut>
        <form action="" class="pull-right">
          <input class="input-small" type="text" placeholder="Username"/>
          <input class="input-small" type="password" placeholder="Password"/>
          <button class="btn" type="submit">Sign in</button>
        </form>
      </ifLoggedOut>
    </div>
  </div>
</div>

  <div class="container">
    <content />
  </div>

</apply>
