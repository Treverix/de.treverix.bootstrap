package de.treverix.pages

import static extension org.openqa.selenium.By.*
import de.treverix.support.SharedDriver

/**
* Page model for the registration page.
*/
class RegistrationPageModel {

    val extension SharedDriver driver

    new(SharedDriver driver) {
        this.driver = driver
    }

    def nameTxtBx() {
        // Makes use of xtends extension feature. The code is equal to:
        // driver.findElement(By.xpath('//input[@id="reg:name"]'))

        '//input[@id="reg:name"]'.xpath.findElement
    }

    def emailTxtBx() {
        '//input[@id="reg:email"]'.xpath.findElement
    }

    def phoneTxtBx() {
        '//input[@id="reg:phoneNumber"]'.xpath.findElement
    }

    def submitBtn() {
        '//input[@id="reg:register"]'.xpath.findElement
    }

    def restUrlLinks() {
        '//table[@class="simpletablestyle"]/tbody/tr/td[5]/a'.xpath.findElements
    }
}