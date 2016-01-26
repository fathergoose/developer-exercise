/* global document */
var hello = true; // eslint-disable-line

var actAccordion = document.getElementById('act-sections');

var sectionHeadings = document.getElementsByClassName('accordion-header');

var sectionContent = document.getElementsByClassName('accordion-content');

window.onload = function() {
  for (var i = 0; i < sectionContent.length; i++) {
    sectionContent[i].className = 'accordion-content closed';
  }
};
