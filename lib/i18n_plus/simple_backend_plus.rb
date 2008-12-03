module I18nPlus
  module SimpleBackendPlus
    private
    def self.included(othermod)
      othermod.module_eval do
        alias_method_chain :pluralize, :custom_rules
        alias_method_chain :lookup, :parent
      end
    end

    def pluralize_with_custom_rules(locale, entry, count)
      return entry unless entry.is_a?(Hash) and count
      @pluralization_rule = lookup(locale, :pluralization) unless defined? @pluralization_rule
      return @pluralization_rule.call(entry, count) if @pluralization_rule
      pluralize_without_custom_rules(locale, entry, count)
    end

    def lookup_with_parent(locale, key, scope = [])
      loop do
        val = lookup_without_parent(locale, key, scope)
        return val if val
        locale = parent_of(locale)
        return nil if locale.blank?
      end
    end

    def parent_of(locale)
      return nil if locale.blank? || locale == :en
      (locale = locale.to_s.sub(/-?[^-]+\Z/i, '')).blank? ? :en : locale.to_sym
    end
  end

  I18n::Backend::Simple.send(:include, SimpleBackendPlus)
end
