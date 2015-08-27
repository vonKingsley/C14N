require "./C14N/*"

module XML
  class C14N
    getter :xml

    def initialize(@xml, @mode = LibC14N::Mode::XML_C14N_EXCLUSIVE_1_0)
    end

    def canonicalize()
      ctx = StringIO.new()
      #output = LibC14N::OutputBuffer.new
      output_buf = LibC14N.xmlOutputBufferCreateIO(
        ->(ctx, buffer, len) {
          Box(IO).unbox(ctx).write Slice.new(buffer, len)
          len
        },
        ->(ctx) { 0 },
        Box(IO).box(ctx),
        nil
      )
      LibC14N.xmlC14NExecute(@xml, nil, nil, @mode, nil, 0, output_buf)
      #LibC14N.xmlC14NDocSaveTo(@xml, nil, @mode, nil, 0, output_buf)
      LibC14N.xmlOutputBufferClose(output_buf)
      #st = String.new ctx.buffer
      #p st
      #p ctx.buffer.value
      #p ctx.bytesize
      #p output_buf.value.context
      ctx.to_s

      #LibC14N.xmlC14NDocSave(@xml, nil, @mode, nil, 0, "canon.xml", 0)

    end
  end
end
