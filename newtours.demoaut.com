package SeleniumTest;

import org.testng.annotations.BeforeTest;
import org.testng.annotations.DataProvider;
import org.testng.annotations.Test;
import org.openqa.selenium.*;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.ui.Select;
import org.testng.*;



public class NewTest {
	public WebDriver driver;
	public String baseUrl;
//	String userName = "Romy";
		@DataProvider(name="userName")
		public Object[][] data(){
			return new Object[][]{
					{"Romy"},
					{"Harry"}
					};
		}
	@BeforeTest
	public void setup(){
		driver = new FirefoxDriver();
		baseUrl = "http://newtours.demoaut.com";
		
	}
	
	@Test(dataProvider="userName")
	    public void newUserRegistration(String userName)
		{
	  	  
	  	 // WebDriver driver = new FirefoxDriver();
	  	  driver.get(baseUrl);
	  	  driver.findElement(By.linkText("REGISTER")).click();
	  	driver.findElement(By.name("firstName")).sendKeys("Romy");
	  	driver.findElement(By.name("lastName")).sendKeys("Singh");
		driver.findElement(By.name("phone")).sendKeys("123456");
		driver.findElement(By.name("userName")).sendKeys("romy21raman");
		driver.findElement(By.name("address1")).sendKeys("HomesweetHome");
		driver.findElement(By.name("city")).sendKeys("dreamland");
		driver.findElement(By.name("state")).sendKeys("California");
		driver.findElement(By.name("postalCode")).sendKeys("00000"); 
		Select sel = new Select(driver.findElement(By.name("country")));
		sel.selectByValue("2");
		driver.findElement(By.name("email")).sendKeys(userName);
		driver.findElement(By.name("password")).sendKeys("1234Hello.");
		driver.findElement(By.name("confirmPassword")).sendKeys("1234Hello.");
		driver.findElement(By.name("register")).click();
		
		String actual = driver.findElement(By.xpath("//a/font/b")).getText();
		String expected = "Note: Your user name is " + userName + ".";
		Assert.assertEquals(actual, expected);
		}
		
	
	@Test
	public void bookFlight(){
		driver.findElement(By.linkText("Flights")).click();
	}
	    }
	  

  
