# Assembly
### Assembly code/projects
#### Project Encrypt/Decrypt Message
This project is written in assembly MASM x86. The purpose of the project is to encrypt and decrypt a message from a .txt file.\
There are 3 levels of encryption and logically 3 levels of decryption. Each level of encryption is a unique one.
##### How to use the program
Prepare a message in the message.txt file. The maximum allowed length of the message is 200 bytes(this can easily be changed to a higher capacity). Compile the code and link it. When you boot the application you will see the message.  
>Enter an input  

If you enter **0** the program will exit.  
If you enter **1** the message will be encrypted (first level) and the encrypted version of the message will be printed.  
By entering **1** the message will keep encrypting to the second,third level and the encrypted message is displayed on the screen.  
If you enter **2** the message will be decrypted (not fully, only one level lower) and the decrypted version of the message will be displayed.
If anything else is inputed by the user, a message will be displayed and the program **won't** be interupted.  
If the user keeps entering **1** or **2** and reaches maximum level of encryption/decryption an appropriate message will be displayed without terminating the program.


