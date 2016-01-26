/* eslint-disable */
$(document).ready(function() {
  module("Accordion tests");

  test("example test", function() {
    ok(true);
  });

  test("hello exists", function() {
    ok(hello, "hello exists");
  });

  test("actAccordion is an object", function() {
    equal("object", typeof(actAccordion), "accordion is an object");
  });

  test("test sectionHeadings", function() {
    ok(sectionHeadings.length !=  0, "sectionsHeadings isn't empty");
  });

  test("sectionContent fullness", function() {
    ok(sectionContent.length != 0, "sectionsContent isn't empty");
  });

});
