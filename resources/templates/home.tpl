<bind tag="subtitle">: Home</bind>

<apply template="default">
  <p><debug-info author="Simon">2</debug-info></p>
      <div class="content">
        <popularProducts>
          <table class="border-free-table">
            <tbody>
              <tr>
                <td><h5><pname/></h5></td>
              </tr>
              <tr>
                <td>ID: <pid/>, NAME: <pname/></td>
              </tr>
              <tr>
                <td><big><a href="/product/${pid}">More..</a></big> </td>
              </tr>
            </tbody>
          </table>
        </popularProducts>
      </div>

</apply>
