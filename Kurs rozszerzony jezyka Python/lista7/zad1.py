from bs4 import BeautifulSoup
import urllib.request
import re
import collections
import threading
import concurrent.futures

def get_links(url):
    links = set()

    try:
        page = urllib.request.urlopen(url)
    except urllib.request.HTTPError as e:
        return links

    soup = BeautifulSoup(page, "html.parser")
    for href in soup.find_all('a'):
        link = href.get('href')
        if re.match('http',str(link)):
            links.add(link)
    return links



def crawl(start_page, distance, action):
    visited, to_visit = set(start_page), collections.deque([(start_page,distance)])
    lock = threading.Lock()
    def add(link):
        with lock:
            if link not in visited:
                to_visit.append((link, dist - 1))
                visited.add(link)

    while to_visit:
        url,dist = to_visit.popleft()
        with concurrent.futures.ThreadPoolExecutor() as executor:
            future = executor.submit(action,url)
            res = future.result()
        yield (url, res)
        if dist > 0:
            with concurrent.futures.ThreadPoolExecutor() as executor:
                future = executor.submit(get_links,url)
                links = future.result()
                executor.map(add, links)


def find_all_python(url):
    try:
        page = urllib.request.urlopen(url)
    except urllib.request.HTTPError as e:
        return e

    soup = BeautifulSoup(page, "html.parser")
    blacklist = ['style', 'script', 'head', 'title', 'meta', '[document]']
    data = [t for t in soup.findAll(text=True) if t.parent.name not in blacklist]
    pattern = re.compile(r'([A-Z][^.!?]*Python[^.!?]*[.!?])')
    result = pattern.findall(u" ".join(t.strip() for t in data))

    return len(result)




c = crawl("https://pl.wikipedia.org/wiki/Python",2,find_all_python)

for i in c:
    print(i)
