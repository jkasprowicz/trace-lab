from rest_framework import serializers

from .models import Collection, Receiving, Route

class CollectionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Collection
        fields = [
            "id",
            "route",
            "location_name",
            "temperature",
            "notes",
            "collected_at",
            "created_at",
        ]
        read_only_fields = ["id", "created_at", "route"]


class RouteSerializer(serializers.ModelSerializer):
    collections_count = serializers.IntegerField(
        source="collections.count",
        read_only=True,
    )

    driver_name = serializers.CharField(
        source="driver.username",
        read_only=True,
    )

    class Meta:
        model = Route
        fields = [
            "id",
            "driver",
            "driver_name",
            "route_name",
            "vehicle_type",
            "shift",
            "bag_id",
            "notes",
            "status",
            "started_at",
            "finished_at",
            "created_at",
            "collections_count",
        ]
        read_only_fields = [
            "id",
            "driver",
            "driver_name",
            "status",
            "finished_at",
            "created_at",
            "collections_count",
        ]

class ReceivingSerializer(serializers.ModelSerializer):
    class Meta:
        model = Receiving
        fields = [
            "id",
            "route",
            "receiver_name",
            "temperature",
            "integrity_status",
            "notes",
            "received_at",
            "created_at",
        ]
        read_only_fields = ["id", "created_at", "route"]