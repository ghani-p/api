defmodule ApiWeb.ErrorHelpers do
  @moduledoc """
  Conveniences for translating and building error messages.
  """
  use Phoenix.HTML

  @doc """
  Translates an error message using gettext.
  """
  def translate_error({msg, _opts}) do
    # Because error messages were defined within Ecto, we must
    # call the Gettext module passing our Gettext backend. We
    # also use the "errors" domain as translations are placed
    # in the errors.po file. On your own code and templates,
    # this could be written simply as:
    #
    #     dngettext "errors", "1 file", "%{count} files", count
    #
    msg
  end

  @doc """
  Generates tag for inlined form input errors.
  """
  def error_tag(form, field) do
    Enum.map(Map.get(form.source.errors, field, []), fn error ->
      humanized_field = Phoenix.Naming.humanize(field)
      translated_error = translate_error({error, []})
      error_message = "#{humanized_field} #{translated_error}."
      content_tag(:span, error_message, class: "help-block")
    end)
  end
end
