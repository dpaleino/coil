<%inherit file="base.tpl" />
<%block name="head">
</%block>
<%block name="content">
<h1 class="title">Editing ${post.title()}</h1>
<form method="POST" class="form-horizontal" role="form" id="form" onsubmit="contentToTextarea()">
    % for k,v in post.meta['en'].items():
        <div class="form-group">
            <label for="${k}" class="col-sm-2 control-label">${k}</label>
            <div class="col-sm-10">
                <input name="${k}" value="${v}" class="form-control">
            </div>
        </div>
    % endfor

        <div id="toolbar">
          <a data-wysihtml5-command="bold">bold</a>
          <a data-wysihtml5-command="italic">italic</a>
          <a data-wysihtml5-command="formatBlock" data-wysihtml5-command-value="h1">H1</a>
          <a data-wysihtml5-command="formatBlock" data-wysihtml5-command-value="p">P</a>
          <a data-wysihtml5-command="bold" title="CTRL+B">bold</a> |
          <a data-wysihtml5-command="italic" title="CTRL+I">italic</a> |
          <a data-wysihtml5-command="createLink">link</a> |
          <a data-wysihtml5-command="removeLink"><s>link</s></a> |
          <a data-wysihtml5-command="insertImage">insert image</a> |
          <a data-wysihtml5-command="formatBlock" data-wysihtml5-command-value="h1">h1</a> |
          <a data-wysihtml5-command="formatBlock" data-wysihtml5-command-value="h2">h2</a> |
          <a data-wysihtml5-command="formatBlock" data-wysihtml5-command-blank-value="true">plaintext</a> |
          <a data-wysihtml5-command="insertUnorderedList">insertUnorderedList</a> |
          <a data-wysihtml5-command="insertOrderedList">insertOrderedList</a> |
          <a data-wysihtml5-command="foreColor" data-wysihtml5-command-value="red">red</a> |
          <a data-wysihtml5-command="foreColor" data-wysihtml5-command-value="green">green</a> |
          <a data-wysihtml5-command="foreColor" data-wysihtml5-command-value="blue">blue</a> |
          <a data-wysihtml5-command="undo">undo</a> |
          <a data-wysihtml5-command="redo">redo</a> |
          <a data-wysihtml5-command="insertSpeech">speech</a>
          <a data-wysihtml5-action="change_view">switch to html view</a>
          <div data-wysihtml5-dialog="createLink" style="display: none;">
            <label>
              Link:
              <input data-wysihtml5-dialog-field="href" value="http://">
            </label>
            <a data-wysihtml5-dialog-action="save">OK</a>&nbsp;<a data-wysihtml5-dialog-action="cancel">Cancel</a>
          </div>
          <div data-wysihtml5-dialog="insertImage" style="display: none;">
            <label>
              Image:
              <input data-wysihtml5-dialog-field="src" value="http://">
            </label>
            <label>
              Align:
              <select data-wysihtml5-dialog-field="className">
                <option value="">default</option>
                <option value="wysiwyg-float-left">left</option>
                <option value="wysiwyg-float-right">right</option>
              </select>
            </label>
          </div>

<hr/>
<div id="content-editor" data-placeholder="Go on, start editing..."></div>
<textarea name="content" id="content" style="display: none;"></textarea>
<button formaction="/save/${post.source_path}"><span class="glyphicon glyphicon-save"></span> Save</button>
</form>
<script src="/static/js/wysihtml5x-toolbar.min.js"></script>
<script src="/static/js/rules/advanced_and_extended.js"></script>
<script type="text/javascript">
  document.getElementById('content-editor').innerHTML = ${json.dumps(open(path).read().split('\n\n', 1)[1])};
  
    var editor = new wysihtml5.Editor('content-editor', {
    toolbar: 'toolbar',
    parserRules:  wysihtml5ParserRules
  });
  
  function contentToTextarea(){
    var form=document.getElementById('form');
    if(!form){
     return;
    }

    var div=document.getElementById('content-editor');
    var textarea=document.getElementById('content');
    textarea.value = div.innerHTML;
    return "success";
  }
</script>
</%block>
