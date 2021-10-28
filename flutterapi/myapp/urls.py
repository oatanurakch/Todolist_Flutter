from django.urls import path
from .views import *    # * คือดึงทุก def ใน views.py

urlpatterns = [
    path('', Home),
    path('api/get-all-todolist/', all_todolist),  # localhost:8000/api/get-all-todolist
    path('api/post-todolist', post_todolist),
    path('api/update-todolist/<int:TID>', update_todolist),
    path('api/delete-todolist/<int:TID>', delete_todolist),
] 