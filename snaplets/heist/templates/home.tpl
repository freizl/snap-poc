
<apply template="fluid">
  <bind tag="subtitle">: Home</bind>
  
  <div class="content">
  
    <!-- Main hero unit for a primary marketing message or call to action -->
    <div class="hero-unit">
      <h1>Hello, world!</h1>
      <ifLoggedIn>
        <h3>Welcome: <user-id/></h3>
      </ifLoggedIn>
      <p>Vestibulum id ligula porta felis euismod semper. Integer posuere erat.</p>
      <p><a class="btn primary large">Learn more &raquo;</a></p>
      <p><debug-info author="Simon">2</debug-info></p>
    </div>

    <!-- Example row of columns -->
    <div class="row">
      <popularProducts>
        <div class="span">
          <h2><pname/></h2>
          <p>ID: <pid/>, NAME: <pname/></p>
          <p><a class="btn" href="/product/${pid}">View details &raquo;</a></p>
        </div>
      </popularProducts>
    </div>
    <hr />
  </div>

</apply>
