# need to install pdfminer.six from condaforge. and discord.py for spot from condaforge.

from io import StringIO
import os
import pathlib
import sys
import threading

from pdfminer.converter import TextConverter
from pdfminer.layout import LAParams
from pdfminer.pdfdocument import PDFDocument
from pdfminer.pdfinterp import PDFResourceManager, PDFPageInterpreter
from pdfminer.pdfpage import PDFPage
from pdfminer.pdfparser import PDFParser

from ebooklib import epub

from tqdm import tqdm

from spot import Spot


def get_dir_path(dir_path=""):
    if dir_path == "" and len(sys.argv) > 1 != None:
        dir_path = sys.argv[1]

    if dir_path == "" or dir_path == None:
        dir_path = input("Please point to directory (Default is '.'): ")

    if dir_path == "" or dir_path == None:
        dir_path = "."

    if not os.path.exists(dir_path):
        print("Path " + str(dir_path) + "does not exist. Stopping...")
        sys.exit()

    return pathlib.Path(dir_path)


dir_path = get_dir_path()


def gather_files(dir_path, ext):
    files = []
    for file_name in os.listdir(dir_path):
        if file_name.endswith(ext):
            files.append(os.path.join(dir_path, file_name))
    print("Found " + str(len(files)) + " PDF" + ("." if len(files) == 1 else "s."))

    return files

pdfs = gather_files(dir_path, ".pdf")

if (len(pdfs) == 0):
    sys.exit()

def get_substrings():
    substrings = []
    while len(substrings) == 0:
        substrings = input("Enter substring (separator: ,): ").lower().split(",")
        for idx, sub in enumerate(substrings):
            substrings[idx] = sub.strip()
        if len(substrings) == 0:
            print("substring can't be empty.")

    return substrings


substrings = get_substrings()

results = ["" for _ in pdfs]
loaded = 0

spot = Spot("config.json")



def readPdf(file_name):
    desc = os.path.basename(file_name)
    output_string = StringIO()
    with open(file_name, "rb") as input_file:
        parser = PDFParser(input_file)
        document = PDFDocument(parser)
        resourcemanager = PDFResourceManager()
        device = TextConverter(resourcemanager, output_string, laparams=LAParams())
        interpreter = PDFPageInterpreter(resourcemanager, device)

        first = True
        for idx, page in enumerate(PDFPage.create_pages(document)):
            interpreter.process_page(page)
            for substring in substrings:
                if substring in output_string.getvalue().lower():
                    if first:
                        spot.message(desc)
                        spot.message(str(idx) + ": " + substring)
                        first = False

                output_string.seek(0)
                output_string.truncate(0)

def readEpub(file_name, desc):
    desc = os.path.basename(file_name)
    with epub.read_epub(file_name) as input_file:
        input_file

def checkFile(file_name):
    global spot

    if file_name.endswith(".pdf"):
        readPdf(file_name)
    if file_name.endswith(".epub"):
        readEpub(file_name)

total = 0
finished = 0
spot.message("Start looking for: " + ",".join(substrings))
try:
    for position, pdf_path in enumerate(tqdm(pdfs)):
        checkFile(pdf_path)
        finished += 1
finally:
    with Spot("config.json") as spot:
        spot.message("I am done.")
    spot.exit()
