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
		<dfLabel ref="description">Description: </dfLabel>
		<div class="input">
			<dfInputText ref="description" />
		</div>
	</div>

	<div class="clearfix">
		<dfLabel ref="language">Language: </dfLabel>
		<div class="input">
			<dfInputSelect ref="language" />
		</div>
	</div>

	<div class="actions">
		<dfInputSubmit value="Submit" class="btn primary" />
	</div>

	</dfForm>
  </div>

</apply>