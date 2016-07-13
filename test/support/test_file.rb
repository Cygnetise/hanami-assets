require 'securerandom'

class TestFile
  OPEN_MODE   = File::WRONLY | File::TRUNC | File::CREAT
  PERMISSIONS = 0o664

  def initialize(root: TMP, path: nil, &blk)
    @file = root.join(path || SecureRandom.uuid)
    @file.rm if @file.exist?
    write

    fail "Expected #{@file} to exist" unless @file.exist? # rubocop:disable Style/SignalException
    instance_exec(&blk) if block_given?
  end

  def touch(content = nil)
    last_modified = mtime

    while mtime <= last_modified
      write(content)
    end

    yield
  end

  def write(content = nil)
    @file.open(OPEN_MODE, PERMISSIONS) do |f|
      f.write(content || SecureRandom.hex(12))
    end
  end

  def mtime
    @file.mtime
  end

  def to_s
    @file.to_s
  end

  alias to_str to_s
end
