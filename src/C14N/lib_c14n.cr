require "xml"
#module XML

  @[Link("xml2")]
  lib LibC14N

    enum Mode
      XML_C14N_1_0            = 0
      XML_C14N_EXCLUSIVE_1_0  = 1
      XML_C14N_1_1            = 2
    end

    alias OutputWriteCallback = (Void*, UInt8*, Int32) -> Int32
    alias OutputCloseCallback = (Void*) -> Int32
    alias IsVisibleCallback   = (Void*, LibXML::Node*, LibXML::Node*) -> Int32

    type CharEncodingHandler = Void*
    type Buff = Void*

    #type OutputBuffer = Void*
    struct OutputBuffer
      context : Void*
      writecallback : OutputWriteCallback
      closecallback : OutputCloseCallback
      encoder : CharEncodingHandler
      buffer  : UInt8*
      conv    : UInt8*
      written : Int32
      error   : Int32
    end

    struct XMLBuffer
      content : UInt8*
      use     : UInt32
      size    : UInt32
      alloc   : Int32
      contentIO : UInt8*
    end

    fun xmlAllocOutputBuffer(encoder : Void*) : OutputBuffer*
    fun xmlOutputBufferClose(out : OutputBuffer*) : Int32
    fun xmlOutputBufferCreateIO(iowrite : OutputWriteCallback, ioclose : OutputCloseCallback, ioctx : Void*, encoder : Void*) : OutputBuffer*
    fun xmlOutputBufferCreateBuffer(buffer : XMLBuffer*, encoder : Void*) : OutputBuffer*
    fun xmlC14NDocDumpMemory(doc : LibXML::Node*, nodes : LibXML::NodeSet*, mode : Mode, inclusive_ns_prefixes : UInt8**, with_comments : Int32, doc_txt_prt : UInt8**) : Int32
    fun xmlC14NDocSave(doc : LibXML::Node*, nodes : LibXML::NodeSet*, mode : Mode , inclusive_ns_prefixes : UInt8**, with_comments : Int32, filename : UInt8*, compression : Int32 ) : Int32
    fun xmlC14NDocSaveTo(doc : LibXML::Node*, nodes : LibXML::NodeSet*, mode : Mode, inclusive_ns_prefixes : UInt8**, with_comments : Int32, buf : OutputBuffer*) : Int32
    fun xmlC14NExecute(doc : LibXML::Node*, is_visible_callback : IsVisibleCallback, user_data : Void*, mode : Mode, inclusive_ns_prefixes : UInt8**, with_comments : Int32, buf : OutputBuffer*) : Int32
  end
#end
