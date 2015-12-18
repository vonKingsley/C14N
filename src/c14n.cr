require "./c14n/*"

struct XML::Node
  include XML::C14N

  def canonicalize(io = MemoryIO.new)
    canonicalize(io, Mode::C14N_EXCLUSIVE_1_0, false)
  end

  def canonicalize(io, mode, comments?)
    canonicalize(io, mode, nil, nil, comments?)
  end

  def canonicalize(io, mode = Mode::C14N_EXCLUSIVE_1_0, node_set = nil, inclusive_ns = nil, comments? = false)
    output_buffer = canonical_out_buffer(io)
    LibC14N.xmlC14NDocSaveTo(self, node_set, mode, inclusive_ns, comments?.hash, output_buffer)
    LibC14N.xmlOutputBufferClose(output_buffer)
    return io.to_s if io.class == MemoryIO
    io
  end

  def canonicalize!
    canon = self.canonicalize as String
    node = LibXML.xmlDocGetRootElement(LibXML.xmlReadMemory(canon, canon.bytesize, nil, nil, ParserOptions.default))
    self.initialize(node)
  end

  private def canonical_out_buffer(io)
    ctx = io
    LibC14N.xmlOutputBufferCreateIO(
      ->(ctx, buffer, len) {
        Box(IO).unbox(ctx).write Slice.new(buffer, len)
        len
      },
      ->(ctx) { 0 },
      Box(IO).box(ctx),
      nil
    )
  end
end
