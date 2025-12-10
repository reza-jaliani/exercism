def two_fer(name: str | None = None) -> str:
    if not name or name.strip() == "":
        person = "you"
    else:
        person = name.strip()
    return f"One for {person}, one for me."