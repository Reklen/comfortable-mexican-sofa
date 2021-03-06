# Tag for reusable snippets within context's site scope. Looks like this:
#   {{cms:snippet identifier}}
# Snippets may have more tags in them like fragments, so they may be expanded too.
#
class ComfortableMexicanSofa::Content::Tag::Snippet < ComfortableMexicanSofa::Content::Tag

  attr_reader :identifier

  def initialize(context, params_string)
    super
    @identifier = params[0]

    unless @identifier.present?
      raise Error, "Missing identifier for snippet tag"
    end
  end

  def content
    snippet.content
  end

  # Grabbing or initializing Comfy::Cms::Snippet object
  def snippet
    self.context.site.snippets.detect{|s| s.identifier == self.identifier} ||
    self.context.site.snippets.build(identifier: self.identifier)
  end
end

ComfortableMexicanSofa::Content::Renderer.register_tag(
  :snippet, ComfortableMexicanSofa::Content::Tag::Snippet
)
