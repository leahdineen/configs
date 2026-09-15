import sublime_plugin


MARKDOWN_VIEW_INFOS = "markdown_view_infos"

_previewed_paths = set()


class AutoOpenMarkdownPreview(sublime_plugin.EventListener):
    def on_load_async(self, view):
        syntax = view.settings().get("syntax") or ""
        if "markdown" not in syntax.lower():
            return
        if view.settings().get(MARKDOWN_VIEW_INFOS):
            return
        path = view.file_name()
        if path and path in _previewed_paths:
            return
        if path:
            _previewed_paths.add(path)
        view.run_command("open_markdown_preview")

    def on_close(self, view):
        if view.settings().get(MARKDOWN_VIEW_INFOS):
            return
        path = view.file_name()
        if path:
            _previewed_paths.discard(path)
