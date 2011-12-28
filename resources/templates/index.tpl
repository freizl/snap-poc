<apply template="wrap">

  <bind tag="subtitle">: Home</bind>
  
  <div class="container">
    <h2>All nice things</h2>
    <div class="content">
      <div class="row">
          <div class="span12">
            
            <popProductsSplice>
              <table class="border-free-table">
                <tbody>
                  <tr>
                    <td><h5>${name}</h5></td>
                  </tr>
                  <tr>
                    <td>ID: ${oid}, NAME: ${name}</td>
                  </tr>
                  <tr>
                    <td><big><a href="/product/${oid}">More></a></big> </td>
                  </tr>
                </tbody>
              </table>
              <hr>
            </popProductsSplice>
          </div>
          
          <div class="span4">
            <div class="sidebar">
              <h6>Category</h6>
              <tagsList>
                <ul>
                  <li><a href="/tags/${oid}"><name/></a></li>
                </ul>
              </tagsList>
            </div>
          </div>
          
      </div>
    </div>
  </div>
</apply>
