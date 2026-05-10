from django.shortcuts import get_object_or_404
from django.utils import timezone
from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView

from accounts.permissions import IsDriverOrAdmin, IsReceiverOrAdmin
from .models import Collection, Receiving, Route
from .serializers import CollectionSerializer, ReceivingSerializer, RouteSerializer


class RouteListCreateView(APIView):
    permission_classes = [IsAuthenticated, IsDriverOrAdmin]

    def post(self, request):
        serializer = RouteSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        route = serializer.save(
            driver=request.user,
            status=Route.Status.STARTED,
        )

        return Response(RouteSerializer(route).data, status=status.HTTP_201_CREATED)


class RouteDetailView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, route_id: int):
        route = get_object_or_404(Route, id=route_id)
        serializer = RouteSerializer(route)
        return Response(serializer.data)

class RouteCollectionListCreateView(APIView):
    permission_classes = [IsAuthenticated, IsDriverOrAdmin]
    def get(self, request, route_id: int):
        route = get_object_or_404(Route, id=route_id)
        collections = route.collections.order_by("collected_at")
        serializer = CollectionSerializer(collections, many=True)
        return Response(serializer.data)

    def post(self, request, route_id: int):
        route = get_object_or_404(Route, id=route_id)

        if route.status == Route.Status.FINISHED:
            return Response(
                {"detail": "Cannot add collections to a finished route."},
                status=status.HTTP_400_BAD_REQUEST,
            )

        serializer = CollectionSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        collection = serializer.save(route=route)
        return Response(
            CollectionSerializer(collection).data,
            status=status.HTTP_201_CREATED,
        )


class RouteFinishView(APIView):
    permission_classes = [IsAuthenticated, IsDriverOrAdmin]
    def post(self, request, route_id: int):
        route = get_object_or_404(Route, id=route_id)

        if route.status == Route.Status.FINISHED:
            return Response(
                {"detail": "Route is already finished."},
                status=status.HTTP_400_BAD_REQUEST,
            )

        route.status = Route.Status.FINISHED
        route.finished_at = timezone.now()
        route.save(update_fields=["status", "finished_at"])

        return Response(RouteSerializer(route).data, status=status.HTTP_200_OK)

class RouteReceivingCreateView(APIView):
    permission_classes = [IsAuthenticated, IsReceiverOrAdmin]
    def post(self, request, route_id: int):
        route = get_object_or_404(Route, id=route_id)

        if route.status != Route.Status.FINISHED:
            return Response(
                {"detail": "Receiving can only be registered for finished routes."},
                status=status.HTTP_400_BAD_REQUEST,
            )

        if hasattr(route, "receiving"):
            return Response(
                {"detail": "Receiving already registered for this route."},
                status=status.HTTP_400_BAD_REQUEST,
            )

        serializer = ReceivingSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        receiving = serializer.save(route=route)

        return Response(
            ReceivingSerializer(receiving).data,
            status=status.HTTP_201_CREATED,
        )

class PendingReceivingRoutesView(APIView):
    permission_classes = [IsAuthenticated, IsReceiverOrAdmin]

    def get(self, request):
        routes = Route.objects.filter(
            status=Route.Status.FINISHED,
            receiving__isnull=True,
        ).order_by("-finished_at")

        serializer = RouteSerializer(routes, many=True)
        return Response(serializer.data)