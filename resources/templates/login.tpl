<apply template="hero">

  <bind tag="subtitle">Login Page</bind>

    <form method="post" action="login">
      <fieldset>
        <legand><test/></legand>
      </fieldset>

      <div class="clearfix">
        <label for="username">User Name</label>
        <div class="input">
          <input class="xlarge" id="username" name="username" size="30" type="text">
        </div>
      </div>

      <div class="clearfix">
        <label for="password">Password</label>
        <div class="input">
          <input class="xlarge" id="password" name="password" size="30" type="password">
        </div>
      </div>

      <div class="actions">
        <input type="submit" class="btn primary" value="Submit">&nbsp;<button type="reset" class="btn">Cancel</button>
      </div>
    </form>

    <form method="post" action="oauthlogin">
      <fieldset>
        <legand>OAuth Login</legand>
      </fieldset>

    <div class="clearfix">
      <label for="openidIdentify">OpenID</label>
      <div class="input">
        <input type="text" class="xlarge" id="openidIdentify" name="openid_identifier" /> 
        <input type="submit" value="Login" />
      </div>

    </div>

    </form>

    <!-- FIXME: add jquery; submit the form directly -->

    <a title="log in with Google" href="javascript:document.getElementById('openidIdentify').value=document.getElementsByTagName('a')[5].children[0].innerText;" 
       style="background: #fff url(http://cdn.sstatic.net/Img/openid/openid-logos.png?v=8); background-position: -1px -1px" 
       class="openid_large_btn">
      <span style="display: none;">https://www.google.com/accounts/o8/id</span>
    </a>

</apply>
