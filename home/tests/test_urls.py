from django.test import SimpleTestCase
from django.urls import reverse, resolve
from home.views import addstudent, viewstudents

class TestUrls(SimpleTestCase):
    def test_addstudent_url_resolves(self):
        url = reverse('addstudent')
        self.assertEqual(resolve(url).func, addstudent)

    def test_viewstudents_url_resolves(self):
        url = reverse('viewstudents')
        self.assertEqual(resolve(url).func, viewstudents)