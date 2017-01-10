require "xml"
require "./mode"

@[Link("xml2")]
lib LibC14N
  alias OutputWriteCallback = (Void*, UInt8*, Int32) -> Int32
  alias OutputCloseCallback = (Void*) -> Int32

  type CharEncodingHandler = Void*
  type OutputBuffer = Void*

  fun xmlOutputBufferClose(out : LibXML::OutputBuffer*) : Int32
  fun xmlC14NDocSaveTo(doc : LibXML::Node*, nodes : LibXML::NodeSet*, mode : XML::C14N::Mode, inclusive_ns_prefixes : UInt8**, with_comments : Int32, buf : LibXML::OutputBuffer*) : Int32
end
