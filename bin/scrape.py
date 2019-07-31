#! /usr/bin/python3.6

"""
This script has following dependencies
1. BeautifulSoup4
2. LXML
3. Requests
4. Selenium
5. Wget

"""

from bs4 import BeautifulSoup
import requests
from selenium import webdriver
import wget
from os import mkdir
from sys import exit

# determine number of pages of results
# return: Int
def get_totalPages(url):
    # bring the page into BeautifulSoup
    source = requests.get(url).text
    soup = BeautifulSoup(source, 'lxml')

    # get table row containing page numbers
    pages_row = soup.find('td', class_='pages')
    pages_row_cells = pages_row.find_all('a')

	# contents of the cells containing page numbers
    pages_row_cells_data = []

    for link in pages_row_cells:
        pages_row_cells_data.append(link.text)

	# count total number of pages
    total_pages = 0
    for data in pages_row_cells_data:
        try:
			# if cell data converts to number it means that it is a page number
            data = int(data)
        except:
			# if conversion of cell data to number fails, it means there are no more page numbers
            break
        else:
            total_pages += 1

    return total_pages


# generate list of page urls
# return: list
def get_pageURLS(name, total_pages):
    pageURLS = []

    for page_number in range(1, total_pages+1 ):
        url = f'https://fuskator.com/page/{page_number}/{name}/'
        pageURLS.append(url)

    return pageURLS


# generate list of galleries on page from given url
# return: list
def page_galleries(url):
    # bring the page into BeautifulSoup
    source = requests.get(url).text
    soup = BeautifulSoup(source, 'lxml')

    # get the main section of the page
    gallery_grid = soup.find('div', id='content')

    # get the list of galleries on page (i.e. gallery tokens)
    page_galleries = gallery_grid.find_all('div', class_='pic')

    # construct the complete urls for galleries
    page_galleries_urls = []
    for gallery in page_galleries:
        gallery_token = gallery.a["href"]
        complete_url = f'https://fuskator.com{ gallery_token }'
        page_galleries_urls.append(complete_url)

    # return the list
    return page_galleries_urls


# tie everything together.
# 1. Count total number of pages of results
# 2. Generate the result page urls
# 3. Get the gallery urls from all result pages
# 4. Return the complete list of gallery urls
def get_allGalleries(model_name):
    # creater the search url
    search_url = f'https://fuskator.com/search/{model_name}/'

    # count total number of pages of results
    print('Scoping results')
    total_pages = get_totalPages(search_url)
    print(f'Total Pages: {total_pages}')

    # generate list of result page urls
    pageURLS = get_pageURLS(model_name, total_pages)

    # gather gallery links from all pages of results
    all_galleries = []

    for url in pageURLS:
        print(f'Scoping {url}')
        all_galleries += page_galleries(url)

    # return list of gallery urls
    return all_galleries


# get list of image urls from single gallery page
# return: list
def get_galleryImageURLS(url):
	print('Resolving JavaScript and ', end='')
	# create a new Browser session
	try:
		options = webdriver.ChromeOptions()
		# headless means the browser will be invisible
		options.add_argument("headless")
		driver = webdriver.Chrome(chrome_options=options)
	except:
		message = 'Chromedriver is not available in your $PATH.' 
		raise Exception(message)
	else:
		driver.implicitly_wait(40)
		driver.get(url)

		# bring the completed page into BeautifulSoup
		print('Scoping the gallery')
		soup = BeautifulSoup(driver.page_source, 'lxml')

		# close the driver window
		driver.close()

		# get the relevant section of the page
		thumbs_grid = soup.find('div', id='thumbimages')

		#get urls of gallery images
		gallery_images = thumbs_grid.find_all('div', class_='pic')

		image_urls = []

		for image in gallery_images:
			url = f'https:{image.a["href"]}'
			image_urls.append(url)

		return image_urls



# create the image url dump file
def create_dump(model_name, dump_file):
    all_galleries = get_allGalleries(model_name)

    # counters for showing progress
    total_galleries = len(all_galleries)
    current_gallery = 1

    with open(dump_file, 'wt') as url_dump_file:
        for gallery in all_galleries:
            print(f'({current_gallery}/{total_galleries}) ', end='')
            image_urls = get_galleryImageURLS(gallery)
            current_gallery += 1
            for url in image_urls:
                url_dump_file.write(f'{url}\n')



# read url from file and download it
def read_and_download(file, destination):
    try:
        mkdir(destination)
    except:
        pass
    finally:
        with open(file, 'rt') as url_dump_file:
            # read url one by one
            for url in url_dump_file:
                #save the file with this name
                filename = url.split('/')[-1]
                retries = 0

                while True:
                    try:
                        #download and create the file
                        #print(f'\nDownloading {filename}')
                        wget.download(url.strip(), f'{destination}/{filename}')
                    except:
                        retries += 1
                        if retries == 3:
                            break


if __name__ == '__main__':
	model_name = input('Enter Name: ').lower()
	# format the name of the model 
	model_name = model_name.replace(' ', '_')

	# options menu
	print('Select Option:')
	print('1. Generate Images URL Dump')
	print('2. Download Images from Dump')
	print('3. Both Option 1 & 2')
	print('4. Exit')

	# get the selection from the user
	while True:
		try:
			selection = int(input('Selection: '))
			break
		except:
			print('Error: Invalid Input')

	# name of the dump file
	dump_file = f'{model_name}.txt'

	try:
		# case the selection
		if selection == 1:
			# create the dump of image urls
			create_dump(model_name, dump_file)
		elif selection == 2:
			# read urls from dump file and download them
			read_and_download(dump_file, model_name)
		elif selection == 3:
			create_dump(model_name, dump_file)
			read_and_download(dump_file, model_name)
		elif selection == 4:
			print('Exiting ...')
			exit(0)
		else:
			raise Exception('Invalid Input')
			exit(1)
	except Exception as err:
		print(f'Error: {err}')
