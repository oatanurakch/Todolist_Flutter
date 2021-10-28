from django.http import response
from django.http.response import JsonResponse
from django.shortcuts import render
from django.http import HttpResponse, JsonResponse

# Create your views here.

from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import serializers, status
from .serializers import TodolistSerializer
from .models import Todolist

# GET Data เรียกดูข้อมูลจาก Database
@api_view(['GET'])
def all_todolist(request):
    alltodolist = Todolist.objects.all()    # ดึงข้อมูลจาก model Todolist
    serializerdata = TodolistSerializer(alltodolist, many = True)   # เป็นการดึงข้อมูลออกมาทั้งหมดไม่ใช่ JSON และมีข้อมูลหลายข้อมูลเลยจำเป็นต้องใช้ many = True
    return Response(serializerdata.data, status = status.HTTP_200_OK)

# POST Data บันทึกข้อมูลลง Database
@api_view(['POST'])
def post_todolist(request):
    if request.method == 'POST':
        serializers = TodolistSerializer(data = request.data)
        if serializers.is_valid():
            serializers.save()
            return Response(serializers.data, status = status.HTTP_201_CREATED)
            # การส่ง Error ว่าเป็น Error จากอะไร
        return Response(serializers.errors, status = status.HTTP_404_NOT_FOUND)

@api_view(['PUT'])
def update_todolist(request,  TID):
    todo = Todolist.objects.get(id = TID)

    if request.method == 'PUT':
        data = {}
        # ต้องใส่ข้อมูลที่ต้องการอัพเดตที่ได้จากการ get เข้าไปใน serializer ด้วย
        serializer = TodolistSerializer(todo, data = request.data)
        if serializer.is_valid():
            serializer.save()
            data['status'] = 'Success'
            return Response(data = data, status = status.HTTP_201_CREATED)
        return Response(serializer.errors, status = status.HTTP_404_NOT_FOUND)

@api_view(['DELETE'])
def delete_todolist(request, TID):
    todo = Todolist.objects.get(id = TID)

    if request.method == 'DELETE':
        delete = todo.delete()
        data = {}
        if delete:
            data['status'] = 'deleted'
            return Response(data, status = status.HTTP_200_OK)
        else:
            data['status'] = 'deleted failed'
            return Response(data, status = status.HTTP_400_BAD_REQUEST)

_data = [
    {
        "title" : "What is Computer ?",
        "subtitle" : "คอมพิวเตอร์คืออุปกรณ์ในการคำนวณและทำงานอื่น ๆ",
        "image_url" : "https://raw.githubusercontent.com/oatanurakch/BasicFlutterAPI/main/computer.jpg",
        "detail" : "เครื่องคำนวณอิเล็กทรอนิกส์โดยใช้วิธีทางคณิตศาสตร์ประกอบด้วยฮาร์ดแวร์ (ส่วนตัวเครื่องและอุปกรณ์) และซอฟต์แวร์ (ส่วนชุดคำสั่ง หรือโปรแกรมที่สั่งให้คอมพิวเตอร์ทำงาน) สามารถทำงานคำนวณผล และเปรียบเทียบค่าตามชุดคำสั่งด้วยความเร็วสูงอย่างต่อเนื่อง และอัตโนมัติ."
    },
    {
        "title" : "What is Python ?",
        "subtitle" : "เป็นภาษาเขียนโปรแกรมชนิดหนึ่ง",
        "image_url" : "https://raw.githubusercontent.com/oatanurakch/BasicFlutterAPI/main/Coding.jpg",
        "detail" : "ภาษาไพธอน (Python) เป็นภาษาการเขียนโปรแกรมระดับสูง ที่นำข้อดีของภาษาต่างๆ มารวมไว้ด้วยกัน ถูกออกแบบมาให้เรียนรู้ได้ง่าย และมีไวยากรณ์ที่ช่วยให้เขียนโค้ดสั้นกว่าภาษาอื่นๆ"
    },
    {
        "title" : "What is Flutter ?",
        "subtitle" : "มาเริ่มรู้จัก Flutter กันก่อน",
        "image_url" : "https://raw.githubusercontent.com/oatanurakch/BasicFlutterAPI/main/Flutter.jpg",
        "detail" : "Cross-Platform Framework ที่ใช้ในการพัฒนา Native Mobile Application (Android/iOS) พัฒนาโดยบริษัท Google Inc. โดยใช้ภาษา Dart ในการพัฒนา ที่มีความคล้ายกับภาษา C# และ Java."
    },
    {
        "title" : "What is Arduino ?",
        "subtitle" : "มาเริ่มรู้จัก Arduino กันก่อน",
        "image_url" : "https://raw.githubusercontent.com/oatanurakch/BasicFlutterAPI/main/Arduino.jpg",
        "detail" : "โครงการที่นำชิปไอซีไมโครคอนโทรลเลอร์ตระกูลต่างๆ มาใช้ร่วมกันในภาษา C ซึ่งภาษา C นี้เป็นลักษณะเฉพาะ คือมีการเขียนไลบารี่ของ Arduino ขึ้นมาเพื่อให้การสั่งงานไมโครคอนโทรลเลอร์ที่แตกต่างกัน สามารถใช้งานโค้ดตัวเดียวกันได้ โดยตัวโครงการได้ออกบอร์ดทดลองมาหลายๆรูปแบบ เพื่อใช้งานกับ IDE ของตนเอง"
    } 
]

def Home(request):
    return JsonResponse(data = _data, safe=False, json_dumps_params = {'ensure_ascii' : False})