  <apply template="hero">
    
<div class="hero-unit">
  <form name="checkout" action="/checkout/done/" method="post">
    <fieldset>
      <div> <h3>Address</h3> </div>
      
      <div>
        <label for="address1">Add 1: </label>
        <input id="address1" name="address1" type="text" value="Hu Bing Lu"/>
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
          <input type="text" name="pid" value="${pid}">
          </showProduct>
        </div>
      </fieldset>
      <input type="submit" value="Submit" id="submitCheckOut"/>
    </form>
  </div>
      

       <script type="text/javascript" src="http://jqueryjs.googlecode.com/files/jquery-1.3.2.min.js"></script>
       <script>
         $(document).ready(function() {
           $("input#submitCheckOut").click(function () { 
               //alert("DONE");
             })
         });
       </script>

     </apply>
