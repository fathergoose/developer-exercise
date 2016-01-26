/* global document */
var hello = true; // eslint-disable-line

var actAccordion = document.getElementById('act-sections');

var sectionHeadings = document.getElementsByClassName('accordion-header');

var sectionContent = document.getElementsByClassName('accordion-content');

window.onload = function() {
  for (var i = 0; i < sectionContent.length; i++) {
    sectionContent[i].className = 'accordion-content closed';
  }

  for (var i = 0; i < sectionHeadings.length; i++) {
    sectionHeadings[i].getElementsByTagName('a')[0].addEventListener('click', toggleContent, false);
  }
};

function toggleContent(){
  console.log('hi',this.nextSibling.nextSibling);
  var content = this.nextSibling.nextSibling;
  if (content.className == 'accordion-content closed') {
    content.className = 'accordion-content open';
  } else {
    content.className = 'accordion-content closed';
  }
};
