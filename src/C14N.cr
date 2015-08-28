require "./C14N/*"

module XML
  class C14N
    getter :xml

    def initialize(@xml, @mode = LibC14N::Mode::XML_C14N_EXCLUSIVE_1_0)
    end

    def self.canonicalize(@xml, @mode)
      new(@xml, @mode).canonicalize
    end

    def canonicalize()
      ctx = StringIO.new()

      output_buf = LibC14N.xmlOutputBufferCreateIO(
        ->(ctx, buffer, len) {
          Box(IO).unbox(ctx).write Slice.new(buffer, len)
          len
        },
        ->(ctx) { 0 },
        Box(IO).box(ctx),
        nil
      )

      #LibC14N.xmlC14NExecute(@xml, nil, nil, @mode, nil, 0, output_buf)
      LibC14N.xmlC14NDocSaveTo(@xml, nil, @mode, nil, 0, output_buf)
      LibC14N.xmlOutputBufferClose(output_buf)
      ctx.to_s
    end

    def write filename
      LibC14N.xmlC14NDocSave(@xml, nil, @mode, nil, 0, filename, 0)
    end
  end
end
