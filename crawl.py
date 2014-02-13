import argparse
import itertools
import re
import sys
import time

import requests

LIST_RE = re.compile(r'<a rel:gtrack_id="post/title" .*? href="(.*?)" .*?>(\d+ .*?)</a>')
PAGE_URL = 'http://www.buzzfeed.com/index/paging?r=1&p={}'

class BuzzfeedList:
    def __init__(self, title, url):
        self.title = title
        self.url = url

        self.n = int(title.split()[0])

    def __repr__(self):
        return 'BuzzfeedList({}, {})'.format(repr(self.title), repr(self.url))

def lists(lines):
    for line in lines:
        matches = LIST_RE.findall(line)
        if matches:
            yield BuzzfeedList(matches[0][1], matches[0][0])

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--page', type=int, default=1,
                        help='resume from a particular page')
    args = parser.parse_args()

    urls = set()

    for i in itertools.count(args.page):
        url = PAGE_URL.format(i)
        print(url, file=sys.stderr)
        lines = requests.get(url).text.splitlines()
        for l in lists(lines):
            if l.url in urls:
                print('duplicate url', url, file=sys.stderr)
            else:
                print('\t'.join((str(l.n), l.title, l.url)))
        time.sleep(1)

if __name__ == '__main__':
    main()
