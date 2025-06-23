from django.test import TestCase
from django.contrib.auth.models import User
from home.models import AddStudent

class AddStudentModelTest(TestCase):
    def setUp(self):
        user = User.objects.create(username='testuser')
        user.set_password('12345')
        user.save()
        AddStudent.objects.create(user=user, sname="Mr Invincible", studentid="123456")

    def test_student_creation(self):
        student = AddStudent.objects.get(sname="Mr Invincible")
        self.assertEqual(student.sname, 'Mr Invincible')
        self.assertEqual(student.studentid, '123456')