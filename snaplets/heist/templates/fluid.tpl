<apply template="page" >

  <!-- Navigation -->
<div class="topbar">
  <div class="topbar-inner">
    <div class="container-fluid">
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

  <div class="container-fluid">
    <div class="sidebar">
      <div class="well">
        <h5>Category</h5>
        <ul>
          <tagsList>
            <li><a href="/tags/${oid}"><name/></a></li>
          </tagsList>
        </ul>
      </div>
    </div>

    <content />

  </div>
</apply>
