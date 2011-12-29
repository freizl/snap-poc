
<apply template="default">

  <bind tag="subtitle">: Product Detail</bind>

  <div class="detail-container">
    <h2>Product Detail.</h2>

    <showProduct>
      <div class="part-1">
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
        <a href="checkout/${pid}" class="checkout">Check Out</a>
      </div>
    </showProduct>


    <a href="/">Return</a>

  </div>
  
</apply>
