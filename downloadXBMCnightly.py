# Disclaimer: I don't really know python
import urllib2
from bs4 import BeautifulSoup

page = urllib2.urlopen('http://mirrors.xbmc.org/test-builds/android/?C=M;O=D')
soup = BeautifulSoup(page)

links = soup.body.find('div', attrs={'id': 'mirrorlist'}).find('pre').find_all('a')
for link in links:
	if 'hwaccel' in link.get('href') and not 'fulldebug' in link.get('href'):
		filename = link.get('href')
		f = urllib2.urlopen('http://mirrors.xbmc.org/test-builds/android/' + filename)
		output = open(filename, 'wb')
		output.write(f.read())
		output.close()
		print filename
		break