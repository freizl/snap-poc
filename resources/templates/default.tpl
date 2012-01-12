<apply template="page">

  <div id="container">
    <h1>All nice things</h1>

    <div class="sidebar">
      <h6>Category</h6>
      <tagsList>
        <ul>
          <li><a href="/tags/${oid}"><name/></a></li>
        </ul>
      </tagsList>
    </div>
      
      <ifLoggedIn>
        <h3>Welcome: <user-id/></h3>
      </ifLoggedIn>

    <content />

  </div>
</apply>
