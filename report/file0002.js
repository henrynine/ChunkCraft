var texts = new Array();
var states = new Array();

texts['fold000001'] = '<a href="javascript:fold(\'fold000001\');"><img border="0" height="10" width="10" src="plus.png" title="unfold code"/></a><i>&nbsp;&nbsp;code folded from line 1 to line 112</i>';
states['fold000001'] = false;
texts['fold000114'] = '<a href="javascript:fold(\'fold000114\');"><img border="0" height="10" width="10" src="plus.png" title="unfold code"/></a><i>&nbsp;&nbsp;code folded from line 114 to line 121</i>';
states['fold000114'] = false;
texts['fold000123'] = '<a href="javascript:fold(\'fold000123\');"><img border="0" height="10" width="10" src="plus.png" title="unfold code"/></a><i>&nbsp;&nbsp;code folded from line 123 to line 138</i>';
states['fold000123'] = false;
texts['fold000140'] = '<a href="javascript:fold(\'fold000140\');"><img border="0" height="10" width="10" src="plus.png" title="unfold code"/></a><i>&nbsp;&nbsp;code folded from line 140 to line 148</i>';
states['fold000140'] = false;
texts['fold000150'] = '<a href="javascript:fold(\'fold000150\');"><img border="0" height="10" width="10" src="plus.png" title="unfold code"/></a><i>&nbsp;&nbsp;code folded from line 150 to line 154</i>';
states['fold000150'] = false;
texts['fold000156'] = '<a href="javascript:fold(\'fold000156\');"><img border="0" height="10" width="10" src="plus.png" title="unfold code"/></a><i>&nbsp;&nbsp;code folded from line 156 to line 160</i>';
states['fold000156'] = false;
texts['fold000162'] = '<a href="javascript:fold(\'fold000162\');"><img border="0" height="10" width="10" src="plus.png" title="unfold code"/></a><i>&nbsp;&nbsp;code folded from line 162 to line 166</i>';
states['fold000162'] = false;
texts['fold000168'] = '<a href="javascript:fold(\'fold000168\');"><img border="0" height="10" width="10" src="plus.png" title="unfold code"/></a><i>&nbsp;&nbsp;code folded from line 168 to line 181</i>';
states['fold000168'] = false;
texts['fold000183'] = '<a href="javascript:fold(\'fold000183\');"><img border="0" height="10" width="10" src="plus.png" title="unfold code"/></a><i>&nbsp;&nbsp;code folded from line 183 to line 195</i>';
states['fold000183'] = false;
texts['fold000197'] = '<a href="javascript:fold(\'fold000197\');"><img border="0" height="10" width="10" src="plus.png" title="unfold code"/></a><i>&nbsp;&nbsp;code folded from line 197 to line 198</i>';
states['fold000197'] = false;
texts['fold000200'] = '<a href="javascript:fold(\'fold000200\');"><img border="0" height="10" width="10" src="plus.png" title="unfold code"/></a><i>&nbsp;&nbsp;code folded from line 200 to line 200</i>';
states['fold000200'] = false;
texts['fold000202'] = '<a href="javascript:fold(\'fold000202\');"><img border="0" height="10" width="10" src="plus.png" title="unfold code"/></a><i>&nbsp;&nbsp;code folded from line 202 to line 208</i>';
states['fold000202'] = false;
texts['fold000211'] = '<a href="javascript:fold(\'fold000211\');"><img border="0" height="10" width="10" src="plus.png" title="unfold code"/></a><i>&nbsp;&nbsp;code folded from line 211 to line 219</i>';
states['fold000211'] = false;
texts['fold000223'] = '<a href="javascript:fold(\'fold000223\');"><img border="0" height="10" width="10" src="plus.png" title="unfold code"/></a><i>&nbsp;&nbsp;code folded from line 223 to line 228</i>';
states['fold000223'] = false;
texts['fold000230'] = '<a href="javascript:fold(\'fold000230\');"><img border="0" height="10" width="10" src="plus.png" title="unfold code"/></a><i>&nbsp;&nbsp;code folded from line 230 to line 230</i>';
states['fold000230'] = false;
texts['fold000232'] = '<a href="javascript:fold(\'fold000232\');"><img border="0" height="10" width="10" src="plus.png" title="unfold code"/></a><i>&nbsp;&nbsp;code folded from line 232 to line 232</i>';
states['fold000232'] = false;
texts['fold000235'] = '<a href="javascript:fold(\'fold000235\');"><img border="0" height="10" width="10" src="plus.png" title="unfold code"/></a><i>&nbsp;&nbsp;code folded from line 235 to line 237</i>';
states['fold000235'] = false;

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
