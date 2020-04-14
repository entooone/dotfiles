
winClass = window.get_active_class()

if winClass == "urxvt.URxvt":
    keyboard.send_keys("<ctrl>+<shift>+c")
else:
    keyboard.send_keys("<ctrl>+c")