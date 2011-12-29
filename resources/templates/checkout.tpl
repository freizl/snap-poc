<!DOCTYPE html>
<html>
  <apply template="page-head"/>
  <body>
    
    <div id="main">
      <h1>Checking out...</h1>
      <div id="container">
        <form>
          <fieldset>
            <div> <h3>Address</h3> </div>
            <div>
              <input type="text"/>
            </div>
            <div><h3>Product List</h3></div>
            <div>
              <showProduct>
                <table>
                  <tr>
                    <td>PICTURES HERE</td>
                    <td><pid/></td>
                  </tr>
                  <tr>
                    <td>DETAILS</td>
                    <td><pname/></td>
                  </tr>
                </table>
              </showProduct>
            </div>
          </fieldset>
          <input type="submit" value="Submit" id="submitCheckOut"/>
        </form>
      </div>
      
      <apply template="page-footer"/>
    </div>

    <!-- 
       <script type="text/javascript" src="/media/js/site.js"> </script>
    -->
       <script type="text/javascript" src="http://jqueryjs.googlecode.com/files/jquery-1.3.2.min.js"></script>
       <script>
         $(document).ready(function() {
           $("input#submitCheckOut").click(function () { 
               alert("DONE");
             })
         });
       </script>

  </body>
</html>
