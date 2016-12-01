require "./spec_helper"

# tests are loosely based off of W3C site
# http://www.w3.org/2008/xmlsec/Drafts/c14n-20/test-cases/#sec-Example-UTF8

def setup
  test_xml = <<-XML
<?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE doc SYSTEM "doc.dtd">
      <doc>
      <?xml-stylesheet   href="doc.xsl"
         type="text/xsl"   ?>
        <child  z_attr="z"   d_attr="d"     v_attr="v"      b_attr="b" >data<!-- Comment 1 --></child>
        <utf8>fékàlèmùpô☠</utf8>
        <![CDATA[
          puts "random code"
        ]]>
        <compute><![CDATA[value>"0" && value<"10" ?"valid":"error"]]></compute>
        <once_or_is_it />
      </doc>
      <?pi-without-data     ?>

      <!-- Comment 2 -->

      <!-- Comment 3 -->
XML
  parsed = XML.parse(test_xml)
end

describe XML::C14N do
  describe "#canonicalize" do
    parsed = setup
    canonicalized = parsed.canonicalize

    it "should not contain a xml declaration" do
      canonicalized.should_not match(/^<\?xml/m)
    end

    it "should not contain a DOCTYPE" do
      canonicalized.should_not match(/^DOCTYPE/m)
    end

    it "should not contain comments" do
      canonicalized.should_not match(/Comment/m)
    end

    it "should not contain CDATA tags" do
      canonicalized.should_not match(/^<!\[CDATA\[/m)
    end

    it "should have utf8 codepoint" do
      canonicalized.to_s.should contain "☠"
    end
  end

  describe "#canonicalize!" do
    it "changes the object" do
      parsed = setup
      #puts parsed
      parsed.canonicalize!
      #puts "\n\n"
      #puts parsed
      parsed.should be_a(XML::Node)
    end
  end
end
