  <div id="heading">
    <div id="nav" class="nav">
      <ul class="nav">
        <li class="home">
          <a title="Home" href="/">Home</a>
        </li>
        <li>
          <a title="Sign in" href="/signup">Sign Up</a>
        </li>

      <ifLoggedIn>
        <li><a href="/logout">Log Out</a></li>
      </ifLoggedIn>
      <ifLoggedOut>
        <li><a href="/login">Log In</a></li>
      </ifLoggedOut>

      </ul>
    </div>
  </div>
