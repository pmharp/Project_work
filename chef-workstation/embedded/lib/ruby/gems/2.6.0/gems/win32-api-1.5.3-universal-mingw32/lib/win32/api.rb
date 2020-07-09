require 'rbconfig'

case RbConfig::CONFIG['MAJOR']
  when '1'
    if RbConfig::CONFIG['MINOR'] == '8'
      require File.join(File.dirname(__FILE__), 'ruby18/win32/api')
    else
      require File.join(File.dirname(__FILE__), 'ruby19/win32/api')
    end
  when '2'
    if RbConfig::CONFIG['MINOR'] == '0'
      if RbConfig::CONFIG['arch'] =~ /x64/i
        require File.join(File.dirname(__FILE__), 'ruby2_64/win32/api')
      else
        require File.join(File.dirname(__FILE__), 'ruby2_32/win32/api')
      end
    end

    if RbConfig::CONFIG['MINOR'] == '1'
      if RbConfig::CONFIG['arch'] =~ /x64/i
        require File.join(File.dirname(__FILE__), 'ruby21_64/win32/api')
      else
        require File.join(File.dirname(__FILE__), 'ruby21_32/win32/api')
      end
    end

    if RbConfig::CONFIG['MINOR'] == '2'
      if RbConfig::CONFIG['arch'] =~ /x64/i
        require File.join(File.dirname(__FILE__), 'ruby22_64/win32/api')
      else
        require File.join(File.dirname(__FILE__), 'ruby22_32/win32/api')
      end
    end
end
