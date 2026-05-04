from django.urls import path

from .views import (
    RouteCollectionListCreateView,
    RouteDetailView,
    RouteFinishView,
    RouteListCreateView,
    RouteReceivingCreateView,
)

urlpatterns = [
    path("routes/", RouteListCreateView.as_view()),
    path("routes/<int:route_id>/", RouteDetailView.as_view()),
    path("routes/<int:route_id>/collections/", RouteCollectionListCreateView.as_view()),
    path("routes/<int:route_id>/finish/", RouteFinishView.as_view()),
    path("routes/<int:route_id>/receiving/", RouteReceivingCreateView.as_view(), name="route-receiving"),
]