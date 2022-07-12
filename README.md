# SP Airlines

***SP Airlines*** is an enterprise web application that allows booking of flights through SP Airlines. It implements shopping cart features in order 
for the website to conduct e-business on the web. The content and design elements of the website are original, but are coded based on the
Bootstrap 4 framework. 

## Preview

[Visit the Website (without database)](http://darrenweicheng.azurewebsites.net/)

## Usage

Clone this repository into any directory and follow the steps below.

**Eclipse (I/O File Feature)**

1. Import the project folder `spairlines`.
2. There is an I/O file feature in `files_aircraft/aircraftinsert.jsp`. 
3. Verify against files for the `WEB-INF` > `lib` are correctly imported. There should be the `commons-fileupload-1.3` and `commons-io-2.4`.
4. Open up the `aircraftbackend.jsp` and search for
`String filePath = "C:\\spairlines\\WebContent\\images\\";`.
5. Change the path to which you placed the `spairlines` folder in. 
6. You should be able to browse for a file from any part of your computer and upload to the servlet, and the image will be automatically be deposited into the images folder when inserting a new aircraft. 

**Eclipse (Email Feature)**

1. Continuing from above, there is an email feature in `files_guest/bk_confirmation.jsp`.
2. Verify against files for the `WEB-INF` > `lib` are correctly imported. There should be the `mail-1.47` and `activation-1-.1.1`. 

**MySQL**

1. Execute all the dump files in `spairlines_dumps` folder. 
2. It should create and populate all the required tables. 
3. Execute `spairlines_routines.sql` to create the stored routine for the userdelete feature meant for `files_admin/superuser.jsp`. 
4. Finally, in all the JSP files, check that the connection to the MySQL instance is verified using your password. The password in this case is `root`. 

## Acknowledgements 

- **Chua Han Yong Darren** | [@chydarren](https://github.com/chydarren)
- **Chng Wei Cheng** 

## Credits

This program was developed as an assignment for the Singapore Polytechnic, ST0291 Enterprise Application Development module. I have uploaded the source files publicly for reference and personal usage only. Please refrain from [plagiarising](https://www.sp.edu.sg/sp/student-services/ssc-overview/student-handbook/intellectual-property-copyright-and-plagiarism) or passing it off as your own work. 

Chua Han Yong Darren © 2017. Code released under the GNU Affero General Public License v3.0.
