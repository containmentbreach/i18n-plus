require 'i18n_plus'

I18n.load_path.concat Dir[File.join(File.dirname(__FILE__), 'locales', '*.{rb,yml}')]
