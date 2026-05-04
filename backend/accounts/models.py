from django.contrib.auth.models import AbstractUser
from django.db import models


class User(AbstractUser):
    class Role(models.TextChoices):
        DRIVER = "driver", "Motorista"
        RECEIVER = "receiver", "Recebedor"
        ADMIN = "admin", "Admin"

    role = models.CharField(
        max_length=20,
        choices=Role.choices,
        default=Role.DRIVER,
    )

    def is_driver(self) -> bool:
        return self.role == self.Role.DRIVER

    def is_receiver(self) -> bool:
        return self.role == self.Role.RECEIVER

    def is_admin_role(self) -> bool:
        return self.role == self.Role.ADMIN