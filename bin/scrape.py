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
from os import mkdir,chdir

# determine number of pages of results
# return: Int
def get_totalPages(url):
    # bring the page into BeautifulSoup
    source = requests.get(url).text
    soup = BeautifulSoup(source, 'lxml')

    # get table row containing page numbers
    pages_row = soup.find('td', class_='pages')

    pages_row_cells = pages_row.find_all('a')

    pages_row_cells_data = []

    for link in pages_row_cells:
        pages_row_cells_data.append(link.text)

    total_pages = 0

    for data in pages_row_cells_data:
        try:
            data = int(data)
        except:
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

    # get the list of galleries on page
    page_galleries = gallery_grid.find_all('div', class_='pic')

    # get the gallery tokens
    page_galleries_urls = []

    # construct the complete urls for galleries
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

    all_galleries = []

    # gather gallery links from all pages of results
    for url in pageURLS:
        print(f'Scoping {url}')
        all_galleries += page_galleries(url)

    # return list of gallery urls
    return all_galleries


# get list of image urls from single gallery page
# return: list
def get_galleryImageURLS(url):
    print('Resolving JavaScript')
    # create a new Firefox session
    # IMPORTANT: make sure the geckodriver is in our path
    try:
        driver = webdriver.Firefox()
    except:
        message = 'You forgot to install the geckodriver in your $PATH.\n ' 
        message += 'Get it Here: https://github.com/mozilla/geckodriver/releases'
        raise Exception(message)
    else:
        driver.implicitly_wait(40)
        driver.get(url)

        # make the url workable with BeautifulSoup
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



# read url from file and download it
def read_and_download(file, destination):
    try:
        mkdir(destination)
    except:
        raise Exception("Target directory already exists")
    else:
        with open(file, 'rt') as url_dump_file:
            # read url one by one
            for url in url_dump_file:
                #save the file with this name
                filename = url.split('/')[-1]

                #download and create the file
                print(f'\nDownloading {filename}')
                print(url)
                wget.download(url)


if __name__ == '__main__':
    #model_name = input('Enter Name: ').lower()
    model_name = 'laura_lion'

    # format the name of the model 
    #model_name = model_name.replace(' ', '_')

    #all_galleries = get_allGalleries(model_name)
    #for gallery in all_galleries:
        #print(gallery)

    all_galleries = ['https://fuskator.com/thumbs/i3l6tZ6UfCu/Busty-Shaved-Brunette-Laura-Lion-with-Hangers-from-Met-Art.html', 'https://fuskator.com/thumbs/mYh9pBjgsbb/Shaved-Laura-Lion-with-Big-Tits-Giving-Blowjob.html']

    # get urls of images from all galleries and dump them into a file
    dump_file = f'{model_name}.txt'

    #with open(dump_file, 'wt') as url_dump_file:
        #for gallery in all_galleries:
            #image_urls = get_galleryImageURLS(gallery)
            #for url in image_urls:
                #url_dump_file.write(f'{url}\n')


    # read urls from dump file and download them
    read_and_download(dump_file, model_name)
