from locust import HttpLocust, TaskSet

def landing(l):
  l.client.get("/")

def static(l):
  l.client.get("/assets/application-0f3fd9617b2c010dc96a7ae869e91c09.css")

class WebsiteTasks(TaskSet):
  tasks = { static: 2, landing: 1 }

  def on_start(self):
    static(self)

class WebsiteUser(HttpLocust):
  task_set = WebsiteTasks
  min_wait = 5000
  max_wait = 9000

