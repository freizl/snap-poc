<apply template="wrap">

  <bind tag="subtitle">: Home</bind>
  
  <div class="container">
    <h2>All nice things</h2>
    <div class="content">
      <div class="row">
          <div class="span12">
            
            <popularProducts>
              <table class="border-free-table">
                <tbody>
                  <tr>
                    <td><h5><pname/></h5><a href="${pname}">tst</a></td>
                  </tr>
                  <tr>
                    <td>ID: <pid/>, NAME: <pname/></td>
                  </tr>
                  <tr>
                    <td><big><a href="/product/${pid}">More..</a></big> </td>
                  </tr>
                </tbody>
              </table>
              <hr>
            </popularProducts>
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
