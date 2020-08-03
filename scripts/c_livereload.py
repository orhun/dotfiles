#!/usr/bin/env python3
# -*- coding: utf-8 -*-

'''
A program that recompiles and runs a C file when it's saved.
(Educational purposes)
'''

import time, os, sys 
from datetime import datetime
from watchdog.observers import Observer  
from watchdog.events import PatternMatchingEventHandler  
class LiveReloader(PatternMatchingEventHandler): 
    def __init__(self, mainfile):
        super().__init__()
        self.mainfile = mainfile
        self.tmp_path = 'tmp'
        if os.path.exists(self.tmp_path): os.remove(self.tmp_path)

    def process(self, event):
        if os.path.exists(self.mainfile.replace('.c', '')): os.remove(self.mainfile.replace('.c', ''))
        if self.mainfile in event.src_path and event.event_type == 'modified' and not event.is_directory:
            cfile = event.src_path.replace('./', '')
            if not os.path.exists(self.tmp_path):
                os.system('touch ' + self.tmp_path)
                print(get_time()+'Compiling ' + self.mainfile + '...')
                os.system('gcc '+cfile+' -o '+cfile.replace('.c', '')+' -w')
                if os.path.exists(cfile.replace('.c', '')):
                    print(get_time()+'Running...\n')
                    os.system('./'+cfile.replace('.c', ''))
                print('\n===============')
                print(get_time()+'Waiting for state changes..')
            else:
                os.remove(self.tmp_path)

    def on_modified(self, event):
        self.process(event)

def get_time():
    return '['+str(datetime.now().strftime('%H:%M:%S')) + '] '

def print_head():
    print("""
 .d8888b.  888      8888888b.  
d88P  Y88b 888      888   Y88b 
888    888 888      888    888 
888        888      888   d88P 
888        888      8888888P"  
888    888 888      888 T88b   
Y88b  d88P 888      888  T88b  
 "Y8888P"  88888888 888   T88b 
  C / Live Reloader ==========""")

def main():
    print_head()
    mainfile = input(get_time()+'C file (.c) to compile & run /w live reload: ')
    if mainfile.rsplit('.', 1) != 'c': mainfile=mainfile+'.c'
    if not os.path.exists(mainfile):
        print(get_time()+'C file not found. Exiting...')
        sys.exit()
    observer = Observer()
    observer.schedule(LiveReloader(mainfile), path=".")
    observer.start()
    print(get_time()+'Waiting for state changes..')
    try:
        while True:
            time.sleep(1.5)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()

if __name__ == '__main__':
   main()

