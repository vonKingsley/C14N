require "xml"
require "./C14N/*"

module XML
  class C14N
    getter :xml

    def initialize(@xml, @mode = XML::LibC14N::Mode::XML_C14N_EXCLUSIVE_1_0)
    #def initialize(@xml, @mode = XML::LibC14N::Mode::XML_C14N_1_1)
    #def initialize(@xml, @mode = XML::LibC14N::Mode::XML_C14N_1_0)
    end

    def canonicalize()
      #@output = LibC14N.xmlOutputBufferCreateBuffer(nil, nil)
      output = XML::LibC14N::OutputBuffer.new
      debugger
      p output.encoder
      LibC14N.xmlC14NDocSaveTo(@xml, nil, @mode, nil, 0, out output)

      #LibC14N.xmlC14NDocSave(@xml, nil, @mode, nil, 0, "canon.xml", 0)

      #output = XML::LibC14N.xmlAllocOutputBuffer(nil)
      #p output.class
      #ptr = pointerof(output)
      #ptr.value.encoder = nil
      #p ptr
      #nodeset = XML::NodeSet.new(@xml)
      #LibC14N.xmlC14NDocDumpMemory(@xml, nil, @mode, nil, 0, out output)
      #LibC14N.xmlC14NExecute(@xml, nil, nil, @mode, nil, 0, out output)
      #p output
    end

  end
end
