
winClass = window.get_active_class()

if winClass == "urxvt.URxvt":
    keyboard.send_keys("<ctrl>+e")
else:
    keyboard.send_keys("<end>")
