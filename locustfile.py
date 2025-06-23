from locust import HttpUser, TaskSet, task
from bs4 import BeautifulSoup

class StudentTaskSet(TaskSet):
    def on_start(self):
        self.get_csrf_token()

    def get_csrf_token(self):
        response = self.client.get("/addstudent/") 
        soup = BeautifulSoup(response.text, 'html.parser')
        self.csrf_token = soup.find('input', {'name': 'csrfmiddlewaretoken'})['value']

    @task
    def add_student(self):
        self.client.post("/addstudent/", {
            "sname": "Test Student",
            "studentid": "ST12345",
            "csrfmiddlewaretoken": self.csrf_token  
        })

    @task
    def view_students(self):
        self.client.get("/viewstudents/")

class WebsiteUser(HttpUser):
    tasks = [StudentTaskSet]
    min_wait = 1000
    max_wait = 2000
