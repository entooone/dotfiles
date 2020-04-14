
winClass = window.get_active_class()

if winClass == "urxvt.URxvt":
    keyboard.send_keys("<ctrl>+h")
else:
    keyboard.send_keys("<backspace>")