from django.db import models
from django.conf import settings



class Route(models.Model):
    driver = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.PROTECT,
        related_name="routes",
    )

    class VehicleType(models.TextChoices):
        CAR = "carro", "Carro"
        MOTORCYCLE = "moto", "Motorcycle"
        TRUCK = "caminhao", "Caminhão"

    class Shift(models.TextChoices):
        MORNING = "manha", "Manhã"
        AFTERNOON = "tarde", "Tarde"
        NIGHT = "noite", "Noite"

    class Status(models.TextChoices):
        STARTED = "started", "Started"
        FINISHED = "finished", "Finished"

    route_name = models.CharField(max_length=120)
    vehicle_type = models.CharField(max_length=20, choices=VehicleType.choices)
    shift = models.CharField(max_length=20, choices=Shift.choices)
    bag_id = models.CharField(max_length=50)
    notes = models.TextField(blank=True)
    status = models.CharField(
        max_length=20,
        choices=Status.choices,
        default=Status.STARTED,
    )
    started_at = models.DateTimeField()
    finished_at = models.DateTimeField(null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self) -> str:
        return f"{self.route_name} ({self.status})"


class Collection(models.Model):
    route = models.ForeignKey(
        Route,
        on_delete=models.CASCADE,
        related_name="collections",
    )
    location_name = models.CharField(max_length=120)
    temperature = models.DecimalField(max_digits=5, decimal_places=2)
    notes = models.TextField(blank=True)
    collected_at = models.DateTimeField()
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self) -> str:
        return f"{self.location_name} - {self.temperature}°C"


class Receiving(models.Model):
    class IntegrityStatus(models.TextChoices):
        OK = "ok", "OK"
        RESTRICTED = "restricted", "Com ressalva"
        REJECTED = "rejected", "Rejeitado"

    route = models.OneToOneField(
        Route,
        on_delete=models.CASCADE,
        related_name="receiving",
    )
    receiver_name = models.CharField(max_length=120)
    temperature = models.DecimalField(max_digits=5, decimal_places=2)
    integrity_status = models.CharField(
        max_length=20,
        choices=IntegrityStatus.choices,
    )
    notes = models.TextField(blank=True)
    received_at = models.DateTimeField()
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self) -> str:
        return f"Receiving for route #{self.route_id}"