if Refinery::Elasticsearch.enable_for.include?('Refinery::Blog::Post')
  begin
    Refinery::Blog::Post.class_eval do
      include ::Refinery::Elasticsearch::Searchable
      include Elasticsearch::Model

      I18n.locale = Refinery::I18n.config.default_locale

      define_mapping do
        {
          title: { type: 'keyword' },
          browser_title: { type: 'keyword' },
          body: { type: 'text', analyzer: 'snowball' },
          custom_teaser: { type: 'text', analyzer: 'snowball' },
          meta_description: { type: 'keyword' },
          created_at: { type: 'date' },
          updated_at: { type: 'date' }
        }
      end

      def to_index
        {
          title: title,
          body: body,
          custom_teaser: custom_teaser,
          browser_title: browser_title,
          meta_description: meta_description,
          created_at: created_at,
          updated_at: updated_at
        }
      end

      def self.indexable
        live
      end
    end
  rescue NameError
  end
end
