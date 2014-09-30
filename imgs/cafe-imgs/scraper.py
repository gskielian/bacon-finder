from lxml import html
import requests



page = requests.get('http://menu-mtv-masa.blogspot.com/')
tree = html.fromstring(page.text)

#This will create a list of buyers:
buyers = tree.xpath('//div[@title="buyer-name"]/text()')
