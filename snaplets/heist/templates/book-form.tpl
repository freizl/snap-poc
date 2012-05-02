<apply template="hero">

  <bind tag="subtitle">: Add new Book</bind>
  
  <div class="content">

	<dfForm action="/book">
	<dfChildErrorList ref="" />

    <div class="clearfix">
		<dfLabel ref="name">Name: </dfLabel>
		<div class="input">
			<dfInputText ref="name" />
		</div>
	</div>

	<div class="clearfix">
		<dfLabel ref="language">Language: </dfLabel>
		<div class="input">
			<dfInputSelect ref="language" />
		</div>
	</div>

	<div class="clearfix">
		<dfLabel ref="description">Description: </dfLabel>
		<div class="input">
          <div class="wmd-panel">
            <div id="wmd-button-bar"></div>
<!--		 id="wmd-input". Buggy: pagedown editor find elements by ids but df set its default id value -->
			<dfInputTextArea ref="description" class="wmd-input" />
          </div>
          <div id="wmd-preview" class="wmd-panel wmd-preview"></div>
		</div>
	</div>

	<div class="actions">
		<dfInputSubmit value="Submit" class="btn primary" />
	</div>

	</dfForm>
  </div>

</apply>
