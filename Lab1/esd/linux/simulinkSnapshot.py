import cv2
import numpy as np
import time
import mmap
import struct
import sys, random
import ctypes
import copy
from frameGrabber import ImageProcessing
from frameGrabber import ImageFeedthrough
from frameGrabber import ImageWriter

camProcessed = ImageProcessing()
camFeedthrough = ImageFeedthrough()
camWriter = ImageWriter()

simulink = True
if simulink == True:
    f1 = open("/dev/mem", "r+b")
    simulinkMem = mmap.mmap(f1.fileno(), 1000, offset=0x43c60000)
    simulinkMem.seek(0) 
    simulinkMem.write(struct.pack('l', 1))       # reset IP core
    simulinkMem.seek(8)                         
    simulinkMem.write(struct.pack('l', 1920))     # image width
    simulinkMem.seek(12)                        
    simulinkMem.write(struct.pack('l', 1080))     # image height
    simulinkMem.seek(16)                        
    simulinkMem.write(struct.pack('l', 2000))       #  horizontal porch
    simulinkMem.seek(20)                        
    simulinkMem.write(struct.pack('l', 1000))     #  vertical porch when reading from debug
    simulinkMem.seek(4) 
    simulinkMem.write(struct.pack('l', 1))       # enable IP core

time.sleep(1)
print "writing frame to FPGA"
data = np.zeros((1080,1920,8), dtype=np.uint8)
data[:,100,:] = 200 
data[:,1820,:] = 200 
data[100,:,:] = 200 
data[980,:,:] = 200 
camWriter.setFrame(data)
time.sleep(1)
camWriter.setFrame(data)
time.sleep(1)
camWriter.setFrame(data)

time.sleep(1)
frameLeft,frameRight = camProcessed.getStereoGray()
frameLeft,frameRight = camProcessed.getStereoGray()
frameLeft,frameRight = camProcessed.getStereoGray()
cv2.imwrite("left.jpg", frameLeft)
cv2.imwrite("right.jpg", frameRight)