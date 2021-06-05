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
from pdfminer.pdfinterp import resolve1

from tqdm import tqdm

from spot import Spot

multi = False
print("Multithreading is " + ("active" if multi else "inactive"))

dir_path = ""
if len(sys.argv) > 1:
    dir_path = sys.argv[1]

if dir_path == "" or dir_path == None:
    dir_path = input("Please point to directory (Default is '.'): ")

if dir_path == "" or dir_path == None:
    dir_path = "."

dir_path = pathlib.Path(dir_path)

if not os.path.exists(dir_path):
    print("Path " + str(dir_path) + "does not exist. Stopping...")
    sys.exit()

pdfs = []
for file_name in os.listdir(dir_path):
    if file_name.endswith(".pdf"):
        pdfs.append(os.path.join(dir_path, file_name))
print("Found " + str(len(pdfs)) + " PDF" + ("." if len(pdfs) == 1 else "s."))

substrings = input("Enter substring (separator: ,): ").lower().split(",")
for idx, sub in enumerate(substrings):
    substrings[idx] = sub.strip()

if len(substrings) == 0:
    print("substring can't be empty.")
    sys.exit()

results = ["" for _ in pdfs]
loaded = 0

spot = Spot("config.json")


def readPdf(input_file):
    output_string = StringIO()
    parser = PDFParser(input_file)
    document = PDFDocument(parser)
    resourcemanager = PDFResourceManager()
    device = TextConverter(resourcemanager, output_string, laparams=LAParams())
    interpreter = PDFPageInterpreter(resourcemanager, device)

    return interpreter, document, output_string


def checkFile(pdf_path, position, progress):
    global finished
    global loaded
    global results
    global total
    global spot

    with open(pdf_path, "rb") as input_file:
        desc = os.path.basename(pdf_path)
        results[position] += desc + ": \n"

        interpreter, document, output_string = readPdf(input_file)

        loaded += 1
        progress.desc = "Last added " + desc
        progress.postfix = (
            " (" + str(finished) + "/" + str(loaded) + "/" + str(len(pdfs)) + ")"
        )

        progress.total += resolve1(document.catalog["Pages"])["Count"]
        first = True
        for idx, page in enumerate(PDFPage.create_pages(document)):
            progress.update()
            interpreter.process_page(page)
            for jdx, substring in enumerate(substrings):
                if substring in output_string.getvalue().lower():
                    if first:
                        spot.message(desc)
                    spot.message(str(idx) + ": " + substring)
                    first = False

            output_string.seek(0)
            output_string.truncate(0)


threads = []

total = 0
finished = 0
progress = tqdm(total=total, unit="pages")
spot.message("Start looking for: " + ", ".join(substrings))
try:
    if multi:
        for position, pdf_path in enumerate(pdfs):
            threads.append(
                threading.Thread(target=checkFile, args=(pdf_path, position, progress))
            )
            position += 1

        for thread in threads:
            thread.start()

        for thread in threads:
            thread.join()
            finished += 1
            progress.postfix = (
                " (" + str(finished) + "/" + str(loaded) + "/" + str(len(pdfs)) + ")"
            )

    else:
        for position, pdf_path in enumerate(pdfs):
            checkFile(pdf_path, position, progress)
            finished += 1
finally:
    progress.close()

    with Spot("config.json") as spot:
        spot.message("I am done.")
    spot.exit()

