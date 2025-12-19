import random
import string


class Robot:
    _used_names = set()

    def __init__(self):
        self._name = None

    @property
    def name(self):
        if self._name is None:
            self._name = self._generate_unique_name()
        return self._name

    def reset(self):
        self._name = None

    @classmethod
    def _generate_unique_name(cls):
        while True:
            letters = random.choice(string.ascii_uppercase) + random.choice(string.ascii_uppercase)
            digits = f"{random.randint(0, 999):03d}"
            name = letters + digits

            if name not in cls._used_names:
                cls._used_names.add(name)
                return name
