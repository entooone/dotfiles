
winClass = window.get_active_class()

if winClass == "urxvt.URxvt":
    keyboard.send_keys("<ctrl>+<shift>+v")
else:
    keyboard.send_keys("<ctrl>+v")