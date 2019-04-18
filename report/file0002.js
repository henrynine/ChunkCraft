var texts = new Array();
var states = new Array();

texts['fold000001'] = '<a href="javascript:fold(\'fold000001\');"><img border="0" height="10" width="10" src="plus.png" title="unfold code"/></a><i>&nbsp;&nbsp;code folded from line 1 to line 112</i>';
states['fold000001'] = false;
texts['fold000114'] = '<a href="javascript:fold(\'fold000114\');"><img border="0" height="10" width="10" src="plus.png" title="unfold code"/></a><i>&nbsp;&nbsp;code folded from line 114 to line 121</i>';
states['fold000114'] = false;
texts['fold000123'] = '<a href="javascript:fold(\'fold000123\');"><img border="0" height="10" width="10" src="plus.png" title="unfold code"/></a><i>&nbsp;&nbsp;code folded from line 123 to line 138</i>';
states['fold000123'] = false;
texts['fold000140'] = '<a href="javascript:fold(\'fold000140\');"><img border="0" height="10" width="10" src="plus.png" title="unfold code"/></a><i>&nbsp;&nbsp;code folded from line 140 to line 154</i>';
states['fold000140'] = false;
texts['fold000156'] = '<a href="javascript:fold(\'fold000156\');"><img border="0" height="10" width="10" src="plus.png" title="unfold code"/></a><i>&nbsp;&nbsp;code folded from line 156 to line 160</i>';
states['fold000156'] = false;
texts['fold000162'] = '<a href="javascript:fold(\'fold000162\');"><img border="0" height="10" width="10" src="plus.png" title="unfold code"/></a><i>&nbsp;&nbsp;code folded from line 162 to line 166</i>';
states['fold000162'] = false;
texts['fold000168'] = '<a href="javascript:fold(\'fold000168\');"><img border="0" height="10" width="10" src="plus.png" title="unfold code"/></a><i>&nbsp;&nbsp;code folded from line 168 to line 169</i>';
states['fold000168'] = false;
texts['fold000171'] = '<a href="javascript:fold(\'fold000171\');"><img border="0" height="10" width="10" src="plus.png" title="unfold code"/></a><i>&nbsp;&nbsp;code folded from line 171 to line 177</i>';
states['fold000171'] = false;
texts['fold000180'] = '<a href="javascript:fold(\'fold000180\');"><img border="0" height="10" width="10" src="plus.png" title="unfold code"/></a><i>&nbsp;&nbsp;code folded from line 180 to line 180</i>';
states['fold000180'] = false;
texts['fold000183'] = '<a href="javascript:fold(\'fold000183\');"><img border="0" height="10" width="10" src="plus.png" title="unfold code"/></a><i>&nbsp;&nbsp;code folded from line 183 to line 192</i>';
states['fold000183'] = false;
texts['fold000197'] = '<a href="javascript:fold(\'fold000197\');"><img border="0" height="10" width="10" src="plus.png" title="unfold code"/></a><i>&nbsp;&nbsp;code folded from line 197 to line 201</i>';
states['fold000197'] = false;
texts['fold000204'] = '<a href="javascript:fold(\'fold000204\');"><img border="0" height="10" width="10" src="plus.png" title="unfold code"/></a><i>&nbsp;&nbsp;code folded from line 204 to line 211</i>';
states['fold000204'] = false;
texts['fold000215'] = '<a href="javascript:fold(\'fold000215\');"><img border="0" height="10" width="10" src="plus.png" title="unfold code"/></a><i>&nbsp;&nbsp;code folded from line 215 to line 218</i>';
states['fold000215'] = false;
texts['fold000223'] = '<a href="javascript:fold(\'fold000223\');"><img border="0" height="10" width="10" src="plus.png" title="unfold code"/></a><i>&nbsp;&nbsp;code folded from line 223 to line 223</i>';
states['fold000223'] = false;
texts['fold000225'] = '<a href="javascript:fold(\'fold000225\');"><img border="0" height="10" width="10" src="plus.png" title="unfold code"/></a><i>&nbsp;&nbsp;code folded from line 225 to line 225</i>';
states['fold000225'] = false;
texts['fold000227'] = '<a href="javascript:fold(\'fold000227\');"><img border="0" height="10" width="10" src="plus.png" title="unfold code"/></a><i>&nbsp;&nbsp;code folded from line 227 to line 233</i>';
states['fold000227'] = false;

function fold(id) {
  tmp = document.getElementById(id).innerHTML;
  document.getElementById(id).innerHTML = texts[id];
  texts[id] = tmp;
  states[id] = !(states[id]);
}

function unfoldAll() {
  for (key in states) {
    if (states[key]) {
      fold(key);
    }
  }
}

function foldAll() {
  for (key in states) {
    if (!(states[key])) {
      fold(key);
    }
  }
}
