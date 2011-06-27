// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function noBack(){window.history.forward();}

function verify_delete()
{
if (document.getElementById('verify_delete').style.display == 'inline')
   document.getElementById('verify_delete').style.display = 'none';
else
   document.getElementById('verify_delete').style.display = 'inline';
}

function displayComments(myDiv) {
if (myDiv.style.display == 'inline')
  myDiv.style.display = 'none';
else
  myDiv.style.display = 'inline';
}

