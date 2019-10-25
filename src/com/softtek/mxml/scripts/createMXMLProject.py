import os
from shutil import copyfile
import errno
import os.path
from os import path

alreadyProcessed=path.exists("projectMXML.mxml")

##Creates an mxml project file

f= open("projectMXML.mxml","w+")
f.write("project Project { \r")
f.write("\t description: \"Some Description\"\r")
rootDir = '.'
counter = 0
for dirName, subdirList, fileList in os.walk(rootDir):
    print('Found directory: %s' % dirName)
    for fname in fileList:
        if fname.endswith(".mxml") and not fname.startswith("projectMXML.mxml") and not dirName.startswith(".\out") :
            print('\t%s' % fname)
            counter=counter + 1
            f.write("\t file %s " % (str(counter).rstrip() + "@_" + fname.split(".")[0]) +" \"%s\"  \r" % dirName.replace("\\","/") )
f.write("} \r")
f.close() 

##Updates each mxml file with a node called filename:PhysicalCurrentName

rootDir = '.'
counter = 0
for dirName, subdirList, fileList in os.walk(rootDir):
    print('Found directory: %s' % dirName)
    for fname in fileList:
        if fname.endswith(".mxml") and not fname.startswith("projectMXML.mxml") and not alreadyProcessed :
            print('\t%s' % fname)
            counter=counter + 1
            f = open(dirName+"\\"+fname, "r")
            contents = f.readlines()
            f.close()
            contents.insert(1, "<filename:" +  str(counter) + "@_" + fname.split(".")[0] + ">\r")
            f = open(dirName+"\\"+fname, "w")
            contents = "".join(contents)
            f.write(contents+"\r")
            f.write("</filename:" + str(counter) + "@_" + fname.split(".")[0] + ">\r")
            f.close()
         
   

#copytree('.', './out2', symlinks=False, ignore=None)

##Creates a copy of each mxml file into an output folder 
##Files to be processed by eclipse MXMLReader

if not os.path.exists('out'):
    try:
        os.makedirs('out', 0o700)
    except OSError as e:
        if e.errno != errno.EEXIST:
            raise
            
rootDir = '.'
outDir = '.\out'
counter = 0

for dirName, subdirList, fileList in os.walk(rootDir):
    print('Found directory OUT: %s' % dirName)
    for fname in fileList:
        if fname.endswith(".mxml") and not dirName.startswith(".\out") :
            print('\t%s' % fname)            
            copyfile(dirName+"\\"+fname, outDir+"\\"+str(counter) + "@_" +fname)
            counter=counter + 1
            