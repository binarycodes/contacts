module LoginHelper
  require 'digest'

  def md5sum(str)
    Digest::MD5.hexdigest(str)
  end
end
