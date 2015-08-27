require "./spec_helper"

describe XML::C14N do

  it "will remove comments" do
    str = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n\n\n<xml>\n\n<child>data<!--comment--></child>\n\n</xml>"
    canon_str = "<xml>\n\n<child>data</child>\n\n</xml>"
    xml = XML.parse(str)
    canon = XML::C14N.new(xml)
    canon_out = canon.canonicalize
    #p canon.to_s
    canon_out.should eq( canon_str )
  end

end
