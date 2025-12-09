class SpaceAge:
    EARTH_YEAR_SECONDS = 31557600  # 365.25 days * 24 * 3600

    ORBITAL_PERIODS = {
        "earth": 1.0,
        "mercury": 0.2408467,
        "venus": 0.61519726,
        "mars": 1.8808158,
        "jupiter": 11.862615,
        "saturn": 29.447498,
        "uranus": 84.016846,
        "neptune": 164.79132,
    }

    def __init__(self, seconds):
        self.seconds = seconds

    def _age_on(self, planet):
        earth_years = self.seconds / self.EARTH_YEAR_SECONDS
        return round(earth_years / self.ORBITAL_PERIODS[planet], 2)

    def on_earth(self):
        return self._age_on("earth")

    def on_mercury(self):
        return self._age_on("mercury")

    def on_venus(self):
        return self._age_on("venus")

    def on_mars(self):
        return self._age_on("mars")

    def on_jupiter(self):
        return self._age_on("jupiter")

    def on_saturn(self):
        return self._age_on("saturn")

    def on_uranus(self):
        return self._age_on("uranus")

    def on_neptune(self):
        return self._age_on("neptune")
