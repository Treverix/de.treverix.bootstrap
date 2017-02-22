package de.treverix.page

import org.openqa.selenium.WebDriver
import static extension org.openqa.selenium.By.*

/**
* Page model for the registration page.
*/
class RegistrationPageModel {

    def nameTxtBx(extension WebDriver driver) {
        // Makes use of xtends extension feature. The code is equal to:
        // driver.findElement(By.xpath('//input[@id="reg:name"]'))

        '//input[@id="reg:name"]'.xpath.findElement
    }

    def emailTxtBx(extension WebDriver driver) {
        '//input[@id="reg:email"]'.xpath.findElement
    }

    def phoneTxtBx(extension WebDriver driver) {
        '//input[@id="reg:phoneNumber"]'.xpath.findElement
    }

    def submitBtn(extension WebDriver driver) {
        '//input[@id="reg:register"]'.xpath.findElement
    }

    def restUrlLinks(extension WebDriver driver) {
        '//table[@class="simpletablestyle"]/tbody/tr/td[5]/a'.xpath.findElements
    }
}