from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import os

options = Options()
options.add_argument("--headless")
options.add_argument("window-size=1920,2080")
driver = webdriver.Chrome(chrome_options=options,executable_path="/Users/james_kieley/Downloads/chromedriver")
driver.implicitly_wait(10) # seconds

driver.get('http://localhost:3000/login')
driver.find_element_by_css_selector('[name="user"]').send_keys("admin")
# driver.find_element_by_css_selector('name="password"').send_keys(os.environ['GRAFANA_PASS'])
driver.find_element_by_css_selector('[name="password"]').send_keys("im0MB0DWJaMs8HXPWceQWABV1PVlewP3wghpoooQ")
driver.find_element_by_css_selector('button').click()

driver.find_element_by_css_selector('[href="https://grafana.com/docs/grafana/latest?utm_source=grafana_gettingstarted"]')# wait for this element to be present (due to implicit wait)
driver.get('http://localhost:3000/d/GlXkUBGiz/kubernetes-pod-overview?orgId=1&refresh=5s&var-namespace=default&var-pod=&var-container=All')
driver.find_element_by_css_selector('[aria-label="TimePicker Open Button"]')# wait for this element to be present (due to implicit wait)
driver.find_element_by_css_selector('#panel-3 > div > div:nth-child(1) > div > div.panel-content > div > plugin-component > panel-plugin-graph > grafana-panel > ng-transclude > div > div.graph-panel__chart > canvas.flot-overlay')# wait for this element to be present (due to implicit wait)

driver.get_screenshot_as_file("/Users/james_kieley/git/thesis-kube-nfs/kubernetes/scaling-overflower/cluster-creation-scripts/promethius-grafana/postman-collection/screenshot/filename1.png")