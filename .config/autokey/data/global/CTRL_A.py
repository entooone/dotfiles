
winClass = window.get_active_class()

if winClass == "urxvt.URxvt":
    keyboard.send_keys("<ctrl>+a")
else:
    keyboard.send_keys("<home>")
