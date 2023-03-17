First draft version of Robot Framework POC - Ready to be used for other projects

Installation: 
To install Robot Framework, you can follow these steps:

1. Install Python: 
    Robot Framework is a Python-based automation framework, so you will need to have Python installed on your system. 
    You can download the latest version of Python from the official website at https://www.python.org/downloads/

2. Install pip: 
    Pip is a package manager for Python. 
    You can install it by downloading the get-pip.py file from https://bootstrap.pypa.io/get-pip.py and running it using Python. 
    Open a terminal or command prompt and navigate to the directory where you downloaded the get-pip.py file. 

3. Install Robot Framework: 
    Once you have pip installed, you can use it to install Robot Framework. 
    Open a terminal or command prompt and run the following command:
                pip install robotframework

4. Install Selenium library: 
    To use Robot Framework for web testing, you will need to install the Selenium library. 
    To install it, run the following command:
                pip install robotframework-seleniumlibrary

That's it! You should now have Robot Framework installed on your system. 



To verify the installation, you can run the following command in a terminal or command prompt:
                robot --version


Usage and Execution: 
*.robotFiles are used to run the test cases 
*.resources files can be used to store the object ObjectRepository and common functions that you will be using.