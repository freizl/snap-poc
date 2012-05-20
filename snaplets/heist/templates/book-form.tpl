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
		<dfLabel ref="description" for="wmd-input">Description: </dfLabel>
		<div class="input">
          <div class="wmd-panel">
            <div id="wmd-button-bar"></div>
			<dfInputTextArea ref="description" class="wmd-input" id="wmd-input" />
          </div>
          <div id="wmd-preview" class="wmd-panel wmd-preview"></div>
		</div>
	</div>

	<div class="actions">
		<dfInputSubmit value="Submit" class="btn primary" />
	</div>

	</dfForm>
  </div>

  <bind tag="extra-scripts">
  <script type="text/javascript" src="/js/Markdown.Converter.js"></script>
  <script type="text/javascript" src="/js/Markdown.Sanitizer.js"></script>
  <script type="text/javascript" src="/js/Markdown.Editor.js"></script>
  <script>
    (function () {
      var converter1 = Markdown.getSanitizingConverter();
      var editor1 = new Markdown.Editor(converter1);
      editor1.run();
    })();
  </script>
  </bind>


</apply>
