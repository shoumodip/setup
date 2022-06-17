from os import environ

config.load_autoconfig(False)

c.auto_save.session = True
c.changelog_after_upgrade = "never"

c.colors.webpage.darkmode.enabled = True
c.colors.webpage.preferred_color_scheme = "dark"

c.completion.height = "30%"
c.completion.scrollbar.padding = 0
c.completion.scrollbar.width = 0
c.completion.timestamp_format = "%I:%M%p %d/%m/%y"

# Block garbage
c.content.blocking.adblock.lists = [
    "https://easylist.to/easylist/easylist.txt",
    "https://easylist.to/easylist/easyprivacy.txt",
    "https://easylist.to/easylist/fanboy-social.txt",
    "https://secure.fanboy.co.nz/fanboy-annoyance.txt",
    "https://easylist-downloads.adblockplus.org/abp-filters-anti-cv.txt",
]

c.content.blocking.hosts.lists = [
    "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn-social/hosts"
]

c.content.blocking.method = "both"
c.content.cookies.accept = "no-3rdparty"
c.content.default_encoding = "utf-8"
c.content.pdfjs = True
c.content.notifications.enabled = False
c.content.prefers_reduced_motion = True
c.content.tls.certificate_errors = "block"

c.downloads.location.directory = "~/downloads"
c.downloads.location.prompt = False
c.downloads.remove_finished = 0

c.editor.command = [environ.get("TERMINAL"), "-e", environ.get("EDITOR"), "{file}", "+normal {line}G{column}|"]

c.hints.border = "0px"
c.hints.padding = {"top": 0, "bottom": 0, "left": 0, "right": 0}
c.hints.radius = 0

c.keyhint.radius = 0
c.prompt.radius = 0

c.fonts.default_size = "15pt"
c.statusbar.padding = {"top": 0, "bottom": 0, "left": 0, "right": 0}

c.scrolling.bar = "always"
c.statusbar.widgets = []

c.tabs.favicons.show = "never"
c.tabs.indicator.padding = {"top": 0, "bottom": 0, "left": 0, "right": 0}
c.tabs.indicator.width = 0
c.tabs.last_close = "blank"
c.tabs.padding = {"top": 0, "bottom": 0, "left": 0, "right": 0}

c.tabs.title.format = "{current_title}"
c.tabs.title.format_pinned = "{current_title}"

c.url.default_page = "about:blank"
c.url.start_pages = ["about:blank"]
c.url.searchengines = {
    "DEFAULT": "https://google.com/search?q={}",
    "yt": "https://www.youtube.com/results?search_query={}",
    "aw": "https://wiki.archlinux.org/title/{}",
    "wk": "https://en.wikipedia.org/wiki/{}",
    "gh": "https://github.com/shoumodip/{}",
}

c.window.title_format = "{current_title} - Qutebrowser"

config.bind("gt", "tab-next")
config.bind("gT", "tab-prev")
config.bind("<Alt-e>", "edit-text", mode="insert")
config.bind("<Ctrl-n>", "fake-key <Down>", mode="insert")
config.bind("<Ctrl-p>", "fake-key <Up>", mode="insert")
config.bind("<Ctrl-f>", "fake-key <Right>", mode="insert")
config.bind("<Ctrl-b>", "fake-key <Left>", mode="insert")
config.bind("<Alt-f>", "fake-key <Ctrl-Right>", mode="insert")
config.bind("<Alt-b>", "fake-key <Ctrl-Left>", mode="insert")
config.bind("<Ctrl-a>", "fake-key <Home>", mode="insert")
config.bind("<Ctrl-e>", "fake-key <End>", mode="insert")
config.bind("<Alt-Backspace>", "fake-key <Ctrl-Backspace>", mode="insert")
config.bind("<Alt-d>", "fake-key <Ctrl-Delete>", mode="insert")

# Zenburn Theme: https://github.com/theova/base16-qutebrowser
base00 = "#3f3f3f"
base01 = "#404040"
base02 = "#606060"
base03 = "#6f6f6f"
base04 = "#808080"
base05 = "#dcdccc"
base06 = "#c0c0c0"
base07 = "#ffffff"
base08 = "#dca3a3"
base09 = "#dfaf8f"
base0A = "#e0cf9f"
base0B = "#5f7f5f"
base0C = "#93e0e3"
base0D = "#7cb8bb"
base0E = "#dc8cc3"

c.colors.completion.fg = base05
c.colors.completion.odd.bg = base01
c.colors.completion.even.bg = base00
c.colors.completion.category.fg = base0A
c.colors.completion.category.bg = base00
c.colors.completion.category.border.top = base00
c.colors.completion.category.border.bottom = base00
c.colors.completion.item.selected.fg = base05
c.colors.completion.item.selected.bg = base02
c.colors.completion.item.selected.border.top = base02
c.colors.completion.item.selected.border.bottom = base02
c.colors.completion.item.selected.match.fg = base0B
c.colors.completion.match.fg = base0B
c.colors.completion.scrollbar.fg = base05
c.colors.completion.scrollbar.bg = base00
c.colors.contextmenu.disabled.bg = base01
c.colors.contextmenu.disabled.fg = base04
c.colors.contextmenu.menu.bg = base00
c.colors.contextmenu.menu.fg =  base05
c.colors.contextmenu.selected.bg = base02
c.colors.contextmenu.selected.fg = base05
c.colors.downloads.bar.bg = base00
c.colors.downloads.start.fg = base00
c.colors.downloads.start.bg = base0D
c.colors.downloads.stop.fg = base00
c.colors.downloads.stop.bg = base0C
c.colors.downloads.error.fg = base08
c.colors.hints.fg = base00
c.colors.hints.bg = base0A
c.colors.hints.match.fg = base05
c.colors.keyhint.fg = base05
c.colors.keyhint.suffix.fg = base05
c.colors.keyhint.bg = base00
c.colors.messages.error.fg = base00
c.colors.messages.error.bg = base08
c.colors.messages.error.border = base08
c.colors.messages.warning.fg = base00
c.colors.messages.warning.bg = base0E
c.colors.messages.warning.border = base0E
c.colors.messages.info.fg = base05
c.colors.messages.info.bg = base00
c.colors.messages.info.border = base00
c.colors.prompts.fg = base05
c.colors.prompts.border = base00
c.colors.prompts.bg = base00
c.colors.prompts.selected.bg = base02
c.colors.prompts.selected.fg = base05
c.colors.statusbar.normal.fg = base0B
c.colors.statusbar.normal.bg = base00
c.colors.statusbar.insert.fg = base00
c.colors.statusbar.insert.bg = base0D
c.colors.statusbar.passthrough.fg = base00
c.colors.statusbar.passthrough.bg = base0C
c.colors.statusbar.private.fg = base00
c.colors.statusbar.private.bg = base01
c.colors.statusbar.command.fg = base05
c.colors.statusbar.command.bg = base00
c.colors.statusbar.command.private.fg = base05
c.colors.statusbar.command.private.bg = base00
c.colors.statusbar.caret.fg = base00
c.colors.statusbar.caret.bg = base0E
c.colors.statusbar.caret.selection.fg = base00
c.colors.statusbar.caret.selection.bg = base0D
c.colors.statusbar.progress.bg = base0D
c.colors.statusbar.url.fg = base05
c.colors.statusbar.url.error.fg = base08
c.colors.statusbar.url.hover.fg = base05
c.colors.statusbar.url.success.http.fg = base0C
c.colors.statusbar.url.success.https.fg = base0B
c.colors.statusbar.url.warn.fg = base0E
c.colors.tabs.bar.bg = base00
c.colors.tabs.indicator.start = base0D
c.colors.tabs.indicator.stop = base0C
c.colors.tabs.indicator.error = base08
c.colors.tabs.odd.fg = base05
c.colors.tabs.odd.bg = base01
c.colors.tabs.even.fg = base05
c.colors.tabs.even.bg = base00
c.colors.tabs.pinned.even.bg = base0C
c.colors.tabs.pinned.even.fg = base07
c.colors.tabs.pinned.odd.bg = base0B
c.colors.tabs.pinned.odd.fg = base07
c.colors.tabs.pinned.selected.even.bg = base02
c.colors.tabs.pinned.selected.even.fg = base05
c.colors.tabs.pinned.selected.odd.bg = base02
c.colors.tabs.pinned.selected.odd.fg = base05
c.colors.tabs.selected.odd.fg = base05
c.colors.tabs.selected.odd.bg = base02
c.colors.tabs.selected.even.fg = base05
c.colors.tabs.selected.even.bg = base02
c.colors.webpage.bg = base00
