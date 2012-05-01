<apply template="page" >

  <!-- Navigation -->
<div class="topbar">
  <div class="topbar-inner">
    <div class="container">
      <a class="brand" href="#">Happy Snap</a>
      <nav />
      <p class="pull-right">Logged in as
        <ifLoggedIn>
          <a href="/logout">Log Out</a>
        </ifLoggedIn>
        <ifLoggedOut>
          <a href="/login">Log In</a>
        </ifLoggedOut>
      </p>
    </div>
  </div>
</div>

  <div class="container">
    <content />
  </div>
</apply>
