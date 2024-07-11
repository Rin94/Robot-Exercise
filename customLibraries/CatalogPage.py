from robot.api.deco import library, keyword
from robot.libraries.BuiltIn import BuiltIn

@library
class CatalogPage(object):

    def __init__(self):
        self.selfLib = BuiltIn().get_library_instance("SeleniumLibrary")

    @keyword
    def check_expected_product_is_in_catalog(self, suggestionList):
        productsTitles = self.selfLib.get_webelements("XPATH://h5[contains(@class, 'card-title a-card-description')]")
        flag = True
        for product in productsTitles:
            actualString = product.text.upper().replace(" ", "")
            count = 0
            for expectedString in suggestionList:
                if expectedString.upper() in actualString:
                    print(actualString + " ---- is in -----"+expectedString)
                    break
                count = count + 1
                if count >= len(suggestionList):
                    print(actualString + " ---- is not -----" + expectedString)
                    flag = False
                    break
        return flag

    @keyword
    def check_price_in_product_catalog_is_more_than_expected_filter(self,filter, price_locator):
        productsPrices = self.selfLib.get_webelements(price_locator)
        filter = float(filter)
        flag = True
        for productPrice in productsPrices:
            price= productPrice.text.replace("$","").replace(",","")
            price=price[:-2]
            price = float(price)
            if price>filter:
                print(str(price) + " is greater than " + str(filter))
                flag = True
                continue
            else:
                print(str(price) + " is lower than " + str(filter))
                flag = False
                break
        return flag

    @keyword
    def check_count_results_in_catalog(self, count):
        count = int(count)
        productsTitles = self.selfLib.get_webelements("XPATH://h5[contains(@class, 'card-title a-card-description')]")
        return True if len(productsTitles)==count else False
