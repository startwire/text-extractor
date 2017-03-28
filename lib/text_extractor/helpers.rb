module TextExtractor
  module Helpers
    extend ActiveSupport::Concern

    def fix_file_name(file_path)
      original_file_name = ::File.basename(file_path)
      original_file_path = file_path
      if original_file_name =~ /\(|\)|\s/i
        file_path = ::File.join(Pathname.new(file_path).dirname, original_file_name.gsub(/\(|\)|\s/i, ''))
        ::File.rename(original_file_path, file_path)
      end

      file_path
    end

    def empty_result?(text)
      text.gsub(/\W/, '').empty?
    end

    def escape_text(text)
      text.without_non_utf8
    end

    def to_shell(file_path)
      Shellwords.escape(file_path)
    end
  end
end