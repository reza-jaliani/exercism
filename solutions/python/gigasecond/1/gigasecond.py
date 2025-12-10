from datetime import datetime, timedelta

GIGASECOND = 1_000_000_000

def add(moment):
    return moment + timedelta(seconds=GIGASECOND)